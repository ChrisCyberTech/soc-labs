#!/usr/bin/env bash
SRC_PATH="$1"
if [ -z "${SRC_PATH}" ]; then
  echo "Provide Windows path to artifacts folder, e.g. C:/Temp/forensics"
  exit 1
fi
DEST="$(pwd)/artifacts/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$DEST"
cp -r "$SRC_PATH"/* "$DEST"/
echo "Copied artifacts to $DEST"
