#!/usr/bin/env bash
#
# Detect which version of pipeline should be installed
# First it tries nightly
# If that doesn't work it tries previous releases (until the MAX_SHIFT variable)
# If not it exit 1
# It can take the argument --only-stable-release to not do nightly but only detect the pipeline version

set -eu

PROJECT=$1; shift
[[ -z "$PROJECT" ]] && {
  echo "ERROR: must provide a project"
  exit 1
}

MAX_SHIFT=${MAX_SHIFT:-5}

set_release_vars(){
  case "$PROJECT" in
    pipeline)
      NIGHTLY_RELEASE="https://raw.githubusercontent.com/openshift/tektoncd-pipeline/release-next/openshift/release/tektoncd-pipeline-nightly.yaml"
      STABLE_RELEASE_URL='https://raw.githubusercontent.com/openshift/tektoncd-pipeline/${version}/openshift/release/tektoncd-pipeline-${version}.yaml'
      return ;;
    triggers)
      export NIGHTLY_RELEASE="https://raw.githubusercontent.com/openshift/tektoncd-triggers/release-next/openshift/release/tektoncd-triggers-nightly.yaml"
      export STABLE_RELEASE_URL='https://raw.githubusercontent.com/openshift/tektoncd-triggers/${version}/openshift/release/tektoncd-triggers-${version}.yaml'
      return ;;
     *)
       echo "ERROR: unknown project $PROJECT"
       return 1
  esac
}


get_version() {
  local shift_by=${1}; shift # 0 is latest, increase is the version before etc...

  local version=$(
      curl -s "https://api.github.com/repos/tektoncd/$PROJECT/releases"|
      python -c "
from pkg_resources import parse_version
import sys, json

# shift by should be the last arg
shift_by = int(sys.argv[-1])
releases = json.load(sys.stdin)

print(sorted([x['tag_name'] for x in releases], key=parse_version, reverse=True)[shift_by])
"     "$shift_by")

  echo $(eval echo ${STABLE_RELEASE_URL})
}

url_exists() {
  curl -s -o /dev/null -f ${1} || return 1
}


### main ###

set_release_vars || exit 1

if [[ "${1:-}" != "--only-stable-release" ]];then
  url_exists ${NIGHTLY_RELEASE} && {
    echo ${NIGHTLY_RELEASE}
    exit 0
  }
fi

for shifted in `seq 0 ${MAX_SHIFT}`;do
  version_yaml=$(get_version ${shifted})
  url_exists ${version_yaml} && {
    echo ${version_yaml}
    exit 0
  }
done

exit 1
