#!/bin/bash
set -e

declare -r PV_DOCKER_REGISTRY="polyverse"
declare -r PV_NAME="kali-metasploit"

main() {
        build
        [ $? -ne 0 ] && return 1

        return 0
}

build() {
        # Build the image
        docker build -t "${PV_NAME}" -t "${PV_DOCKER_REGISTRY}/${PV_NAME}:latest" .
        [ $? -ne 0 ] && return 1

        # Don't tag when there are uncommitted changes.
        if [ -z "$(git status -s -uno)" ]; then
                declare -r PV_GIT_COMMIT="$(git rev-parse --verify HEAD)"

                docker tag "${PV_DOCKER_REGISTRY}/${PV_NAME}:latest" "${PV_DOCKER_REGISTRY}/${PV_NAME}:${PV_GIT_COMMIT}"
                [ $? -ne 0 ] && return 1
        fi

        return 0
}

main "$@"
exit $?
