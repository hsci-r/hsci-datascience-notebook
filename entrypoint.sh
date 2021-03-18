#!/bin/sh

echo $SSH_RSA_KEY > /home/jovyan/.ssh/id_rsa
chmod 0600 /home/jovyan/.ssh/id_rsa

sed -i -e "s/PASSWORD_HASH/$PASSWORD_HASH/g" /home/jovyan/.jupyter/jupyter_notebook_config.json

/usr/local/bin/start-notebook.sh

