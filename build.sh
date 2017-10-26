#! /bin/bash

build()
{
	command="pv build ${@:1} docker"
	echo $command
	$command
}

# Special keyword "all" means build and push to both polyverse and jfrog repos
if [ "$1" == "all" ]; then
	build -s -r polyverse
	build -s -r internal.hub.polyverse.io
else
	build "$@"
fi
