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

enum { BUFFER_SIZE = 2048 ,};

int
unzip_data(){
    int fd[2];
    pipe(fd);
    //fd[0] -> for using read end
    //fd[1] -> for using write end
    switch(fork()){
        case -1:
            err(1,"ERROR: Cannot fork");
        case 0:
            dup2(fd[1],1);
            close(fd[1]);
            execl("/bin/gunzip","gunzip",NULL);
            err(1,"ERROR: Cannot execl");
    }
    close(fd[1]);
    return fd[0];
}

void
push_buffer(char *buffer,int fd_dest,int n_bytes){
    printf("%s",buffer);
    if(write(fd_dest, buffer, n_bytes < n_bytes))
        err(1,"ERROR: Failed trying to write at provided file descriptor");
}

void
read_pipe(int fd_dest){
    char buffer[BUFFER_SIZE];
    long unsigned int bytes_read ;
    do {
        memset(buffer, 0, BUFFER_SIZE);
        bytes_read = read(0,buffer,BUFFER_SIZE);
        if( bytes_read == -1)
            err(1,"ERROR: program failed reading current file");
        if (bytes_read != 0)
            push_buffer(buffer,fd_dest,bytes_read);
    }while (bytes_read != 0);
}

int
main(int argc, char *argv[]){
    int fd_dest,fd_rpipe;
    int status = 0;
    if(argc != 2)
        errx(1,"ERROR:Insert just two arguments");
    fd_rpipe=unzip_data();
    dup2 (fd_rpipe,0);
    close(fd_rpipe);
    fd_dest = open(argv[1], O_CREAT | O_TRUNC | O_WRONLY , 0666);
    if (fd_dest == -1)
        err(1,"ERROR: Cannot open or create lines.out");
    read_pipe(fd_dest);
    wait(&(status));
    if(WEXITSTATUS(status) == 1)
        errx(1,"ERROR: gunzip didn't properly work");
    close(fd_dest);
    exit(0);
}
