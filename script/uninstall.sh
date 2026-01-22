#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="aicompass-ruby"
SYSTEMD_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
SERVICE_PATH="${SYSTEMD_DIR}/${SERVICE_NAME}.service"

if systemctl --user list-unit-files | grep -q "^${SERVICE_NAME}\.service"; then
  systemctl --user stop "${SERVICE_NAME}.service" || true
  systemctl --user disable "${SERVICE_NAME}.service" || true
fi

rm -f "${SERVICE_PATH}"
systemctl --user daemon-reload
