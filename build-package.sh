#!/usr/bin/env bash

set -e

OMNIEDGE_VERSION=$1
ARCH=$2

download_omniedge() {
  local base_url="https://github.com/omniedgeio/omniedge-linux-cli/releases/download"
  local pkg_name="omniedge-${ARCH}.zip"
  local src_pkg="${base_url}/v${OMNIEDGE_VERSION}/${pkg_name}"
  local dest_pkg="_omniedge/v${OMNIEDGE_VERSION}/${pkg_name}"
  mkdir -p ./_omniedge/v${OMNIEDGE_VERSION}

  echo ">>> Downloading package: ${src_pkg}"
  wget --no-verbose -c ${src_pkg} -O ${dest_pkg}

  echo ">>> Extracting.."
  unzip ${dest_pkg} -d ./_omniedge/v${OMNIEDGE_VERSION}
}

make_pkg() {
  mkdir -p ./_build
  local pkg_temp_dir=$(mktemp -d -p ./_build)
  local spk_temp_dir=$(mktemp -d -p ./_build)

  make_inner_pkg ${pkg_temp_dir} ${spk_temp_dir}
  make_spk ${spk_temp_dir}
  echo ">> Done"
  echo ""
  rm -rf ${spk_temp_dir} ${pkg_temp_dir}
}

main() {
  echo "> Building package for OMNIEDGE_VERSION=${OMNIEDGE_VERSION} ARCH=${ARCH}"
  download_omniedge
  make_pkg
}

main