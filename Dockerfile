FROM jupyter/datascience-notebook:python-3.7.6

USER root

COPY /scripts /usr/share/datahub/scripts/
COPY /scripts/run_jupyter.sh /
COPY /scripts/jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py

RUN /usr/share/datahub/scripts/install-all.sh && \
	pip install pandas --upgrade && \
	pip install nltk && \
	cat /usr/share/datahub/scripts/canvas_exporter.py > /opt/conda/lib/python3.7/site-packages/nbgrader/plugins/export.py && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    chown -R jovyan:users /opt/conda/etc/jupyter/nbconfig && \
    chmod -R +r /opt/conda/etc/jupyter/nbconfig

# testing directory
COPY /tests /usr/share/datahub/tests/datahub-base-notebook
RUN chown -R 1000:1000 /usr/share/datahub/tests/datahub-base-notebook && \
    chmod -R +rwx /usr/share/datahub/tests/datahub-base-notebook

USER jovyan
WORKDIR /home/jovyan

