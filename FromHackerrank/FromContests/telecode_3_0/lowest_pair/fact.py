import math
class List():
    l = []
def factor(n):
    """return a list with the prime factors of n. Complexity: O(sqrt(n))"""
    l = [1] #List of factors
    i = 2
    while i * i <= n: #From 2 to sqrt(n)
        while n % i == 0: #While i is factor of n, add to the list of factors.
            l.append(i)
            n /= i
        i += 1
    if n != 1: #If n isn't 1, then is a factor.
        l.append(int(n))
    return l

def esentero(n):
    np = int(n)
    return n / np == 1

def convert(s):

    # initialization of string to ""
    new = ""

    # traverse in the string
    for x in s:
        new += x

    # return string
    return new

def main(l):
    sols = []
    for I in range(0, len(l)):
        b = int(math.sqrt(l[I]))
        if(b ** 2 == l[I]):
            a = b
        else:
            finish = False
            while(not finish):
                if(esentero(float(l[I]) / float(b))):
                    finish = True
                else:
                    b = b + 1
            a = l[I] / b

        sol = str(a), " ", str(b)
        sols.append(sol)
    for I in range(0, len(sols)):
        print ''.join(sols[I])

nCasos = int(input())
l = []
for I in range(0, nCasos):
    l.append(int(input()))

main(l)
