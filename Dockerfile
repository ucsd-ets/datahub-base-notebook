FROM jupyter/datascience-notebook:python-3.7.6

USER root

COPY /scripts /usr/share/datahub/scripts/
COPY /run_jupyter.sh /

RUN /usr/share/datahub/scripts/install-all.sh

RUN pip install pandas --upgrade

RUN cat /usr/share/datahub/scripts/canvas_exporter.py >> /opt/conda/lib/python3.7/site-packages/nbgrader/plugins/export.py

# testing directory
ENV TESTDIR=/usr/share/datahub/tests
ARG DATAHUB_TESTDIR=${TESTDIR}/datahub-base-notebook
COPY /tests ${DATAHUB_TESTDIR}
RUN chown -R 1000:1000 ${DATAHUB_TESTDIR} && \
    chmod -R +rwx ${DATAHUB_TESTDIR}

USER jovyan
WORKDIR /home/jovyan

