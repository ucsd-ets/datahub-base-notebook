#!/bin/bash

DATASCIENCE_TESTDIR=$TESTDIR/datahub-base-notebook

### Add any non-selenium tests here
python3 -m pip install pytest
pytest $DATASCIENCE_TESTDIR/test-ipykernel_clean.py -v
pip uninstall multiprocess -y
pytest /usr/share/datahub/local-env-backup/tests/cli-test.py -v
pip install multiprocess

# test the datahub-base-notebook.py without opening it as an ipynb notebook
jupyter nbconvert --to python "${DATASCIENCE_TESTDIR}/datahub-base-notebook.ipynb"

if ! python3 ${DATASCIENCE_TESTDIR}/datahub-base-notebook.py; then
    exit 1
fi

# test protobuf
protoc -I=$DATASCIENCE_TESTDIR --python_out=$DATASCIENCE_TESTDIR $DATASCIENCE_TESTDIR/addressbook.proto
python3 $DATASCIENCE_TESTDIR/addressbook_pb2.py
