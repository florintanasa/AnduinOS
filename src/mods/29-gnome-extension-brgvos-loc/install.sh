set -e                  # exit on error
set -o pipefail         # exit on pipeline error
set -u                  # treat unset variable as error

print_ok "Install Gnome Extension BRGV-OS Location Switcher"
cp ./loc@brgvos.com /usr/share/gnome-shell/extensions/loc@brgvos.com -rf
judge "Install Gnome Extension BRGV-OS Location Switcher"