#!/usr/bin/env bash
packer build -var-file=ubuntu1604.json --only=virtualbox-iso ubuntu.json
