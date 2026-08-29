#!/usr/bin/env bash
set -euo pipefail
SETTINGS_FILE="${HOME}/.idleman"
# Defaults used both as fallback values and to populate a fresh
# settings file if one doesn't exist yet.
DEFAULT_POWEROFF=290
DEFAULT_LOCK=300
DEFAULT_SUSPEND=600

echo "Using settings file: $SETTINGS_FILE"

if [ ! -f "$SETTINGS_FILE" ]; then
  echo "$SETTINGS_FILE not found. Creating a new one..."
  cat >"$SETTINGS_FILE" <<EOF
# Idle timings in seconds. Set a value to 0 or negative to disable
# that stage entirely.
POWEROFF=${DEFAULT_POWEROFF}
LOCK=${DEFAULT_LOCK}
SUSPEND=${DEFAULT_SUSPEND}
EOF
  echo "$SETTINGS_FILE created successfully!"
fi

echo "Loading settings from $SETTINGS_FILE..."
# shellcheck disable=SC1090
source "$SETTINGS_FILE"
POWEROFF="${POWEROFF:-$DEFAULT_POWEROFF}"
LOCK="${LOCK:-$DEFAULT_LOCK}"
SUSPEND="${SUSPEND:-$DEFAULT_SUSPEND}"
echo "Settings loaded: POWEROFF=${POWEROFF}s, LOCK=${LOCK}s, SUSPEND=${SUSPEND}s"

args=(-w)

# --- poweroff monitors ---
if [ "$POWEROFF" -gt 0 ]; then
  echo "Poweroff stage enabled: monitors will power off after ${POWEROFF}s of idle."
  args+=(timeout "$POWEROFF" 'niri msg action power-off-monitors')
  args+=(resume 'niri msg action power-on-monitors')
else
  echo "Poweroff stage disabled (POWEROFF=${POWEROFF})."
fi

# --- lock screen ---
if [ "$LOCK" -gt 0 ]; then
  echo "Lock stage enabled: screen will lock after ${LOCK}s of idle."
  args+=(timeout "$LOCK" swaylock)
else
  echo "Lock stage disabled (LOCK=${LOCK})."
fi

# --- suspend ---
if [ "$SUSPEND" -gt 0 ]; then
  echo "Suspend stage enabled: system will suspend-then-hibernate after ${SUSPEND}s of idle."
  args+=(timeout "$SUSPEND" 'systemctl suspend-then-hibernate')
  args+=(before-sleep swaylock)
else
  echo "Suspend stage disabled (SUSPEND=${SUSPEND})."
fi

echo "Starting swayidle with configured stages..."
echo "swayidle ${args[@]}"
exec swayidle "${args[@]}"
