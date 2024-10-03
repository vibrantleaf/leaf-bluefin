# Purpose
i like bluefin i just wanted to change a couple of little things & and add a few nice extras :3

#### how to rebase via rpm-ostree
```sh
# verify the image signiture is correct
wget -O /tmp/leaf-bluefin-cosign.pub https://raw.githubusercontent.com/vibrantleaf/leaf-bluefin/refs/heads/main/cosign.pub
cosign verify --key /tmp/leaf-bluefin-cosign.pub ghcr.io/vibrantleaf/leaf-bluefin:latest
rm /tmp/leaf-bluefin-cosign.pub

# rebase to the image
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vibrantleaf/leaf-bluefin:latest
```
