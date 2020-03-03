#!/bin/bash
set -e

declare -r PV_DOCKER_REGISTRY="polyverse"
declare -r PV_GIT_COMMIT="$(git rev-parse --verify HEAD)"
declare -r PV_NAME="kali-metasploit"

main() {
        publish
        [ $? -ne 0 ] && return 1

        return 0
}

publish() {
	# Don't publish when there are uncommitted changes.
	if [ ! -z "$(git status -s -uno)" ]; then
		echo "COMMIT IS DIRTY, aborting"
		exit 1
	fi

        docker push "${PV_DOCKER_REGISTRY}/${PV_NAME}:${PV_GIT_COMMIT}"
        [ $? -ne 0 ] && return 1

        docker push "${PV_DOCKER_REGISTRY}/${PV_NAME}:latest"
        [ $? -ne 0 ] && return 1

        return 0
}

main "$@"
exit $?
