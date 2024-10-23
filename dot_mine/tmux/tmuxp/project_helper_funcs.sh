#!/bin/bash

set -e

if [ -z "${me_workspace_path_v}" ]; then
    echo "me_workspace_path not set"
    exit 1
fi

function me_workspace_path () {
    echo "${me_workspace_path_v}"
}

if [ -z "${me_workspace_name_v}" ]; then
    echo "me_workspace_name_v not set"
    exit 1
fi

function me_workspace_name () {
    echo "${me_workspace_name_v}"
}

function me_project_name () {
    [ -z "${me_project_name_v}" ] && exit 1    
    echo "${me_project_name_v}"
#    echo "$(tmux display-message -p '#W')" # does not work when panes are not focused
}

function me_docker_name ()
{
    echo "$(me_project_name_v)-${RANDOM}"
}

function me_src_path () {
    echo "$(me_workspace_path)/$(me_project_name)"
}

function me_build_path () {
    build_type="$1"
    [ -z "${build_type}" ] && exit 1
    path="/var/work/builds/$(me_project_name)/build_${build_type}"
    echo "${path}"
}

function me_switch_build_type () {
    build_type="$1"    
    [ -z "${build_type}" ] && exit 1
    build_path="$(me_build_path ${build_type})"
    mkdir -p "${build_path}"
    cd "${build_path}"
    export me_build_type_v="${build_type}"
    export me_build_path_v="${build_path}"
}

function me_build_type () {
   echo "${me_build_type_v}"
}

function me_call_cmake () {
    cmake -GNinja -DCMAKE_BUILD_TYPE=$(me_build_type) -DCMAKE_EXPORT_COMPILE_COMMANDS=1 $(me_src_path)
}


set +e

