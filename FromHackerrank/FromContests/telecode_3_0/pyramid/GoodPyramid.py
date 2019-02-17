#!/bin/python3

import math

def triangle(n):
    for i in range(0, n):
        print(' '*(n-i-1)+'*'*(2*i+1))

if __name__ == '__main__':
    bricks=[]
    client_bricks=[]
    n= int(input())

    for i in range(n):
	    entrada = int(input())
        bricks.append(entrada**2)
        client_bricks.append(str(entrada**2))

    print(sum(bricks))

    client_bricks = sorted(client_bricks)
    layers=math.sqrt(int(client_bricks[-1]))
    triangle(int(layers))
    print(client_list[-1])
