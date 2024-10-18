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

### build localy for testing
```sh
# Get the blue-build CLI via DistroBox
distrobox create blue-build --image ghcr.io/blue-build/cli:latest
distrobox enter blue-build
distrobox-export --bin $(which bluebuild)
exit 0
bluebuild completions bash | tee ~/.local/share/bash-completion/completions/bluebuild

# Get the Image SourceCode
git clone https://github.com/vibrantleaf/leaf-bluefin.git /var/tmp/leaf-bluefin
cd /var/tmp/leaf-bluefin
git pull

# Generate Contianerfile from the recipe.yaml
bluebuild generate -o /var/tmp/leaf-bluefin/Containerfile /var/tmp/leaf-bluefin/recipes/recipe.yaml

# Build the Image using Podman
podman build -t leaf-bluefin-test-build:latest /var/tmp/leaf-bluefin

# or Build the Image using Buildah
buildah bud -t leaf-bluefin-test-build:latest /var/tmp/leaf-bluefin

# or Build the Image using Docker
ln -s /var/tmp/leaf-bluefin/Containerfile /var/tmp/leaf-bluefin/Dockerfile # symlink Containerfile to Dockerfile for better Docker Compatibility
docker build -t leaf-bluefin-test-build:latest /var/tmp/leaf-bluefin

# or Build the Immage using Blue Build CLI directly
# via podman
bluebuild build \
  --platform 'linux/amd64' \
  --compression-format zstd \
  --signing-driver cosign \
  --build-driver podman \
  --run-driver podman \
  --inspect-driver podman

# via buildah/skepeo
bluebuild build \
  --platform 'linux/amd64' \
  --compression-format zstd \
  --signing-driver cosign \
  --build-driver buildah \
  --run-driver buildah \
  --inspect-driver skopeo

# via docker
bluebuild build \
  --platform 'linux/amd64' \
  --compression-format zstd \
  --signing-driver cosign \
  --build-driver docker \
  --run-driver docker \
  --inspect-driver docker
   

# Create and Run a test Container from the Test Build Image using Podman
podman run -it --rm --name leaf-bluefin-test-build-container leaf-bluefin-test-build:latest /usr/bin/bash

# or Create and Run a test Container from the Test Build Image using Docker
docker run -it --rm --name leaf-bluefin-test-build-container leaf-bluefin-test-build:latest /usr/bin/bash

# Clean up
cd ~
rm -rf /var/tmp/leaf-bluefin
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
- rpmfusion fireware: 
# changed
- default settings chaged
  - default fonts
    - sans: 'Inter Variable 13'
    - document: 'Inter Variable 13'
    - monospace: 'JetBrains Mono 18'
    - terminal: 'JetBrains Mono 18'

:3
