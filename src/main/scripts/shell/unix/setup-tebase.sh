#!/bin/bash
# Sets up a TEAM-engine instance with test suites listed in a CSV file.
# Reads a CSV file (first argument) where each record contains two fields:
# Git repository URL, tag name
# Example:
# https://github.com/opengeospatial/ets-wfs20.git,1.25
#
# Note: Maven and Git must be installed and available on the system path

base=$(dirname $(readlink -f $0))
if [ -r $base/setenv.sh ]
then
  . $base/setenv.sh
fi

[ -z "$JAVA_HOME" ] && echo "JAVA_HOME must be set." && exit 1
[ -z "$ETS_SRC" ] && echo "ETS_SRC must be set." && exit 1
[ -z "$1" ] && echo "Location of CSV file not specified." && exit 1
csvfile="$(readlink -f "$1")"

pushd $ETS_SRC
PREV_IFS=$IFS
IFS=","
# last record in CSV file may not have a terminal newline
while read url tag || [ -n "$url" ]
do
  if ! [[ $url =~ http.* ]] || [[ $url =~ ^#.* ]]; then
    continue  # skip header record or comment line
  fi
  ets_name=$(basename "$url" .git)
  if [ -z "$ets_name" ]; then
    break
  fi
  if [ -d "$ETS_SRC/$ets_name" ]; then
    pushd $ets_name
    git fetch --tags
  else
    git clone $url
    pushd $ets_name
  fi
  git checkout $tag
  mvn -DskipTests clean install
  cp target/*-ctl.zip $TE_BASE/scripts/
  popd
done < "$csvfile"
IFS=$PREV_IFS

pushd $TE_BASE/scripts
# filename patterns that match no files will expand to null string
shopt -s nullglob
for f in *.zip
do
  "$JAVA_HOME"/bin/jar xf "$f"
  rm "$f"
done

pushd $base
rsync -r --delete ../../lib/ $TE_BASE/resources/lib
