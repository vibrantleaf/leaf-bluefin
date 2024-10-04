waydroid-init-gapps:
    sudo waydroid init --force \
        --system_channel https://ota.waydro.id/system \
        --vendor_channel https://ota.waydro.id/vendor \
        ---system_type GAPPS

waydroid-init-vanilla:
    sudo waydroid init --force \
        --system_channel https://ota.waydro.id/system \
        --vendor_channel https://ota.waydro.id/vendor \
        ---system_type VANILLA

waydroid-init-foss:
    sudo waydroid init --force \
        --system_channel https://ota.waydro.id/system \
        --vendor_channel https://ota.waydro.id/vendor \
        ---system_type FOSS