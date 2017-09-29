#! /bin/bash

pv build $1 docker
pv build -r polyverse-internal.jfrog.io $1 docker
