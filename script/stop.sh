#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="aicompass-ruby"

systemctl --user stop "${SERVICE_NAME}.service"
