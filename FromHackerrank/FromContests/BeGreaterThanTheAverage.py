n = input()
ndec = 6
geo = 1.0
arit = 0.0
m = 1.0/n
for i in range(0,n):
    num = input()
    arit = arit + num
    geo = geo * (float(num)**m)
arit = arit / n
res = arit - geo
ent = int(res)
dec = res - ent
# print ent, dec
dec = str(dec)
dec = dec[:ndec]
dec = float (dec)
print(ent + dec)

