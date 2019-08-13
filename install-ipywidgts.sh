#!/bin/sh
pip install --no-cache-dir ipywidgets && \
	jupyter nbextension enable --sys-prefix --py widgetsnbextension
