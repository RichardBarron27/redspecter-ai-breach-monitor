#!/usr/bin/env bash
#
# Red Specter - AI Breach Monitor
# Defensive-only tool – for monitoring logs/prompts for potential data leaks.
#
# Usage examples:
#   ./rs_ai_breach_monitor.sh /path/to/ai_logs.log
#   tail -F /path/to/ai_logs.log | ./rs_ai_breach_monitor.sh -
#
# Alerts are logged to: ~/.redspecter_ai_breach_monitor.log
#

set -u

# ===== CONFIGURATION =====

# Where to write detected incidents
ALERT_LOG="${HOME}/.redspecter_ai_breach_monitor.log"

# Optional: your org / project name (for pattern matching)
ORG_NAME="REDSPECTER"   # change this for client/org

# Suspicious patterns (simple but effective starting point)
SUSPICIOUS_PATTERNS=(
    "password"
    "passwd"
    "apikey"
    "api_key"
    "secret"
    "token"
    "bearer "
    "PRIVATE KEY"
    "BEGIN RSA PRIVATE KEY"
    "BEGIN OPENSSH PRIVATE KEY"
    "BEGIN EC PRIVATE KEY"
    "credit card"
    "card number"
    "cvv"
    "national insurance"
    "ninumber"
    "sort code"
    "iban"
    "ifsc"
    "ssn"
    "passport"
    "customer id"
    "$ORG_NAME"
)

# ===== FUNCTIONS =====

usage() {
    cat <<EOF
Red Specter - AI Breach Monitor

Usage:
  $0 /path/to/logfile
  tail -F /path/to/logfile | $0 -
  some_command_generating_logs | $0 -

If you pass "-", input is read from stdin (pipe).
EOF
}

init_log() {
    if [ ! -f "$ALERT_LOG" ]; then
        touch "$ALERT_LOG" 2>/dev/null || {
            echo "[!] Cannot create alert log at $ALERT_LOG" >&2
            exit 1
        }
    fi
}

log_alert() {
    local pattern="$1"
    local line="$2"
    local now
    now="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

    printf '[%s] PATTERN="%s" LINE="%s"\n' "$now" "$pattern" "$line" >> "$ALERT_LOG"
}

scan_line() {
    local line="$1"
    local p

    for p in "${SUSPICIOUS_PATTERNS[@]}"; do
        if printf '%s\n' "$line" | grep -qi -- "$p"; then
            echo
            echo "==== [AI BREACH MONITOR ALERT] ===="
            echo "Time: $(date +"%Y-%m-%d %H:%M:%S")"
            echo "Pattern: $p"
            echo "Line: $line"
            echo "==================================="
            log_alert "$p" "$line"
            break
        fi
    done
}

monitor_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        echo "[!] File not found: $file" >&2
        exit 1
    fi

    echo "[*] Monitoring file: $file"
    echo "[*] Alerts will be logged to: $ALERT_LOG"
    echo "[*] Press Ctrl+C to stop."
    echo

    tail -F "$file" 2>/dev/null | while IFS= read -r line; do
        scan_line "$line"
    done
}

monitor_stdin() {
    echo "[*] Monitoring STDIN stream"
    echo "[*] Alerts will be logged to: $ALERT_LOG"
    echo "[*] Press Ctrl+C to stop."
    echo

    while IFS= read -r line; do
        scan_line "$line"
    done
}

# ===== MAIN =====

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

TARGET="$1"

init_log

if [ "$TARGET" = "-" ]; then
    monitor_stdin
else
    monitor_file "$TARGET"
fi
