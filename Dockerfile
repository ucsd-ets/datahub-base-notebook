# FROM jupyter/base-notebook:hub-1.1.0
FROM jupyter/datascience-notebook:hub-1.1.0

USER root

COPY /scripts/*.sh /usr/share/datahub/scripts/
COPY /run_jupyter.sh /

RUN /usr/share/datahub/scripts/install-all.sh

# testing utils
ENV TESTDIR=/usr/share/datahub/tests
ARG DATAHUB_TESTDIR=${TESTDIR}/datahub-base-notebook
COPY /tests ${DATAHUB_TESTDIR}
RUN chmod -R +x ${DATAHUB_TESTDIR}
# RUN ${DATAHUB_TESTDIR}/test.sh

USER $NB_UID
