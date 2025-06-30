set -e                  # exit on error
set -o pipefail         # exit on pipeline error
set -u                  # treat unset variable as error

print_ok "Install Gnome Extension BRGV-OS Switcher"
cp ./switcher@brgvos /usr/share/gnome-shell/extensions/switcher@brgvos -rf
judge "Install Gnome Extension BRGV-OS Switcher"