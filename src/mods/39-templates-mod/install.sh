set -e                  # exit on error
set -o pipefail         # exit on pipeline error
set -u                  # treat unset variable as error

print_ok "Declare Templates dir name as variable for specific languages..."
case $LANG_MODE in
    "ro_RO")
        export TEMPLATE_DIR="Șabloane"
        ;;
    *)
        export TEMPLATE_DIR="Templates"
        ;;
esac

print_ok "Configuring templates..."
mkdir -p /etc/skel/$TEMPLATE_DIR
touch /etc/skel/$TEMPLATE_DIR/Text.txt
touch /etc/skel/$TEMPLATE_DIR/Markdown.md
cat << 'EOF' > /etc/skel/$TEMPLATE_DIR/Markdown.md
# Title

- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

## Subtitle

1. Numbered 1
2. Numbered 2
3. Numbered 3
EOF
judge "Configure templates"