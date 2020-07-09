#FROM jupyter/datascience-notebook:hub-1.1.0
FROM jupyter/datascience-notebook:15a66513da30

USER root

COPY /scripts/*.sh /usr/share/datahub/scripts/
COPY /run_jupyter.sh /

RUN /usr/share/datahub/scripts/install-all.sh

# testing directory
ENV TESTDIR=/usr/share/datahub/tests
ARG DATAHUB_TESTDIR=${TESTDIR}/datahub-base-notebook
COPY /tests ${DATAHUB_TESTDIR}
RUN chown -R 1000:1000 ${DATAHUB_TESTDIR}
RUN chmod -R +rwx ${DATAHUB_TESTDIR}

USER jovyan
WORKDIR /home/jovyan
