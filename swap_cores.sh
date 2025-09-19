#!/bin/bash

# Core names
OLD_CORE="OntoMate"
NEW_CORE="OntoMate_sec"

# Solr base URL
SOLR_URL="http://localhost:8983/solr"

# Swap the cores
echo "Swapping $OLD_CORE with $NEW_CORE..."
curl "${SOLR_URL}/admin/cores?action=SWAP&core=${OLD_CORE}&other=${NEW_CORE}"

echo "Core swap complete!"

