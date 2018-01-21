#!/bin/bash

set -e


function fix_slashes() {
    echo $1 | sed 's|^/\+||g' | sed 's|/\+$||g'
}


if [ -z "$S3_PREFIX" ] || [ -z "$S3_BUCKET" ]; then
    echo "Please set both the S3_PREFIX and S3_BUCKET environment variables."
    exit 1
fi

BACKUP_FILE=/tmp/etcd-snapshot.db
FILE_SUFFIX=$(date -u +%Hh%Mm%Ss)
DATE_PATH=$(date -u +%Y/%m/%d)
BUCKET=$(fix_slashes $S3_BUCKET)
PREFIX=$(fix_slashes $S3_PREFIX)
S3_PATH=s3://$BUCKET/$PREFIX/$DATE_PATH/etcd-snapshot-$FILE_SUFFIX.db

trap "rm -f $BACKUP_FILE" EXIT

/usr/local/bin/etcdctl snapshot save $BACKUP_FILE

echo "Uploading to $S3_PATH"
/usr/bin/aws s3 cp $BACKUP_FILE $S3_PATH
