#!/usr/bin/python3
import math

def mm (length):
    return 2.54 * length*10.0000

def heigh(diag, widthpx, heighpx):
    return heighpx * (diag/math.sqrt(pow(widthpx,2) + pow(heighpx,2)))

def width (widthpx, heighpx, h):
    return widthpx*(h/heighpx)

n = int (input())
for i in range(0,n):
    entrada = input()
    entrada = entrada.split()
    altura = heigh(float(entrada[0]),float(entrada[1]),float(entrada[2]))
    anchura = width(float(entrada[1]),float(entrada[2]),altura)
    altura = mm(altura)
    anchura = mm(anchura)
    print(int((anchura)),end=" ")
    print(int(((altura))))
