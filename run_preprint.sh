SCRIPT_DIR=/home/rgdpub/Scripts/scripts_solr8
$SCRIPT_DIR/aws/generate_preprint_output.sh
echo "Preprint JSON output generated"
$SCRIPT_DIR/run_indexer.sh preprint_output preprintSolr preprint
