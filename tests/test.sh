#!/bin/bash

DATASCIENCE_TESTDIR=$TESTDIR/datahub-base-notebook
jupyter nbconvert --to python "${DATASCIENCE_TESTDIR}/datascience_notebook.ipynb"


if ! python3 ${DATASCIENCE_TESTDIR}/datascience_notebook.py; then
    exit 1
fi

# test protobuf
protoc -I=$DATASCIENCE_TESTDIR --python_out=$DATASCIENCE_TESTDIR $DATASCIENCE_TESTDIR/addressbook.proto
python3 $DATASCIENCE_TESTDIR/addressbook_pb2.py

# test okpy
git clone https://github.com/okpy/ok-client.git
ok -q ok-client/demo/ok_test/q2
rm -rf ok-client

# start the notebook server for the UI testing
jupyter notebook --NotebookApp.token='' --notebook-dir=/usr/share/datahub/tests/datahub-base-notebook