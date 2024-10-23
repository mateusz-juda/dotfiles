#!/bin/bash

exit 0

exec 1<&-
exec 1>&2

echo $*

if [ -z "$CAPD_BUILD" ]; then
    echo "Cannot find value for env: CAPD_BUILD"
    availible_capd_build=$(cd ~/work/capd/build; echo */*)
    echo "Cannot find value for env: CAPD_BUILD"
    echo "Please set, e.g.:"
    for b in $availible_capd_build; do
        echo "CAPD_BUILD=$b"
    done
    exit 1
fi

if ! [ -e "${HOME}/work/capd/build/${CAPD_BUILD}" ] ; then
    echo "${HOME}/work/capd/build/${CAPD_BUILD} does not exist"
    exit 1
fi

exit 0
