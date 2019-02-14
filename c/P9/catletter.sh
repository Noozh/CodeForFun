#!/bin/sh

cd $1
rm *.output > /dev/null 2>&1
o=$(find *.txt | tr A-Z a-z | sort)
seq 97 122 | awk '{printf("%c \n",$1)}' | cat > a.output
# for i in $( ls *.txt); do
#     first=$(echo $i|head -c 1)
#     cat $i >> $first.output
# done

# find *.txt | tr A-Z a-z | sort | cat a*.txt > a.output
