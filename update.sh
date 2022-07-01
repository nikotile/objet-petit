#!/bin/sh

# /objet-petit
# ├── update.sh
# └── entries
#    ├── yaml
#    |  └── *.yaml
#    └── json
#       └── *.json

[ -z $(command -v jc) ] && echo "Please install jc" && exit 1
[ ! -d entries/json ] && mkdir entries/json

for f in entries/yaml/*.yaml; do
  out="${f:13}"
  content=$(cat $f | jc --yaml -p | head -n -1 | tail -n +2 | sed "s/^\s\s//")
  [ ! -z "$content" ] && echo $content > entries/json/"${out%.yaml}".json || echo "Invalid: $f"
done
