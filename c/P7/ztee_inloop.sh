#!/bin/bash
count=0
while :
do
	./ztee output < quijote.txt.gz
	((count++))
	echo $count > num_pasadas
done
