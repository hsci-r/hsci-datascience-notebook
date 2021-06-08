FROM quay.io/hsci/datascience-notebook-openshift

USER root

RUN apt-get update && apt-get install -y openssh-client git-lfs rsync && rm -rf /var/lib/apt/lists/*

COPY gitconfig /home/jovyan/.gitconfig

COPY jupyter_notebook_config.json /home/jovyan/.jupyter/jupyter_notebook_config.json

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENV SSH_RSA_KEY=REPLACE_ME

ENV PASSWORD_HASH=REPLACE_ME

CMD ["/usr/local/bin/entrypoint.sh"]

COPY environment.yml /tmp/

ENV NB_GID=0

RUN mkdir /home/jovyan/.ssh && ssh-keyscan github.com > /home/jovyan/.ssh/known_hosts && \
    conda env update -n base --file /tmp/environment.yml && \
    rm /tmp/environment.yml && \
    jupyter lab build && \
    fix-permissions /home/jovyan /opt/conda

ENV NB_GID=100

USER 65536
