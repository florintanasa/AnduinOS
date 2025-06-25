set -e                  # exit on error
set -o pipefail         # exit on pipeline error
set -u                  # treat unset variable as error

print_ok "Patch plymouth"
# hold thme spinner to be upgraded
sudo apt-mark hold plymouth-theme-spinner
# replece original spinner logo and text with our
cp ./logo_BRGVOS_blue_128.png      /usr/share/plymouth/themes/spinner/bgrt-fallback.png
cp ./BRGV-OS_text.png /usr/share/plymouth/ubuntu-logo.png
cp ./BRGV-OS_text.png /usr/share/plymouth/themes/spinner/watermark.png
#update-initramfs -u # We don't have to update initramfs here, because we did it in the end of this script
judge "Patch plymouth and update initramfs"
