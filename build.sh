#!/bin/bash
set -ouex pipefail
RELEASE="$(rpm -E %fedora)"


# COPRs & RPM repos
curl -Lo /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo \
  https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-${RELEASE}/matte-schwartz-sunshine-fedora-${RELEASE}.repo

rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${REALEASE}.noarch.rpm
rpm-ostree install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm
rpm-ostree install rpmfusion-free-tainted
rpm-ostree install rpmfusion-nonfree-tainted


# udev rules
git clone https://codeberg.org/fabiscafe/game-devices-udev /var/tmp/game-devices-udev
cp -rfv /var/tmp/game-devices-udev/*.rules /usr/share/ublue-os/udev-rules/etc/udev/rules.d



# codecs
#rpm-ostree install \
#  gstreamer1-plugin-libav \
#  gstreamer1-plugins-bad-free-extras \
#  gstreamer1-plugins-bad-freeworld \
#  gstreamer1-plugins-ugly \
#  gstreamer1-vaapi

#rpm-ostree override remove \
#  libavcodec-free \
#  libavfilter-free \
#  libavformat-free \
#  libavutil-free \
#  libpostproc-free \
#  libswresample-free \
#  libswscale-free --install ffmpeg

#rpm-ostree override remove mesa-va-drivers --install mesa-va-drivers-freeworld
#rpm-ostree override remove mesa-vdpau-drivers --install mesa-vdpau-drivers-freeworld


# added packages
rpm-ostree install steam
rpm-ostree install sunshine
rpm-ostree install android-tools

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
