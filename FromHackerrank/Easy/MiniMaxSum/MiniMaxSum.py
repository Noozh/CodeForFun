#!/bin/python3

"""

Given five positive integers, find the minimum and maximum values that can be
calculated by summing exactly four of the five integers. Then print the
respective minimum and maximum values as a single line of two space-separated
long integers.

"""
maximos = []
minimos = []

entrada = input()
entrada = entrada.split()
for i in range(0,5):
    entrada[i] = int(entrada[i])


entrada2 = entrada.copy()

for i in range (0,4):
    maximos.append(max(entrada))
    entrada.pop(entrada.index(max(entrada)))

for i in range (0,4):
    minimos.append(min(entrada2))
    entrada2.pop(entrada2.index(min(entrada2)))

# print(maximos)
# print(minimos)

print (sum(minimos), sep='', end=' ')
print (sum(maximos))
