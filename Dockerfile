FROM jupyter/base-notebook

USER root

COPY *.sh /usr/share/datahub/scripts

RUN /usr/share/datahub/scripts/install-utilities.sh && \
  /usr/share/datahub/scripts/install-ipywidgts.sh && \
  /usr/share/datahub/scripts/install-nbresuse.sh

COPY /run_jupyter.sh /

USER $NB_UID
