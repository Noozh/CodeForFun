
#!/bin/python3

"""
Consider a staircase of size n = 4:

   #
  ##
 ###
####

Observe that its base and height are both equal to, and the image is drawn
using # symbols and spaces. The last line is not preceded by any spaces.

Write a program that prints a staircase of size n
"""

n = int(input())
k = 1
p = n
for k in range (1,n+1):
    for j in range(1,p):
        print(" ", sep='', end='')
    for i in range (0,k):
        print("#", sep='', end='')
    p = p -1
    k = k +1
    print()
