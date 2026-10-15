#!/bin/bash
# mean.sh: write the mean of a column of a CSV file (with header)

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "usage: $0 <column> [file.csv]" 1>&2
    exit 1
fi

column=$1
file=${2:-/dev/stdin}

cut -d, -f"$column" "$file" | tail -n +2 | {
    sum=0
    n=0
    while read x; do
        sum=$(echo "$sum + $x" | bc -l)
        n=$((n + 1))
    done
    echo "scale=4; $sum / $n" | bc -l
}
