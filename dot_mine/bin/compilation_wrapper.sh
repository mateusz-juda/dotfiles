#!/bin/bash

# Based on gcc-rtags-wrapper.sh. MJ

if [ "$RTAGS_GCC_WRAPPER" = "1" ]; then
    echo 1>&2 "Recursive invocation of gcc-rtags-wrapper.sh detected"
    exit 1
fi



compiler="$(basename "$0")"

if hash rc 2>/dev/null; then

    [ -n "$RTAGS_SERVER_FILE" ] && RTAGS_ARGS="$RTAGS_ARGS -n$RTAGS_SERVER_FILE"
    [ -n "$RTAGS_PROJECT" ] && RTAGS_ARGS="$RTAGS_ARGS --project-root=$RTAGS_PROJECT"
    [ -z "$RTAGS_COMPILE_TIMEOUT" ] && RTAGS_COMPILE_TIMEOUT=3000

    if [ -z "$RTAGS_DISABLED" ]; then
        case $(basename "$compiler") in
            mpicc)
                cc=cc
                flags="$(mpicc -show|cut -d ' ' -f 2-) -DMPICH_NO_ATTR_TYPE_TAGS"
                ;;
            mpicxx)
                cc=c++
                flags="$(mpicxx -show|cut -d ' ' -f 2-) -DMPICH_NO_ATTR_TYPE_TAGS"
                ;;
            *)
                cc="$compiler"
                # nie dziala na osx, libclang ma inne sciezki niz clang !
                [ "$(uname -s)" == "Darwin" ] && flags="-isystem/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1 -isystem/Library/Developer/CommandLineTools/usr/include"
                ;;
        esac

        rc --timeout=$RTAGS_COMPILE_TIMEOUT $RTAGS_ARGS --silent --compile "$cc" $flags "$@" &
        disown &>/dev/null # rc might be finished by now and if so disown will yell at us
    fi

    export RTAGS_GCC_WRAPPER=1
fi


export DISTCC_HOSTS="$CAPD_DISTCC_HOSTS"
exec $CAPD_CXX_WRAP $compiler "$@"
