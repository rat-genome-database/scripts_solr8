INPUT_FILES=$1
SOLR_CORE=$2
DATA_SOURCE=$3
#FILES="/rgd/preprint_output/*"
FILES="/rgd/$INPUT_FILES/*"
for f in $FILES
do
  echo "Processing $f file... CORE $SOLR_CORE"
  /home/rgdpub/Scripts/scripts_solr8/convert_load.sh $f $SOLR_CORE $DATA_SOURCE
  # take action on each file. $f store current file name
  #cat "$f"
done
