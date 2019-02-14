
n = int(input())
k = 0
i = n-1
for j in range (0,n):
    for k in range(k,n-1):
        print(" ", sep='', end='')
    for i in range (n,i):
        print("#", sep='', end='')
    i = i -1
    k = k +1
    print()
