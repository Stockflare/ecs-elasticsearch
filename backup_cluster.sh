#!/bin/bash

# Create the Snapshot repo if it is not there
curl -XPUT "http://${ELASTICSEARCH_ENDPOINT}:9200/_snapshot/s3_snapshots" -d "{
    \"type\": \"s3\",
    \"settings\": {
        \"bucket\": \"${S3_SNAPSHOT_BUCKET}\",
        \"region\": \"${AWS_REGION}\"
    }
}"

# Stanpshot the Cluster
curl -XPUT "http://${ELASTICSEARCH_ENDPOINT}:9200/_snapshot/s3_snapshots/snapshot_$(date +"%Y_%m_%d_%H_%M_%S")?wait_for_completion=true"
