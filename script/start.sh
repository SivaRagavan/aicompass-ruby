#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="aicompass-ruby"

systemctl --user start "${SERVICE_NAME}.service"
systemctl --user status "${SERVICE_NAME}.service" --no-pager
