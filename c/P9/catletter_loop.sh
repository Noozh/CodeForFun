#!/bin/sh

cd $1
rm *.output > /dev/null 2>&1
for i in $( ls *.txt); do
    first=$(echo $i|head -c 1|tr A-Z a-z)
    cat $i >> $first.output
done
