
n = int(input())
arr = input()
arr = arr.split()
pos = 0.0
neg = 0.0
zero = 0.0
for i in arr:
    if int(i) > 0:
        pos = pos + 1.0
    elif int(i) < 0:
        neg = neg + 1.0
    else:
        zero = zero + 1.0
print(pos/n)
print(neg/n)
print(zero/n)
