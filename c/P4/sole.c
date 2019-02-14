#include <stdlib.h>
#include <stdio.h>
#include <err.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

/*  Type declaration   */

typedef struct node_id {
       int pid;
       char * file;
       int state;
} node_id;

/*  Const declaration   */

enum { MAX_FILES = 100 };

void cmp(char * file_1,char * file_2){
    switch(fork()){
    case -1:
        err(1,"ERROR:");
    case 0:
        execl("/usr/bin/cmp","cmp","-s",file_1,file_2,NULL);
        err(1,"ERROR:");
    }
}

int wait_grandsons(){
    int status = 0;
    int flag = 0;
    while(wait(&(status)) != -1){
        if (WIFEXITED(status)){
            if (WEXITSTATUS (status) == 0){
                flag = 1;
            }
        }
    }
    return flag;
}

void proccess_file (char * file,char *argv[],int count){
    int i;
    for (i=1;i < count ; i++) {
        if (file != argv[i]) {
            cmp(file,argv[i]);
        }
    }
}

void build_cmp_node(char *file,char *argv[],int count,node_id *node_list_id){
    (*node_list_id).file = file;
    switch((*node_list_id).pid = fork()){
    case -1:
        err(1,"ERROR:");
    case 0:
        proccess_file(file,argv,count);
        exit(wait_grandsons());
    }
}

void wait_sons(int count,node_id node_list_id[]){
    int i,status;
    for (i = 0;i < count;i++){
        waitpid(node_list_id[i].pid,&(status),0);
        if (WEXITSTATUS (status) == 1){
            node_list_id[i].state = 1;
        }else{
            node_list_id[i].state = 0;
        }
    }
}

void print_output(node_id node_list_id [],int length){
    int i;
    for(i = 0;i < length; i++){
        if (node_list_id[i].state == 1 ){
            printf("%s no \n",node_list_id[i].file );
        }else{
            printf("%s yes \n",node_list_id[i].file );
        }
    }
}

int main (int argc,char * argv[]){
    int i;
    node_id node_list_id [MAX_FILES];
    if(argc == 1){
        errx(1,"ERROR: Not enough arguments");
    }
    for (i = 1;i < argc;i++){
        build_cmp_node(argv[i],argv,argc,&(node_list_id[i-1]));
    }
    wait_sons(argc-1,node_list_id);
    print_output(node_list_id,argc-1);
    exit(0);
}
