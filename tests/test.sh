#!/bin/bash

# test libraries are installed
DATAHUB_BASE_TESTDIR=$TESTDIR/datahub-base-notebook
jupyter nbconvert --to script "${DATAHUB_BASE_TESTDIR}/datahub_base_notebook.ipynb"
python3 $DATAHUB_BASE_TESTDIR/datahub_base_notebook.py
