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

enum { BUFFER_SIZE = 2048 , MAX_FILES = 256 ,};

typedef struct pipe_elems{
       FILE *streams[MAX_FILES];
       int size ;
} pipe_elems;

void
open_fout(int num_file, char *args[], int col[] ) {
    int i;
    for(i = 0;i < num_file;i++){
        col[i] = open(args[i], O_CREAT | O_TRUNC | O_WRONLY , 0666);
        if (col[i] == -1)
            err(1,"ERROR: Cannot open or create %s",args[i]);
    }
}

int
gziper(int fd_dest,int n_pipes ,int *fdw){
    int fd[2];
    int  i = 0;
    pipe(fd);
    //fd[0] -> for using read end
    //fd[1] -> for using write end
    switch(fork()){
        case -1:
            err(1,"ERROR: Cannot fork");
        case 0:
            /* Closing write point of other child proccess*/
            for(i = 0; i <  n_pipes ;i++){
                close(fdw[i]);
            }
            /* Stdin --> read_pipe */
            close(fd[1]);
            dup2(fd[0],0);
            close(fd[0]);
            /* Stdout --> fd_dest*/
            dup2(fd_dest,1);
            execl("/bin/gzip","gzip",NULL);
            err(1,"ERROR: Cannot execl");
    }
    close(fd[0]);
    return fd[1];
}

void
open_streams(int *fd_out,pipe_elems *pipes , int n_pipes){
    int i;
    int fdw[n_pipes];
    (*pipes).size = 0;
    for(i = 0; i <  n_pipes ;i++){
        fdw[i] = gziper(fd_out[i],(*pipes).size,fdw);
        (*pipes).streams[i] = fdopen(fdw[i],"w");
        (*pipes).size++;
    }
}

int
push(int bytes,char *buffer,FILE *stream){
    if(fwrite( buffer, 1, bytes, stream ) < bytes)
        err(1,"ERROR: Cannot write");
    return bytes;
}

void
resize_buf(char* buff, int bytes){
    int i;
    for (i = 0; i < BUFFER_SIZE - bytes ; i++){
        buff[i]=buff[i+bytes];
    }
}

int
next (pipe_elems w_pipes,int current){
    int i = current;
    if (current < w_pipes.size - 1)
        i++;
    else
        i = 0;
    return i;
}

void
demux(int block_size, pipe_elems w_pipes){
    int bytes_read,last_bytes;
    int pushed_bytes = 0;
    int i = 0;
    char buffer[BUFFER_SIZE];
    do{
        if((bytes_read = fread(buffer,1,BUFFER_SIZE,stdin))< 0)
            err(1, "cannot read");
        if (bytes_read > block_size) {
            while (bytes_read > block_size){
                push(block_size - pushed_bytes,buffer,w_pipes.streams[i]);
                resize_buf(buffer,block_size - pushed_bytes);
                bytes_read = bytes_read - block_size + pushed_bytes;
                pushed_bytes = 0;
                i = next(w_pipes,i);
            }
            pushed_bytes=push(bytes_read,buffer,w_pipes.streams[i]);
        }else if(bytes_read <= block_size && bytes_read != 0){
            if(pushed_bytes + bytes_read < block_size){
                pushed_bytes += push(bytes_read,buffer,w_pipes.streams[i]);
            }else{
                last_bytes = block_size - pushed_bytes;
                push(last_bytes,buffer,w_pipes.streams[i]);
                i = next(w_pipes,i);
                resize_buf(buffer, last_bytes);
                push(BUFFER_SIZE-last_bytes,buffer,w_pipes.streams[i]);
                pushed_bytes = BUFFER_SIZE-last_bytes ;
            }
        }
    }while(!feof(stdin));
}

void
close_fout(int num_file, int col[]){
    int i;
    for(i = 0;i < num_file;i++){
        if (close(col[i]) == -1)
            err(1,"ERROR: Cannot cannot close %d file descriptor", col[i]);
    }
}

void
close_pipes(int num_file , FILE *pipes[]){
    int i;
    for(i = 0;i < num_file;i++){
        if (fclose(pipes[i]) == -1)
            err(1,"ERROR: Cannot cannot close provided stream");
    }
}

int
wait_sons(){
    int status;
    int i = 0;
    while(wait(&(status)) != -1){
        if (WIFEXITED(status)){
            if (WEXITSTATUS (status) != 0)
                i++;
        }
    }
    return i;
}

int
main(int argc, char *argv[]){
    pipe_elems w_pipes;
    int block_size;
    int fd_out[MAX_FILES];
    if (argc < 2)
        errx (1,"ERROR: Not enough parameters");
    if ((block_size = atoi(argv[1])) < 1)
        errx(1,"ERROR: Block size must be greater than 0");
    argv += 2;
    argc -= 2;
    if (argc > MAX_FILES)
        errx(1,"ERROR: Too many output files");
    open_fout(argc, argv,fd_out);
    open_streams(fd_out,&(w_pipes),argc);
    demux(block_size,w_pipes);
    close_fout(argc,fd_out);
    close_pipes(argc,w_pipes.streams);
    if(wait_sons() != 0)
        errx(1,"ERROR: One or more childs didnt work");
    exit(0);
}
