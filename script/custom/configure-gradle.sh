#!/usr/bin/env bash
SSH_USER=${SSH_USERNAME:-vagrant}
SSH_PASS=${SSH_PASSWORD:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}

gradle_dir="${SSH_USER_HOME}/gradle"
mkdir ${gradle_dir}
chmod 700 ${gradle_dir}
chown -R $SSH_USER:$SSH_USER ${gradle_dir}