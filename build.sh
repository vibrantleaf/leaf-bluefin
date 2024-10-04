#!/bin/bash
set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# setup COPRs & RPM repos
# get new repos & coprs
curl -Lo /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo \
  https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-${RELEASE}/matte-schwartz-sunshine-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_copr_zeno-scrcpy.repo \
  https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo
# enable repos & coprs
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo 
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/_copr_zeno-scrcpy.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-cisco-openh264.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free-updates.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
# disable testing repos & coprs
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
# get rpmfusion tainted repos
rpm-ostree install rpmfusion-free-release-tainted
rpm-ostree install rpmfusion-nonfree-release-tainted

# insure rpm-fussion codecs are installed
rpm-ostree install \
  libdvdcss \
  gstreamer1-plugin-libav \
  gstreamer1-plugins-bad-free-extras \
  gstreamer1-plugins-bad-freeworld \
  gstreamer1-plugins-ugly \
  gstreamer1-vaapi \
  ffmpeg

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
# system
rpm-ostree install \
  gnome-shell-extension-caffeine \
  podman-docker \
  podman-compose \
  duperemove \
  corectrl
# gameing
rpm-ostree install \
  steam \
  qt5-qtbase \
  libva \
  mangohud \
  gamescope \
  gamemode \
  sunshine
# virtualization 
rpm-ostree install \
  libvirt-client \
  qemu-kvm \
  libvirt-daemon-kvm \
  libvirt-daemon-config-network \
  virt-install \
  virt-manager \
  edk2-ovmf \
  swtpm \
  virt-top \
  libguestfs-tools \
  tuned \
  bridge-utils
# misc
rpm-ostree install \
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

# udev rules
git clone https://codeberg.org/fabiscafe/game-devices-udev /var/tmp/game-devices-udev
cp -rfv /var/tmp/game-devices-udev/*.rules /usr/share/ublue-os/udev-rules/etc/udev/rules.d
git clone https://github.com/wget/realtek-r8152-linux/ /var/tmp/realtek-r8152-udev
cp -rfv /var/tmp/realtek-r8152-udev/*.rules /usr/share/ublue-os/udev-rules/etc/udev/rules.d
rpm-ostree install \
  openrgb-udev-rules \
  steam-devices


# add custom .just files to the justfile
echo 'import "/usr/share/ublue-os/just/95-setup-waydroid.just"' | tee -a /usr/share/ublue-os/justfile


# disable COPRs & RPM repos for release
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-cisco-openh264.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_zeno-scrcpy.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free-updates.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
