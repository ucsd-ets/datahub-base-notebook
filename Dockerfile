FROM jupyter/base-notebook:hub-1.0.0

USER root

COPY /*.sh /usr/share/datahub/scripts/
COPY /run_jupyter.sh /

RUN /usr/share/datahub/scripts/install-all.sh

USER $NB_UID
