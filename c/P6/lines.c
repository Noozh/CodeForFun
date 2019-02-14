#include <stdlib.h>
#include <stdio.h>
#include <err.h>
#include <errno.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <dirent.h>

#define EXTENSION ".txt"

enum {PATH_SIZE = 256,};

int
istxt(char *file){
    char *ext;
    int equal = 1;
    ext = strrchr(file,'.');
    if (ext != NULL)
        equal = strcmp(EXTENSION,ext);
    return equal;
}

void
scanfile(char *file,char *str,int fd_dest){
    int fd_error;
    switch(fork()){
        case -1:
            err(1,"ERROR: Cannot fork");
        case 0:
            fd_error = open("/dev/null", O_WRONLY , 0666);
            dup2(fd_dest,1);
            dup2(fd_error,2);
            close(fd_dest);
            close(fd_error);
            execl("/bin/fgrep","fgrep",str,file,NULL);
            err(1,"ERROR: Cannot execl");
    }
}

int
waitscanner(){
    int status = 0;
    wait(&(status));
    return WEXITSTATUS(status);
}

int
scan_dir(DIR *currentdir,char *dir,char *str,int fd_dest){
    struct dirent *direntry;
    char *file = malloc (PATH_SIZE);
    int state = 0;
    do{
        if ((direntry = readdir(currentdir)) == NULL){
            break;
        }
        if (direntry -> d_type == DT_REG && istxt(direntry -> d_name) == 0){
            sprintf(file, "%s/%s", dir,direntry -> d_name);
            scanfile(file,str,fd_dest);
            state = waitscanner ();
            if (state == 2)
                break;
        }
    }while(direntry != NULL);
    free(file);
    return state;
}

int
look_into_dir(char *dir,char *str,int fd_dest){
    DIR *currentdir;
    int state;
    if((currentdir = opendir(dir)) == NULL)
        err(1,"ERROR :Cannot open provided directory");
    state=scan_dir(currentdir,dir,str,fd_dest);
    closedir (currentdir);
    return state;
}

void
arg_control(int argc, char* argv[]){
    struct stat statbuf;
    if (argc != 3)
        errx(1,"ERROR: Not enough arguments");
    if(stat(argv[2], &(statbuf)) != 0)
        err (1,"ERROR: Failed looking for type of file");
    if((statbuf.st_mode & S_IFMT) != S_IFDIR)
        errx(1,"ERROR: %s is not a directory",argv[2]);
}

int
main(int argc, char * argv[]){
    char *file = malloc (PATH_SIZE);
    int fd_dest,exit_state;
    arg_control(argc,argv);
    sprintf(file,"%s/../lines.out",argv[2]);
    fd_dest = open(file, O_CREAT | O_TRUNC | O_WRONLY |O_CLOEXEC , 0666);
    if (fd_dest == -1)
        err(1,"ERROR: Cannot open or create lines.out");
    exit_state=look_into_dir(argv[2],argv[1],fd_dest);
    close(fd_dest);
    if (exit_state == 2){
        unlink(file);
        free(file);
        errx (1,"ERROR: Something failed during directory was scanning");
    }
    free(file);
    exit(0);
}
