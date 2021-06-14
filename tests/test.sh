#!/bin/bash

DATASCIENCE_TESTDIR=/usr/share/datahub/tests/datahub-base-notebook

echo "DIR $(pwd)"
### Add any non-selenium tests here
nbgrader export

# Test that the csv file has the necessary headers for Canvas
HEADERS="Student","ID","SIS User ID","SIS Login ID","Section"

echo "$(ls /home/jovyan)"
firstline=$(cut -d ',' -f 1,2,3,4,5 /home/jovyan/grades.csv | head -1)

if ! [ "$firstline" == "$HEADERS" ]; then
    exit 1
else
    echo "nbgrader export test pass"
fi

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


if ! python3 ${DATASCIENCE_TESTDIR}/datahub-base-notebook.py; then
    exit 1
fi

# test 7zip
if ! 7z; then
    echo "7zip test failed"
    exit 1
else
    echo "7zip test passed"
fi
