#!/bin/sh

BIN_DIR=`dirname "$0"`

${BIN_DIR}/bin/dk168 eval ChatApi.Release.rollback
