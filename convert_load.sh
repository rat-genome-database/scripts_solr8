#!/bin/sh

#python3 convert_for_loading.py "$1" 
SOLR_CORE=$2
tmp_file=`mktemp --suffix=$2 -u`
python3 /home/rgdpub/Scripts/scripts_solr8/convert_for_loading.py "$1" > "$tmp_file"
curl "http://localhost:8983/solr/$2/update/json?commit=true" -H 'Content-Type: application/json' -T "$tmp_file" -X POST
rm -f $tmp_file
