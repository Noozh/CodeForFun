MaxDigitos = 20

def rellenar(nbin):
    long = len(nbin)
    nceros = MaxDigitos - long
    num = nbin
    for I in range(0, nceros):
        num = "0" + num
    return num

def posunos(nbin):
    l = []
    for I in range(0, len(nbin)):
        if(nbin[I] == "1"):
            l.append(I + 1)
    return l

def igualUnos(prev, actual):
    return len(prev) == len(actual)

def convert(s):

    # initialization of string to ""
    new = ""

    # traverse in the string
    for x in s:
        new += x

    # return string
    return new

def crece(list, i):
    if i > 0:
        posunos_prev = posunos(rellenar(list[i - 1]))
        posunos_actual = posunos(rellenar(list[i]))
        if(igualUnos(posunos_prev, posunos_actual)):
            finish = False;
            j = 0
            while(not finish and j < len(posunos_prev)):
                if((posunos_actual[j] - posunos_prev[j]) != 1):
                    finish = True
                j = j + 1
            return finish
        else:
            prev = rellenar(list[i - 1])
            actual = rellenar(list[i])
            if(prev[19] == 1 and actual[19] == 0):
                #print(prev)
                prev = prev[:19]
                #print(prev)
                prev = prev + "0"
                #print(prev)
                posunos_prev = posunos(prev)
            finish = False;
            j = 0
            while(not finish and j < len(posunos_prev)):
                if((posunos_actual[j] - posunos_prev[j]) != 1):
                    finish = True
                j = j + 1
            return finish

    else:
        return False

def readnums():
    numbin = [];
    num = []
    n = int(input())
    while(n != 0):
        num.append(abs(n))
        n = bin(n)
        numbin.append(n.replace("0b", ""))
        n = int(input())
    return num, numbin

def main():
    list, listbin = readnums()
    finish = False
    I = 0
    while(not finish and I < len(list)):
        if(crece(listbin, I)):
            finish = True
        else:
            I = I + 1
    if(finish):
        print("DESCALIFICADOS")
    else:
        print("GANADORES")

nCasos = int(input())

for I in range(0, nCasos):
    main()
