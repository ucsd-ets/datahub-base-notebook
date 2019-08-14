FROM jupyter/base-notebook:hub-1.0.0

USER root

COPY /*.sh /usr/share/datahub/scripts/

RUN /usr/share/datahub/scripts/install-utilities.sh && \
  /usr/share/datahub/scripts/install-ipywidgets.sh && \
  /usr/share/datahub/scripts/install-nbresuse.sh

COPY /run_jupyter.sh /

USER $NB_UID
