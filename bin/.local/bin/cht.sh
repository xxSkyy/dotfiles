#!/usr/bin/env bash

languages=$(echo "typescript rust golang c cpp" | tr " " "\n")
core_utils=$(echo "find xargs sed awk git" | tr " " "\n")
selected=$( echo -e "$languages\n$core_utils" | fzf )

read -p "QUERY: " query

separator="/"
if echo "$core_utils" | grep -qs $selected; then
  separator="~"
fi

curl cht.sh/$selected$separator$(echo "$query" | tr " " "+") 

