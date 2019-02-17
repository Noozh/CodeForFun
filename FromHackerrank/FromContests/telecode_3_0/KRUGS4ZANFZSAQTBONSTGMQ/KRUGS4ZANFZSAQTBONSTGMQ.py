#!/usr/bin/python3

import base64

n = int(input())
for i in range(0,n):
    entrada = input()
    entrada = base64.b32decode(entrada).decode('utf-8')
    print(entrada)
