#!/bin/bash

DATASCIENCE_TESTDIR=$TESTDIR/datahub-base-notebook

### Add any non-selenium tests here
pip install nbgrader
nbgrader export --exporter=export.CanvasExport

# Test that the csv file has the necessary headers for Canvas
HEADERS="Student","ID","SIS User ID","SIS Login ID","Section"
firstline=$(cut -d ',' -f 1,2,3,4,5 grades.csv | head -1)

if ! [ "$firstline" == "$HEADERS" ]; then
    echo "Not formatted properly"
    exit 1
fi

# # test protobuf
# protoc -I=$DATASCIENCE_TESTDIR --python_out=$DATASCIENCE_TESTDIR $DATASCIENCE_TESTDIR/addressbook.proto
# python3 $DATASCIENCE_TESTDIR/addressbook_pb2.py
