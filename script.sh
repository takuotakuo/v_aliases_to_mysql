#!/usr/bin/bash

domain=$1
file=$2
outfile=$3
line=$(cat $file)
i=1
nword=$(wc -w < $file)

echo "INSERT INTO \`maildb\`.\`virtual_aliases\`
  (\`id\`, \`domain_id\`, \`source\`, \`destination\`)
VALUES" >> $outfile

for string in $line
do
    if [[ $((i%2)) -ne 0 ]] && [[ $((i)) -lt $((nword)) ]]
    then
        ((i++))
        echo -n "('$((i/2))', '1', '${string}', " >> $outfile
    elif [[ $((i%2)) -eq 0 ]] && [[ $((i)) -lt $nword ]]
    then
        ((i++))
        echo "'${string}@${domain}')," >> $outfile
    else
        echo "'${string}@${domain}');" >> $outfile
    fi
done
