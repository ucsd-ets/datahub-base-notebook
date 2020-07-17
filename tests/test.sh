#!/bin/bash

### Add any non-selenium tests here

# test the datahub-base-notebook.py without opening it as an ipynb notebook
DATASCIENCE_TESTDIR=$TESTDIR/datahub-base-notebook
jupyter nbconvert --to python "${DATASCIENCE_TESTDIR}/datahub-base-notebook.ipynb"

if ! python3 ${DATASCIENCE_TESTDIR}/datahub-base-notebook.py; then
    exit 1
fi

# test protobuf
protoc -I=$DATASCIENCE_TESTDIR --python_out=$DATASCIENCE_TESTDIR $DATASCIENCE_TESTDIR/addressbook.proto
python3 $DATASCIENCE_TESTDIR/addressbook_pb2.py
