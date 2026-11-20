#!/bin/bash

compiler=$(basename $1)
shift
exec distcc "$compiler" "$@"
