#!/usr/bin/python3

from statistics import mode
from collections import Counter

abecedario = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
                'Q','R','S','T','U','V','W','X','Y','Z', ' ' ]

def sumamodular (letra, offset):
    res = letra + offset
    if res >= 27:
        res = res - 27
    return res


def getOffset(message):
    return  abecedario.index (' ') - abecedario.index(Counter(message).most_common()[0][0]) 

n = int(input())
for i in range (0,n):
    message = input()
    offset = getOffset (message)
    for j in message:
        print(abecedario[sumamodular(abecedario.index(j),offset)], end ="")
    print("")
