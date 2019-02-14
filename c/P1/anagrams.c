#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*  Type declaration    */
typedef struct list {
       char chain[25];
       uint size;           //Esto no me gusta
       struct list *next;
} list;

/*  Const declaration    */
enum { INPUT_SIZE = 100 };


int are_anagrams(char chain_1[], char chain_2[]){
    uint length,n,j,count;
    count = 0;
    char *cp_1 = strdup (chain_1);
    char *cp_2 = strdup (chain_2);
    length = strlen(cp_1);
    if (strlen(cp_1) == strlen(cp_2)){
        for(n=0;n<length;n++){
            for(j=0;j<length;j++){
                if (cp_1[n] == cp_2[j]){
                    count=count+1;
                    cp_2[j]='?';
                    break;
                }
            }
        }
    }
    free(cp_1);
    free(cp_2);
    return count == length;
}

void init_list(list anagram_list[]){
    uint n = 0;
    for (n=0;n<INPUT_SIZE/2;n++){
        anagram_list[n].next = NULL;
        anagram_list[n].size = 0;
    }
}

void init_array (uint array[],uint size){
    uint n = 0;
    for (n=0;n<size;n++){
        array[n] = 0;
    }
}

void print_var_chars(list anagram_list){
    list *p_aux = anagram_list.next;
    uint n = 0;
    uint moved[strlen(anagram_list.chain)];
    init_array(moved,strlen(anagram_list.chain));
    while (p_aux != NULL){
        for (n = 0; n < strlen(anagram_list.chain) ;n++){
            if (anagram_list.chain[n] == (*p_aux).chain[n]) {
                if (moved[n] != 1){
                    moved[n]=0;
                }
            }else{
                moved[n]=1;
            }
        }
        p_aux = (*p_aux).next;
    }
    printf("[");
    for (n = 0; n < strlen(anagram_list.chain) ;n++){
        if (moved[n]){
            printf("%c",anagram_list.chain[n] );
        }
    }
    printf("]\n");
}

void print_output (list anagram_list[], uint anagram_family){
    list *p_aux ;
    uint n;
    for (n = 0; n < anagram_family ; n++){
        p_aux = &(anagram_list[n]);
        while (p_aux != NULL){
            printf("%s ", (*p_aux).chain );
            p_aux = (*p_aux).next;
        }
        print_var_chars(anagram_list[n]);
    }
}

void save_anagram(char chain[],list *anagram_list){
    list *p_aux ;
    if((*anagram_list).size == 0){
        strcpy((*anagram_list).chain,chain);
    }else{
        p_aux = anagram_list;
        while ((*p_aux).next != NULL) {
            p_aux = (*p_aux).next;
        }
        (*p_aux).next = (struct list *) malloc (sizeof(struct list));
        p_aux = (*p_aux).next;
        strcpy((*p_aux).chain, chain);
        //(*p_aux).size = 0;
        (*p_aux).next = NULL;
    }
    (*anagram_list).size = (*anagram_list).size + 1;
}

void parse_args(int argc, char *argv[]){
    uint i,k;
    uint success = 0;
    uint arg_state [argc];
    uint index = 0;
    list anagram_list [INPUT_SIZE/2];
    init_list(anagram_list);
    init_array(arg_state,argc);
    for(i=1;i<argc;i++){
        for(k=i+1;k<argc;k++){
            if (are_anagrams(argv[i],argv[k]) && arg_state[k] == 0){
                success = 1;
                if (arg_state[i] == 0) {
                    save_anagram(argv[i],&(anagram_list[index]));
                    arg_state[i] = 1;
                }
                save_anagram(argv[k],&(anagram_list[index]));
                arg_state[k] = 1;
            }
        }
        if(success){
            index = index + 1;
            success = 0;
        }
    }
    print_output(anagram_list,index);
}

int main(int argc, char *argv[]){
    if (argc > INPUT_SIZE){
        printf("Too many arguments \n");
        exit(EXIT_FAILURE);
    }else{
        parse_args(argc,argv);
        exit(EXIT_SUCCESS);
    }
}
