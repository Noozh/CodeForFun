# Complete the aVeryBigSum function below.
def aVeryBigSum(ar):
    res = 0
    for i in ar:
        res = res + int(i)
    return res

if __name__ == '__main__':
    first_line = input()
    ar = input()
    ar = ar.split()
    print(aVeryBigSum(ar))
