#!/bin/bash
set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# setup COPRs & RPM repos
# get new repos & coprs
curl -Lo /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo \
  https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-${RELEASE}/matte-schwartz-sunshine-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_copr_zeno-scrcpy.repo \
  https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo

rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release.${RELEASE}.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm

# enable repos & coprs
# copr: matte-schwartz/sunshine
if [ -f /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo 
else
  echo 'file /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo is missing'
  exit 1
fi 
# copr: zeno/scrcpy
if [ -f /etc/yum.repos.d/_copr_zeno-scrcpy.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/_copr_zeno-scrcpy.repo
else
  echo 'file /etc/yum.repos.d/_copr_zeno-scrcpy.repo is missing'
  exit 1
fi 
# fedora-cisco-openh264
if [ -f /etc/yum.repos.d/fedora-cisco-openh264.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-cisco-openh264.repo
else
  echo 'file /etc/yum.repos.d/fedora-cisco-openh264.repo is missing'
  exit 1
fi 
# rpmfusion-free
if [ -f /etc/yum.repos.d/rpmfusion-free.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-free.repo is missing'
  exit 1
fi 
# rpmfusion-free-updates
if [ -f /etc/yum.repos.d/rpmfusion-free-updates.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-free-updates.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-free-updates.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree
if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree-updates
if [ -f /etc/yum.repos.d/rpmfusion-nonfree-updates.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree-updates.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree-steam
if [ -f /etc/yum.repos.d/rpmfusion-nonfree-steam.repo ]
then
  sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree-steam.repo is missing'
  exit 1
fi 
# disable testing repos & coprs
#rpmfusion-free-updates-testing
if [ -f /etc/yum.repos.d/rpmfusion-free-updates-testing.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-free-updates-testing.repo is missing'
fi 
# rpmfusion-nonfree-updates-testing
if [ -f /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo is missing'
fi 

# get rpmfusion tainted repos
rpm-ostree install rpmfusion-free-release-tainted
rpm-ostree install rpmfusion-nonfree-release-tainted
