#!/bin/bash
set -ouex pipefail
RELEASE="$(rpm -E %fedora)"


# COPRs
curl -Lo /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo \
  https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-${RELEASE}/matte-schwartz-sunshine-fedora-${RELEASE}.repo

# udev rules
git clone https://codeberg.org/fabiscafe/game-devices-udev /var/tmp/game-devices-udev
cp -rfv /var/tmp/game-devices-udev/*.rules /usr/share/ublue-os/udev-rules/etc/udev/rules.d


# added packages
rpm-ostree install \
  libvirt-client \
  qemu-kvm \
  virt-install \
  virt-manager \
  swtpm \
  tuned \
  bridge-utils \
  screen \
  steam \
  steam-devices \
  sunshine \
  git \
  stow \
  android-tools \
  ImageMagick \
  ffmpeg

# removed packages
#rpm-ostree override remove


# systemd services
systemctl disable libvirt.service
systemctl disable libvirt.socket
for drv in qemu network nodedev nwfilter secret storage
do
  systemctl enable virt${drv}d.service
  systemctl enable virt${drv}d{,-ro,-admin}.socket
done
systemctl enable podman.socket


#rm /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo
