#!/bin/sh

if [ -z "${ANDROID_NDK_HOME}" ]
then
  echo 'android-toolchain-list.sh: fatal: ${ANDROID_NDK_HOME} is not set' 1>&2
  exit 1
fi

if [ ! -d "${ANDROID_NDK_HOME}/toolchains/" ]
then
  echo "android-toolchain-list.sh: fatal: ${ANDROID_NDK_HOME}/toolchains/ is not a directory!" 1>&2
  exit 1
fi

exec ls ${ANDROID_NDK_HOME}/toolchains/ | sort -u
