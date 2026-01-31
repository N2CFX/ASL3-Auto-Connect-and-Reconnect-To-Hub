#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing ASL3 AutoLink..."

sudo install -m 0755 "${REPO_DIR}/asl3-autolink.sh" /usr/local/sbin/asl3-autolink.sh
sudo install -m 0644 "${REPO_DIR}/asl3-autolink.service" /etc/systemd/system/asl3-autolink.service

if [[ ! -f /etc/asl3-autolink.conf ]]; then
  echo "No /etc/asl3-autolink.conf found. Installing example config..."
  sudo install -m 0644 "${REPO_DIR}/asl3-autolink.conf.example" /etc/asl3-autolink.conf
  echo
  echo "IMPORTANT: Edit /etc/asl3-autolink.conf and set LOCAL_NODE and TARGET_NODE."
fi

sudo systemctl daemon-reload
sudo systemctl enable --now asl3-autolink.service

echo
echo "Installed. Check status with:"
echo "  sudo systemctl status asl3-autolink.service --no-pager"
echo "View logs with:"
echo "  sudo journalctl -u asl3-autolink.service -f"
