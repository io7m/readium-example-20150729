#!/bin/sh

INCLUDES=""
INCLUDES="${INCLUDES} -I readium-sdk/Platform/Android/include"
exec echo ${INCLUDES}
