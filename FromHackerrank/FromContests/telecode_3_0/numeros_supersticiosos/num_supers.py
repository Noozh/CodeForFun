
def readNum():
    tmp = raw_input()
    return tmp

def escapicua(num):
    tmp1 = list(num);
    tmp2 = []
    for I in reversed(tmp1):
        tmp2.append(I)
    return tmp1 == tmp2

nCasos = int(input())
for I in range(0, nCasos):
    num = readNum()
    if(escapicua(num)):
        print("LIMON")
    else:
        print("OK")
