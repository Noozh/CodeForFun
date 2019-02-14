#!/bin/sh
raw=$(cat $1 |  egrep -v '#' | egrep .)
cities=$(printf '%s\n' "$raw"|sed -E -n '/[A-Z]|[a-z]/p')
for i in $cities; do
    ## Get current city data block
    data=$(printf '%s\n' "$raw"|sed -n -e "/$i/,/[a-Z]/p"|egrep -v [A-Z]|egrep -v [a-z])
    ## Get middle value of $i data block
    media=$(printf '%s\n' "$data"| awk -F'\t' '{ print $3 }'|awk '{ sumatorio+=$1 } END { print sumatorio/NR}')
    ## Get maximum value of $i data block
    maximo=$(printf '%s\n' "$data"| awk -F'\t' '{ print $4 }'|awk 'NR==1 { maximo=$1; next } $1 > maximo { maximo=$1 } END{ print maximo }')
    ## Print format output
    echo $i $media $maximo | tr [A-Z] [a-z]
done
