SCRIPT_DIR=/home/rgdpub/Scripts/scripts_solr8/aws
source $SCRIPT_DIR/backup_and_update.sh
backup_and_update "/rgd/pubmed_output" "/rgd/pubmed_output_bkup" "s3://emr-repository/output/"
