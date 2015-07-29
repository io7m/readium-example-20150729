#!/bin/sh

fatal()
{
  echo "android-toolchains-make.sh: fatal: $1" 1>&2
  exit 1
}

if [ -z "${ANDROID_NDK_HOME}" ]
then
  fatal '${ANDROID_NDK_HOME} is not set' 1>&2
fi

TOOLCHAINS=`grep -v '^#' android-toolchains.conf || fatal "could not load android-toolchains.conf"`
if [ -z "${TOOLCHAINS}" ]
then
  fatal "no toolchains specified in android-toolchains.conf"
fi

rm -f android-toolchains.map.tmp

for TOOLCHAIN in ${TOOLCHAINS}
do
  echo "Generating ${TOOLCHAIN} in ./android-toolchains/${TOOLCHAIN}"
  ${ANDROID_NDK_HOME}/build/tools/make-standalone-toolchain.sh \
    --platform=android-14 \
    --toolchain="${TOOLCHAIN}" \
    --install-dir="./android-toolchains/${TOOLCHAIN}" ||
      fatal "could not generate toolchain ${TOOLCHAIN}"

  GCC=`ls ./android-toolchains/${TOOLCHAIN}/bin/*-g++` ||
    fatal "could not find ./android-toolchains/${TOOLCHAIN}/bin/\*-g++"
  GCC_BASE=`basename "${GCC}"` ||
    fatal "could not resolve g++ basename"
  NO_GCC=`echo "${GCC_BASE}" | sed 's/-g++$//g'` ||
    fatal "could not extract short toolchain name"

  echo "${TOOLCHAIN}:${NO_GCC}:android" >> android-toolchains.map.tmp
done

mv android-toolchains.map.tmp android-toolchains.map ||
  fatal "could not rename android-toolchains.map.tmp → android-toolchains.map"

