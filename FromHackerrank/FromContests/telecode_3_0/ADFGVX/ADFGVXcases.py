#!/usr/bin/python3

bits = [32,16,8,4,2,1]
# bits = [1,2,4,8,16,32]
index = ["A","D","F","G","V","X"]
# index = ["X","V","G","F","D","A"]

n = int(input())
output = ""

def starterchar(entrada):
    for k in range (0,6):
        if bits[k] < entrada:
            return k-1
    return 5

while 1:
    try:
        entrada = input()
        entrada = entrada[:-1]
        entrada = entrada[1:]
        entrada = entrada.split()
        for j in range (0,6):
            if int(entrada[j]) > 0 :
                indice = starterchar(int(entrada[j]))
                output += str(index[j])
                if len(output) == 5:
                    print(output,sep="",end = "")
                    print(" ",sep="",end ="")
                    output = ""
                output += str (index[indice])
                if len(output) == 5:
                    print(output,sep="",end = "")
                    print(" ",sep="", end ="")
                    output = ""

    except EOFError:
        print (output)
        break
