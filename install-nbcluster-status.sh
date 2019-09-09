#!/bin/sh -x
pip install --no-cache-dir git+https://github.com/ucsd-ets/nbcluster-status.git && \
	jupyter serverextension enable --sys-prefix --py nbcluster_status && \
	jupyter nbextension install --sys-prefix --py nbcluster_status && \
	jupyter nbextension enable --sys-prefix --py nbcluster_status
