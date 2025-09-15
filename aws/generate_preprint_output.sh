. /etc/profile
MYJAVA="java -Xms512m -Xmx20480m"
APP_DIR=/rgd/preprint_output
DATA_DIR=$APP_DIR/

rm -r $DATA_DIR/preprint_output_bkup
mkdir $DATA_DIR/preprint_output_bkup
#rm -r $DATA_DIR/*
mv $APP_DIR/*  $DATA_DIR/preprint_output_bkup/
aws s3 cp s3://emr-repository/preprint-output/ $DATA_DIR/ --recursive

#cd $APP_DIR/PubmedCrawlerPipeline
#$MYJAVA -jar lib/PubmedCrawlerPipeline.jar --indexer --o $DATA_DIR
#/home/rgdpub/Scripts/scripts_solr8/run_preprint.sh
#aws s3 rm s3://emr-repository/preprint/ --recursive
#aws s3 rm s3://emr-repository/preprint-output/ --recursive

