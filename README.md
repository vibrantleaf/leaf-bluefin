# Purpose
I like bluefin, I just wanted to change a couple of little things and add a few nice extras.

#### how to rebase via rpm-ostree
```sh
# verify the image signiture is correct
wget -O /tmp/leaf-bluefin-cosign.pub https://raw.githubusercontent.com/vibrantleaf/leaf-bluefin/refs/heads/main/cosign.pub
cosign verify --key /tmp/leaf-bluefin-cosign.pub ghcr.io/vibrantleaf/leaf-bluefin:latest
rm /tmp/leaf-bluefin-cosign.pub

# rebase to the image
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vibrantleaf/leaf-bluefin:latest
```

### build localy for a testing
```sh
# get sources
git clone https://github.com/vibrantleaf/leaf-bluefin.git

# get blue-build cli via distrobox
distrobox create blue-build --image ghcr.io/blue-build/cli:latest
distrobox enter blue-build
distrobox-export --bin $(which bluebuild)
exit
bluebuild completions bash | tee ~/.local/share/bash-completion/completions/bluebuild

# generate Contianerfile from the recipe.yaml
bluebuild generate -o ./Containerfile ./recipes/recipe.yaml

# with podman
podman build -t leaf-bluefin-test-build:latest .

# or with buildah
buildah bud -t leaf-bluefin-test-build:latest .

# or with docker
ln -s ./Containerfile ./Dockerfile # symlink Containerfile to Dockerfile for better Docker Compatibility
docker build -t leaf-bluefin-test-build:latest .
```

### things i changed & why
#### Removed:
- docker: i dont need docker
- gnome-classic: i dont like gnome-classic
- yaru-theme: i think it donsent look that nice
- search-light & logo-menu gnome extentions: i dont need or want them
#### Added:
- added the following udev-rule packs
  - [fabiscafe/game-devices-udev](https://github.com/fabiscafe/game-devices-udev)
  - [wget/realtek-r8152-linux](https://github.com/wget/realtek-r8152-linux/)
  - [openrgb-udev-rules](https://packages.fedoraproject.org/pkgs/openrgb/openrgb-udev-rules/)
  - steam-devices
  - [solaar-udev](https://packages.fedoraproject.org/pkgs/solaar/solaar-udev/)
- custom .just files: for some nice shortcuts
- caffeine gnome-extention: i find this really useful
- corectrl: for expermenting with uv/oc
- sunshine: i find this really useful
- android-tools & scrcpy: for conntroling android devices
- waydroid: android app compatibility
- ~steam: tends to have better compatabilty compared to the flatpak~ (temporarily removed due to a dependency bug)
- gamemode , gamescope , qt5-base & mangohud: for gaming stuff 
- All gstreamer media codecs: for wider media file support
- libdvdcss: for dvd/bluray playback support
- modular libvirtd systemd services & tuned: for better virtualisaion
# changed
- default settings chaged
  - default fonts
    - sans: 'Inter Variable 13'
    - document: 'Inter Variable 13'
    - monospace: 'JetBrains Mono 18'
    - terminal: 'JetBrains Mono 18'

:3
