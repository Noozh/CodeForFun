#!/usr/bin/python3

import math

def factor(n):
    """return a list with the prime factors of n. Complexity: O(sqrt(n))"""
    l = [1] #List of factors
    i = 2
    while i * i <= n: #From 2 to sqrt(n)
        while n % i == 0: #While i is factor of n, add to the list of factors.
            l.append(i)
            n /= i
        i += 1
    if n != 1: #If n isn't 1, then is a factor.
        l.append(int(n))
    return l

mayor = 1
menor = 1
n = int(input())
for i in range(0,n):
    entrada = int(input())
    factores = factor(entrada)
    valor = factores[-1]
    while 1:
        try:
            value = factores[-1]
            if valor == value:
                mayor = mayor * factores[-1]
            factores.remove(valor)
        except ValueError:
            break

    valor = factores[-1]
    while 1:
        try:
            value = factores[-1]
            if valor == value:
                menor = menor * factores[-1]
            factores.remove(valor)
        except ValueError:
            break
    print(menor, mayor)
