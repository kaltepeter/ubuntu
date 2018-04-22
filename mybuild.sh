#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

if [ "${DEBUG:-false}" = "true" ]; then
  set -x # Run the entire script in debug mode
fi

usage() {
  echo "usage: $(basename $0) [-h/--help] command [arguments...]"
  echo
  echo "Available commands are:"
  echo "    build     Generate a box image file"
  echo "    test      Run serverspec tests against a box image name"
  echo "    publish   Publish to vagrant cloud"
}

args() {
  if [ $# -lt 1 ]; then
    usage
    exit 0
  fi

  if [[ ! $1 =~ ^(build|test|publish)$ ]]; then
    echo "$(basename $0): illegal option $1"
    usage
    exit 1
  fi

  command=$1
  case $command in
  "" | "-h" | "--help")
    usage
    ;;
  *)
    shift
    ;;
  esac
  $command "$@"
}

publish() {
  for f in $(pwd)/box/virtualbox/*.box; do
		echo "publishing $f ..";
#		bin/test-box "$@"
		version=$(cat VERSION)
		box=$(basename ${f})
		read -r boxname suffix <<<$(echo $box | sed 's/\(.*\)\(-[0-9]\.[0-9]\.[0-9]\.box\)$/\1 \2/')
		echo "$boxname $suffix $version"
		bin/register-vagrant-cloud.sh $boxname $suffix $version
	done
}

test() {
  	for f in $(pwd)/box/virtualbox/*.box; do
		echo "Testing $f ..";
#		bin/test-box "$@"
		bin/test-box $f virtualbox "$@"
	done
}

build() {
#  bin/build-box "$@"
#	bin/bump.sh patch
  	bin/build-box ubuntu1604 virtualbox ubuntu.json
}

# main
args "$@"

#packer build -var-file=ubuntu1604.json --only=virtualbox-iso ubuntu.json
#boxes=$(ls "$(pwd)/box/virtualbox/*.box")
#bin/box test boxes virtualbox