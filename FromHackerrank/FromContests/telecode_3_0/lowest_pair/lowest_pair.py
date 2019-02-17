
def main():
    num = int(input())
    if(num > 1):
        op1 = 2
        op2 = 1
        #veo hasta que numero puedo elevar el primer operando para no pasarme de num
        n = 0
        alcanzado = False
        while(not alcanzado):
            if(op1 ** n >= num):
                alcanzado = True
            else:
                n = n + 1
        #n tiene el valor maximo que puede alcanzar op2 

nCasos = int(input())
for I in range(0, nCasos):
    main()
