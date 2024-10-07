#!/bin/bash
set -ouex pipefail

# disable COPRs & RPM repos for release
# fedora-cisco-openh264
if [ -f /etc/yum.repos.d/fedora-cisco-openh264.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-cisco-openh264.repo
else
  echo 'file /etc/yum.repos.d/fedora-cisco-openh264.repo is missing'
  exit 1
fi 
# copr: matte-schwartz/sunshine
if [ -f /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo
else
  echo 'file /etc/yum.repos.d/_copr_matte-schwartz_sunshine.repo is missing'
  exit 1
fi 
# copr: zeno/scrcpy
if [ -f /etc/yum.repos.d/_copr_zeno-scrcpy.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_zeno-scrcpy.repo
else
  echo 'file /etc/yum.repos.d/_copr_zeno-scrcpy.repo is missing'
  exit 1
fi 
# rpmfusion-free
if [ -f /etc/yum.repos.d/rpmfusion-free.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-free.rep is missing'
  exit 1
fi 
# rpmfusion-free-updates
if [ -f /etc/yum.repos.d/rpmfusion-free-updates.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free-updates.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-free-updates.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree
if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree-updates
if [ -f /etc/yum.repos.d/rpmfusion-nonfree-updates.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree-updates.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree-updates-steam
if [ -f /etc/yum.repos.d/rpmfusion-nonfree-steam.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree-steam.repo is missing'
  exit 1
fi 
# rpmfusion-free-updates-testing
if [ -f /etc/yum.repos.d/rpmfusion-free-updates-testing.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-free-updates-testing.repo is missing'
  exit 1
fi 
# rpmfusion-nonfree-updates-testing
if [ -f /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo ]
then
  sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
else
  echo 'file /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo is missing'
  exit 1
fi
