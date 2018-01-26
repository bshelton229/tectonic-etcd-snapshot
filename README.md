# Tectonic Etcd Snapshot

A docker image containing a bash script for snapshotting etcd clusters. For
tectonic clusters (at least as of 1.8.4) running this as a CronJob in the
kube-system namespace on the master nodes gives you access to a secret object
containing the tls keys you need to connect to your etcd cluster. See
`k8s/cron-job-template.yml` for more details.

## Configuration Environment Variables

### ETCDCTL_ENDPOINTS

This is standard to the etcdctl cli tool for api version 3. This will need to
match your etcd dns name for your kubernetes cluster.

### S3_BUCKET

The bucket to store the backups in

### S3_PREFIX

The s3 key prefix within your backup bucket. Under this prefix backups will be
additionally prefixed with `YEAR/MONTH/DAY`.

### KMS_KEY_ID

If provided the snapshots will be encrypted with the kms key.

## AWS Authentication

This script uses the standard aws cli tool. You are able to configure the pod
to authenticate to AWS using any standard method.
