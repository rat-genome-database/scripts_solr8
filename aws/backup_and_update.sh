#!/bin/bash

# Exit on error
set -e

# Function to back up and update a directory from S3
backup_and_update() {
  local DATA_DIR="$1"
  local BACKUP_DIR="$2"
  local S3_PATH="$3"

  echo "---- Processing $DATA_DIR ----"

  if [ ! -d "$DATA_DIR" ]; then
    echo "Directory '$DATA_DIR' does not exist. Creating it..."
    mkdir -p "$DATA_DIR"
  fi

  if [ -d "$BACKUP_DIR" ]; then
    echo "Removing existing backup directory: $BACKUP_DIR"
    rm -rf "$BACKUP_DIR"
  fi
  mkdir -p "$BACKUP_DIR"

  shopt -s dotglob nullglob
  files=("$DATA_DIR"/*)

  if [ ${#files[@]} -gt 0 ]; then
    echo "Moving contents from $DATA_DIR to $BACKUP_DIR"
    mv "${files[@]}" "$BACKUP_DIR"/
  else
    echo "No files to move from $DATA_DIR"
  fi
  shopt -u dotglob nullglob

  echo "Copying new files from $S3_PATH to $DATA_DIR ..."
  aws s3 cp "$S3_PATH" "$DATA_DIR"/ --recursive

  echo "Done processing $DATA_DIR"
  echo
}

