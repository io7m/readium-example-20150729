#!/bin/sh

if [ $# -ne 1 ]
then
  echo "usage: file" 1>&2
  exit 1
fi

FILE="$1"
shift

for f in `cat ${FILE}`
do
  OBJECT=`echo "$f" | sed 's/\.cpp$/.o/g'` || exit 1
  DIRNAME=`dirname ${OBJECT}` || exit 1
cat <<EOF
\${OBJECT_DIR}/${OBJECT}: \\
\${OBJECT_DIR} \\
$f
	mkdir -p \${OBJECT_DIR}/${DIRNAME}
	\${READIUM_CXX_COMPILE} -o \${OBJECT_DIR}/${OBJECT} $f

EOF
done

cat <<EOF
\${OBJECT_DIR}/readium.a: \\
\${OBJECT_DIR} \\
EOF

for f in `cat ${FILE}`
do
  OBJECT=`echo "$f" | sed 's/\.cpp$/.o/g'` || exit 1
cat <<EOF
\${OBJECT_DIR}/${OBJECT} \\
EOF
done

cat <<EOF
	\${AR} rc \${OBJECT_DIR}/readium.a \\
EOF

for f in `cat ${FILE}`
do
  OBJECT=`echo "$f" | sed 's/\.cpp$/.o/g'` || exit 1
cat <<EOF
\${OBJECT_DIR}/${OBJECT} \\
EOF
done

cat <<EOF
	\${RANLIB} \${OBJECT_DIR}/readium.a

EOF

