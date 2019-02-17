import math
al = []
bl = []
def main():
nCasos = int(input())
for I in range(0, nCasos):
    num = int(input())
    if (num%2 ==0):
        b = int(math.sqrt(num))
        a = num/b
        if (a*b != num):
            a = 2
            b = num/2
    else:
        b = int(math.sqrt(num))
        a = num/b
        if (a*b != num):
            a = 1
            b = num
    al.append(a)
    bl.append(b)
for I in range(0, nCasos):
    print al[I], " ",bl[I]
main()
