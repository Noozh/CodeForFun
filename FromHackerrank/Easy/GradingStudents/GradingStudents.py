#!/bin/python3

"""
HackerLand University has the following grading policy:

Every student receives a  grade in the inclusive range from 0 to 100

Any grade less than 40 is a falling grade

Sam is a professor at the university and likes to round each student's grade

according to these rules:

If the difference between the grade and the next multiple of 5 is less than 3
round up to the next multiple of 5
.
If the value of grade is less than 38, no rounding occurs as the result will
still be a failing grade.


"""


n = int(input())
for i in range(0,n):
    value = input()
    if int(value) < 38 :
        print(value)
    else:
        if int(value[-1]) <= 5 :
            if int(value[-1]) > 2 :
                value = int(value)
                while value % 5 != 0:
                    value = value +1
                print(value)
            else:
                print(value)
        elif int(value[-1]) > 5 :
            if int(value[-1]) > 7 :
                value = int(value)
                while value % 5 != 0:
                    value = value +1
                print(value)
            else:
                print(value)
