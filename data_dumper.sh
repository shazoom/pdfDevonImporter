#!/bin/bash
PDFIN="$KMVAR_pdfPath"
PDFTK=/usr/local/bin/pdftk
DUMP=$(mktemp "/tmp/pdftk_data_dump_$RANDOM")

$PDFTK "$PDFIN" dump_data output $DUMP
if [[ $? -ne 0 ]]
then
   exit 1
fi
   

OLDIFS=$IFS
IFS=$'\n'
for line in `cat $DUMP`
do
   if [[ ${line%%:*} == "InfoKey" ]]
   then
      echo ${line##InfoKey:}  | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' -e 's/\n/ /g' | iconv -c -f utf-8 -t ascii//translit
   elif  [[ ${line%%:*} == "InfoValue" ]]
   then
      echo ${line##InfoValue:} | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' -e 's/\n/ /g' | iconv -c -f utf-8 -t ascii//translit
   fi
done
IFS=$OLDIFS

 rm $DUMP
