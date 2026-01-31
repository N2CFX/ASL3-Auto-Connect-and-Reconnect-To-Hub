#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing ASL3 AutoLink..."

sudo install -m 0755 "$DIR/asl3-autolink.sh" /usr/local/sbin/asl3-autolink.sh
sudo install -m 0644 "$DIR/asl3-autolink.service" /etc/systemd/system/asl3-autolink.service

if [[ ! -f /etc/asl3-autolink.conf ]]; then
  sudo install -m 0644 "$DIR/asl3-autolink.conf.example" /etc/asl3-autolink.conf
  echo "Edit /etc/asl3-autolink.conf before use."
fi

sudo systemctl daemon-reload
sudo systemctl enable --now asl3-autolink.service

echo "Done."
