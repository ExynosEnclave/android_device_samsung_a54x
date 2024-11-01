#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):100663296:17c39584a042908a44141e433967bcdca91ad0f1; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):67108864:3aa74dc5da9031b819739f05d5c356fd540861e1 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):100663296:17c39584a042908a44141e433967bcdca91ad0f1 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi
