
def sumDiagonal1(row, dim):
    res = 0
    for i in range (0,int(dim)):
        res = res + int (row[i][i])
    return res

def sumDiagonal2(row, dim):
    res = 0
    j = int(dim) - 1
    for i in range (0,int(dim)):
        res = res + int (row[i][j])
        j = j -1
    return res

dim = input()
row = []
for i in range (0,int(dim)):
    row.append(input().split())

print(abs(sumDiagonal1(row,dim) - sumDiagonal2(row,dim)))
