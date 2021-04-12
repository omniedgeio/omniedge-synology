#!/usr/bin/env bash

set -e

OMNIEDGE_VERSION=$1
ARCH=$2

download_omniedge() {
  local base_url="https://github.com/omniedgeio/omniedge-linux-cli/releases/download"
  local pkg_name="omniedge-${ARCH}.zip"
  local src_pkg="${base_url}/v${OMNIEDGE_VERSION}/${pkg_name}"
  local dest_dir="_omniedge/omniedge_v${OMNIEDGE_VERSION}_${ARCH}"
  local dest_pkg="${dest_dir}/${pkg_name}"
  mkdir -p ${dest_dir}

  echo ">>> Downloading package: ${src_pkg}"
  wget --no-verbose -c ${src_pkg} -O ${dest_pkg}

  echo ">>> Extracting.."
  unzip ${dest_pkg} -d ${dest_dir}
}

make_inner_pkg() {
  local tmp_dir=$1
  local dest_dir=$2
  local dest_pkg="${dest_dir}/package.tgz"
  local omniedge_dir="_omniedge/omniedge_${OMNIEDGE_VERSION}_${ARCH}"

  echo ">>> Making inner package.tgz"
  mkdir -p ${tem_dir}/bin
  cp -a ${omniedge_dir}/omniedge ${tmp_dir}/bin/
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