#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

DIR="$(dirname $1)"
BASE_NAME="$(basename -s .asm "$1")"

ASM_FILE="${DIR}/${BASE_NAME}.asm"
OBJ_FILE="${DIR}/${BASE_NAME}.obj"
BIN_FILE="${DIR}/${BASE_NAME}.bin"

if [ ! -f "$ASM_FILE" ]; then
    echo "$ASM_FILE does not exist."
    exit 2
fi

lc3as "$ASM_FILE"
if [ $? -ne 0 ]; then
    echo "Failed to assemble $ASM_FILE"
    exit 3
fi

xxd -b -c 2 "$OBJ_FILE" | awk '{print $2 $3}' > "$BIN_FILE"

echo "Converted $ASM_FILE to $BIN_FILE"
