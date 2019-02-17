#!/usr/bin/python3

res = 0
bloques = 0
entrada = []

def triangle(rows):
    for k in range(0,rows):
        print(' '*(rows-k-1) + '*'*(2*k+1))


res = 0
aux = "0"
n = int(input())
for i in range (0,n):
    entrada.append(input())
    res = max (entrada)
for i in entrada:
    numbloquesnuevo = int(i)**2
    bloques = bloques + numbloquesnuevo
    if(str(numbloquesnuevo) > aux) :
        aux = str(numbloquesnuevo)
       

print(bloques)
triangle(int(res))
print(int(aux))
