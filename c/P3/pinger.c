#include <stdlib.h>
#include <stdio.h>
#include <err.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

void ping(char * host){
    switch(fork()){
        case -1:
            err(1,"ERROR:");
        case 0:
            execl("/bin/ping","ping","-c","1","-W","5",host,NULL);
            err(1,"ERROR:");
    }
}

void wait_sons(int *flag){
    int status = 0;
    while(wait(&(status)) != -1){
        if (WEXITSTATUS (status) != 0){
            *(flag) = 1;
        }
    }
}

int main(int argc,char *argv[]){
    uint i;
    int flag = 0;
    if(argc == 1){
        errx(1,"ERROR: Not enough arguments");
    }
    for (i=1;i<argc;i++){
        ping(argv[i]);
    }
    wait_sons(&(flag));
    exit(flag);
}
