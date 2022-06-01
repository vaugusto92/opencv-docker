#!/bin/bash

function log_info() {
  echo
  echo $1
  echo
}

function validate_test_log() {
  if ! grep -q "$1" $2; then exit 1; fi
}

function run_test() {
  log_info "Running $1 health check."

  cd /work/samples/$1-sample

  if [ $1 == 'java' ]; then
    ant -DopencvJarPath=$OPENCV_JAVA_BINARY_PATH \
        -DopencvLibraryPath=$OPENCV_JAVA_LIBRARY_PATH rebuild-run | tee java.log

    validate_test_log 'BUILD SUCCESSFUL' 'java.log'
  fi

  if [ $1 == 'clojure' ]; then
    lein test | tee clojure.log
    validate_test_log '0 failures, 0 errors.' 'clojure.log'
  fi
}


run_test java
run_test clojure

cd /work

./clean-samples.sh

log_info "Health check successful!"
