SCRIPT_DIR=/home/rgdpub/Scripts/scripts_solr8
$SCRIPT_DIR/aws/update_pubmed_output.sh
echo "Pubmed JSON output generated"
$SCRIPT_DIR/run_indexer.sh pubmed_output OntoMate pubmed
