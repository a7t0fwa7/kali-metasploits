#!/bin/bash
set -e

declare -r PV_DOCKER_REGISTRY="polyverse"
declare -r PV_GIT_COMMIT="$(git rev-parse --verify HEAD)"
declare -r PV_NAME="kali-metasploit"

main() {
        build
        [ $? -ne 0 ] && return 1

        return 0
}

build() {
        # Build the image
        docker build -t "${PV_NAME}" -t "${PV_DOCKER_REGISTRY}/${PV_NAME}:latest" -t "${PV_DOCKER_REGISTRY}/${PV_NAME}:${PV_GIT_COMMIT}" .
        [ $? -ne 0 ] && return 1

        return 0
}

main "$@"
exit $?
