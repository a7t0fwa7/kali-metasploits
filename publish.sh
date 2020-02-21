#!/bin/bash
set -e

declare -r PV_DOCKER_REGISTRY="polyverse"
declare -r PV_GIT_COMMIT="$(git rev-parse --verify HEAD)"
declare -r PV_NAME="kali-metasploit"


main() {
	# Push the image
	push
        [ $? -ne 0 ] && return 1

	return 0
}

push() {
	# Push "latest" (for convenience)
        docker push "$PV_DOCKER_REGISTRY/${PV_NAME}:latest"
        [ $? -ne 0 ] && return 1

	# Push tagged image
        docker push "$PV_DOCKER_REGISTRY/${PV_NAME}:${PV_GIT_COMMIT}"
        [ $? -ne 0 ] && return 1

        return 0
}

main "$@"
exit $?
