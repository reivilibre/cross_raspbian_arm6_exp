#!/bin/bash
set -x
set -euo pipefail

arch="${1}"
shift

# need to install certain local dependencies
export DEBIAN_FRONTEND=noninteractive
apt-get update
# XXX
# apt-get install --assume-yes --no-install-recommends \
apt-get install --assume-yes \
  ca-certificates \
  curl \
  cpio \
  sharutils \
  gnupg

# get our debian sources
#debsource="deb http://http.debian.net/debian/ buster main"
#debsource="${debsource}\ndeb http://security.debian.org/ buster/updates main"

# XXX tried both bullseye (what's installed) and buster (the same as in the working plain Debian version)
#debsource="deb http://raspbian.raspberrypi.org/raspbian/ bullseye main contrib non-free rpi"
debsource="deb http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi"

# temporarily use debian sources rather than ubuntu.
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo -e "${debsource}" > /etc/apt/sources.list

# XXX Removing Ubuntu's ports seemed sensible because Ubuntu/Debian has a different meaning of 'armhf'
# than Raspbian does.
# I run into trouble either way.
rm /etc/apt/sources.list.d/ports.list

dpkg --add-architecture "${arch}" || echo "foreign-architecture ${arch}" \
  > /etc/dpkg/dpkg.cfg.d/multiarch

# XXX Just add the raspbian key manually
# Add Debian keys.
#curl --retry 3 -sSfL 'https://ftp-master.debian.org/keys/archive-key-{7.0,8,9,10}.asc' -O
#curl --retry 3 -sSfL 'https://ftp-master.debian.org/keys/archive-key-{8,9,10}-security.asc' -O
#curl --retry 3 -sSfL 'https://ftp-master.debian.org/keys/release-{7,8,9,10}.asc' -O
#curl --retry 3 -sSfL 'https://www.ports.debian.org/archive_{2020,2021,2022}.key' -O

apt-key add - <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jdXNIMueS/4=
=zkQk
-----END PGP PUBLIC KEY BLOCK-----
EOF

#for key in *.asc *.key; do
#  apt-key add "${key}"
#  rm "${key}"
#done

# allow apt-get to retry downloads
echo 'APT::Acquire::Retries "3";' > /etc/apt/apt.conf.d/80-retries

apt-get update
for dep in $@; do
  apt-get install "${dep}:${arch}" --assume-yes
done

# restore our old sources list
mv -f /etc/apt/sources.list.bak /etc/apt/sources.list
if [ -f /etc/dpkg/dpkg.cfg.d/multiarch.bak ]; then
    mv /etc/dpkg/dpkg.cfg.d/multiarch.bak /etc/dpkg/dpkg.cfg.d/multiarch
fi

# can fail if arch is used (amd64 and/or i386)
dpkg --remove-architecture "${arch}" || true
apt-get update
