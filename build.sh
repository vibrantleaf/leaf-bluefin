#!/bin/bash
set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# setup COPRs & RPM repos
curl -Lo /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo \
  https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-${RELEASE}/matte-schwartz-sunshine-fedora-${RELEASE}.repo
curl -Lo etc/yum.repos.d/_copr_zeno-scrcpy.repo \
  https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-free.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-free-updates.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo

# remove unwanted packages
rpm-ostree override remove \
 gnome-shell-extension-search-light \
 gnome-shell-extension-logo-menu \
 gnome-classic-session \
 gnome-classic-session-xsession \
 yaru-theme \
 containerd.io \
 docker-ce \
 docker-ce-cli \
 docker-buildx-plugin \
 docker-compose-plugin \
 docker-ce-rootless-extras

# adding packages
rpm-ostree install \
  gnome-shell-extension-caffeine \
  podman-docker \
  podman-compose \
  corectrl \
  steam \
  qt5-qtbase.x86_64 \
  qt5-qtbase.i686 \
  libva.x86_64 \
  libva.i686 \
  mangohud \
  gamescope \
  gamemode \
  sunshine \
  libvirt-client \
  qemu-kvm \
  virt-install \
  virt-manager \
  edk2-ovmf \
  swtpm \
  tuned \
  bridge-utils \
  android-tools \
  scrcpy \
  waydroid

# systemd services
systemctl disable libvirtd.service
systemctl disable libvirtd.socket
for drv in qemu network nodedev nwfilter secret storage
do
  systemctl enable virt${drv}d.service
  systemctl enable virt${drv}d{,-ro,-admin}.socket
done
systemctl enable podman.socket
#systemctl disable docker.service
#systemctl disable docker.socket


# udev rules
git clone https://codeberg.org/fabiscafe/game-devices-udev /var/tmp/game-devices-udev
cp -rfv /var/tmp/game-devices-udev/*.rules /usr/share/ublue-os/udev-rules/etc/udev/rules.d

rpm-ostree install openrgb-udev-rules

# disable COPRs & RPM repos for release
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/_copr_zeno-scrcpy.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free-updates.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
