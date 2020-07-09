#!/bin/sh -x

pip install nbmessages==0.0.5

jupyter serverextension enable --sys-prefix --py nbmessages
jupyter nbextension install --sys-prefix --py nbmessages
jupyter nbextension enable --user message/main --section=tree
