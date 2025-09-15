SCRIPT_DIR=/home/rgdpub/Scripts/scripts_solr8/aws
source $SCRIPT_DIR/backup_and_update.sh
backup_and_update "/rgd/preprint_output" "/rgd/preprint_output_bkup" "s3://emr-repository/preprint-output/"
