#!/usr/bin/env bash
SSH_USER=${SSH_USERNAME:-vagrant}
SSH_PASS=${SSH_PASSWORD:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}

node_dir="${SSH_USER_HOME}/node"
mkdir ${node_dir}
chmod 700 ${node_dir}
chown -R $SSH_USER:$SSH_USER ${node_dir}