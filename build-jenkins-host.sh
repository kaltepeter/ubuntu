#!/usr/bin/env bash
SSH_USERNAME=jenkins
SSH_PASSWORD='faGVTvgX2Nn5B6aDQjeajRATZIeGEwdO'
bin/build-box jaasslavehost1604 virtualbox jaasslavehost.json

version=$(cat VERSION)
publish_box=$(pwd)/box/virtualbox/jaasslavehost-${version}.box
echo "publishing $publish_box ..";
box=$(basename ${f})
read -r boxname suffix <<<$(echo $box | sed 's/\(.*\)\(-[0-9]\.[0-9]\.[0-9]\.box\)$/\1 \2/')
echo "$boxname $suffix $version"
bin/register-vagrant-cloud.sh $boxname $suffix $version