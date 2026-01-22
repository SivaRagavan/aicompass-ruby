#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="aicompass-ruby"
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYSTEMD_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
SERVICE_PATH="${SYSTEMD_DIR}/${SERVICE_NAME}.service"

mkdir -p "${SYSTEMD_DIR}"

cat > "${SERVICE_PATH}" <<EOF
[Unit]
Description=AI Compass Rails Service
After=network.target

[Service]
Type=simple
WorkingDirectory=${APP_DIR}
Environment=RAILS_ENV=development
Environment=PORT=8004
Environment=BIND_ADDRESS=0.0.0.0
ExecStart=/bin/bash -lc "bundle exec rails server -e \"\$RAILS_ENV\" -b \"\$BIND_ADDRESS\" -p \"\$PORT\""
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable "${SERVICE_NAME}.service"
