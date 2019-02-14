#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <err.h>

void print_str_split(char *str,char *splitter ){
    char *cp = strdup(str);
    char *token = strtok(cp, splitter);
    while(token != NULL){
        printf("%s\n",token );
        token = strtok(NULL, splitter);
    }
    free (cp);
    free (token);
}

void parse_input(int argc, char *argv[]){
    uint i;
    for (i = 1;i < argc; i++){
        if (getenv(argv[i]) == NULL){
            errx(1,"ERROR: var %s does not exist",argv[i]);
        }
        print_str_split(getenv(argv[i]),":");
    }
}

int main(int argc, char *argv[]){
    if (argc == 1){
        errx(1,"ERROR: Invalid input");
    }else{
        parse_input(argc,argv);
        exit(EXIT_SUCCESS);
    }
}
