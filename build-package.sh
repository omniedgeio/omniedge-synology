#!/bin/bash

set -e

OMNIEDGE_VERSION=$1
SYNOLOGY_VERSION=${OMNIEDGE_VERSION}+".2"
ARCH=$2

download_omniedge() {
  local base_url="https://github.com/omniedgeio/app-release/releases/download"
  local pkg_name="omniedgecli-${ARCH}.zip"
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
  local omniedge_dir="_omniedge/omniedge_v${OMNIEDGE_VERSION}_${ARCH}"

  echo ">>> Making inner package.tgz"
  mkdir -p ${tmp_dir}/bin
  cp -a ${omniedge_dir}/omniedge ${tmp_dir}/bin/

  #TODO: does omniedge have a daemon? Shall we add logrotate conf?
  pkg_size=$(du -sk "${tmp_dir}" | awk '{print $1}')
  echo "${pkg_size}" >> "${dest_dir}/extractsize_tmp"

  # Creating tar based on output of ls
  ls --color=no ${tmp_dir} | tar -cJf ${dest_pkg} -C "${tmp_dir}" -T /dev/stdin
}

make_spk() {
  local spk_tmp_dir=$1
  local spk_dest_dir="./spks"
  local pkg_size=$(cat ${spk_tmp_dir}/extractsize_tmp)
  local spk_filename="omniedge_${SYNOLOGY_VERSION}_${ARCH}.spk"

  echo ">>> Making spk: ${spk_filename}"
  mkdir -p ${spk_dest_dir}
  rm "${spk_tmp_dir}/extractsize_tmp"

  # copy scripts and icon
  cp -ra src/scripts ${spk_tmp_dir}
  cp -a src/PACKAGE_ICON*.PNG ${spk_tmp_dir}
  cp -ra src/WIZARD_UIFILES ${spk_tmp_dir}
  cp -ra src/log ${spk_tmp_dir}
  cp -ra src/conf ${spk_tmp_dir}

  # generate INFO file
  ./src/INFO.sh "${SYNOLOGY_VERSION}" ${ARCH} ${pkg_size} >"${spk_tmp_dir}"/INFO

  tar -cf "${spk_dest_dir}/${spk_filename}" -C "${spk_tmp_dir}" $(ls ${spk_tmp_dir})
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
  echo "> Building package for OMNIEDGE_VERSION=${OMNIEDGE_VERSION} SYNOLOGY_VERSION=${SYNOLOGY_VERSION} ARCH=${ARCH}"
  download_omniedge
  make_pkg
}

main
