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

enum { BUFFER_SIZE = 2048 ,TEXT_SIZE = 512};

/*Returns zeros of a provided file descriptor*/
int
countzeros(int fd){
    int zeros = 0;
    int i;
    int bytes_read = 0;
    char buffer[BUFFER_SIZE];
    memset(buffer, 1, BUFFER_SIZE);
    do {
        if((bytes_read = read(fd,buffer,BUFFER_SIZE)) == -1)
            err(1,"ERROR: program failed reading current file");
        if (bytes_read != 0){
            for (i = 0;i<BUFFER_SIZE ; i++){
                if (buffer[i] == 0)
                    zeros++;
            }
        }
    }while (bytes_read != 0);
    return zeros;
}

/*Scans provided dir files to obtain its zero number*/
void
scan_dir(char *dir,int fd_zeros){
    DIR *currentdir;
    struct dirent *direntry;
    int entry;
    char file[TEXT_SIZE] ;
    char data[TEXT_SIZE] ;
    if((currentdir = opendir(dir)) == NULL)
        err(1,"ERROR :Cannot open provided directory");
    do{
        if ((direntry = readdir(currentdir)) == NULL){
            break;
        }
        if (direntry -> d_type == DT_REG && strcmp(direntry -> d_name,"z.txt")!=0) {
            sprintf(file, "%s%s", dir,direntry -> d_name);
            if((entry = open(file, O_RDONLY)) == -1)
                err(1,"ERROR: Program failed opening %s",direntry -> d_name);
            sprintf(data, "%d     %s\n", countzeros(entry),direntry -> d_name);
            if (write(fd_zeros,data, strlen(data)) < strlen(data))
                err(1,"ERROR: Program failed writing zeros on z.txt");
            close(entry);
        }
    }while(direntry != NULL);
    free (currentdir);
}


int
main(int argc, char * argv[]){
    struct stat statbuf;
    char file[TEXT_SIZE] ;
    int entry;
    if (argc != 2)
        errx(1,"ERROR: Not enough arguments");
    if (stat(argv[1], &(statbuf)) != 0)
        err (1,"ERROR: Failed looking for type of file");
    if((statbuf.st_mode & S_IFMT) != S_IFDIR)
        errx(1,"ERROR: %s is not a directory",argv[1]);
    sprintf(file, "%s%s", argv[1],"z.txt");
    entry = open(file, O_CREAT | O_TRUNC | O_WRONLY, 0666);
    if (entry == -1)
        err(1,"ERROR: Cannot open or create z.txt");
    scan_dir(argv[1],entry);
    close(entry);
    exit(0);
}
