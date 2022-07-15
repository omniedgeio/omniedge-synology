#!/bin/bash

VERSION=$1
ARCH=$2
PKG_SIZE=$3
OS_VERSION=$4

TIMESTAMP=$(date -u +%Y%m%d-%H:%M:%S)

case $OS_VERSION in
    dsm7)
      os_min_ver="7.0-40851"
      ;;
    dsm6)
      os_min_ver="6.1-15047"
      ;;
    *)
      echo "Unsupported architecture: ${OS_VERSION}"
      exit 1
      ;;
esac

# architecture taken from:
# https://github.com/SynoCommunity/spksrc/wiki/Synology-and-SynoCommunity-Package-Architectures
# https://github.com/SynologyOpenSource/pkgscripts-ng/tree/master/include platform.<PLATFORM> files
case $ARCH in
amd64)
  PLATFORMS="x64 x86 apollolake avoton braswell broadwell broadwellnk bromolow cedarview denverton dockerx64 grantley purley kvmx64 x86_64"
  ;;
386)
  PLATFORMS="evansport"
  ;;
arm64v8)
  PLATFORMS="aarch64 armv8 rtd1296 armada37xx"
  ;;
armv7)
  PLATFORMS_ARM5="armv5 88f6281 88f628x"
  PLATFORMS_ARM7="armv7 alpine armada370 armada375 armada38x armadaxp comcerto2k monaco hi3535 ipq806x northstarplus dakota"
  PLATFORMS="${PLATFORMS_ARM5} ${PLATFORMS_ARM7}"
  ;;
*)
  # PLATFORMS_PPC="powerpc ppc824x ppc853x ppc854x qoriq"
  echo "Unsupported architecture: ${ARCH}"
  exit 1
  ;;
esac

cat <<EOF
package="omniedge"
version="${VERSION}"
arch="${PLATFORMS}"
description="Bring Intranet on the Internet."
description_chs="端到端企业 VPN 解决方案，无需公网 IP，无需端口转发，无需反向代理。"
displayname="Omniedge"
maintainer="brucebot, mtx2d"
maintainer_url="https://github.com/omniedgeio/omniedge-synology"
create_time="${TIMESTAMP}"
extractsize=${PKG_SIZE}
os_min_ver=${os_min_ver}
EOF
