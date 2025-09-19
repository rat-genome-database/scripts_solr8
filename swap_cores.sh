#!/bin/bash

# Define core names
OLD_CORE="OntoMate"
NEW_CORE="OntoMate_sec"

# Solr base URL
SOLR_URL="http://localhost:8983/solr"

# Function to get doc count of a core
get_doc_count() {
  curl -s "${SOLR_URL}/${1}/select?q=*:*&rows=0&wt=json" | jq '.response.numFound'
}

# Step 1: Get old and new core doc counts
OLD_COUNT=$(get_doc_count "$OLD_CORE")
NEW_COUNT=$(get_doc_count "$NEW_CORE")

echo "Old core ($OLD_CORE) doc count: $OLD_COUNT"
echo "New core ($NEW_CORE) doc count: $NEW_COUNT"

# Step 2: Compare and decide
if [ "$NEW_COUNT" -ge "$OLD_COUNT" ]; then
  echo "New index is valid (>= old index). Proceeding to swap..."
  # Swap the cores
  echo "Swapping $OLD_CORE with $NEW_CORE..."
  curl "${SOLR_URL}/admin/cores?action=SWAP&core=${OLD_CORE}&other=${NEW_CORE}"
  echo "Core swap complete!"
else
  echo "New index has fewer documents. Aborting core swap!"
  exit 1
fi

