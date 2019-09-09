#!/bin/sh -x
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>nbcluster.out 2>&1

pip install --no-cache-dir git+https://github.com/ucsd-ets/nbcluster-status.git && \
	jupyter serverextension enable --py nbcluster_status --sys-prefix && \
	jupyter nbextension install --py nbcluster_status --sys-prefix && \
	jupyter nbextension enable --py nbcluster_status --sys-prefix
