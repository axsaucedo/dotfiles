#!/usr/bin/env bash
# Email on dotfiles automation failure, via Mail.app + osascript.
#
# Bash port of EmailManager.send_email in
# ~/Programming/lib/workflows-etl/recurrent-emails/main.py, using the same
# Mail.app route so it depends on no SMTP credentials.
#
# Usage: notify-fail.sh "<subject>" "<body>"
#
# Rate limited to one email per RATE_LIMIT_MIN, because the launchd watch can
# fire repeatedly: a persistent failure (a secret left staged, say) would
# otherwise mail on every save. Failures are always logged even when the email
# is suppressed.

set -uo pipefail

SUBJECT="${1:-dotfiles: automation failure}"
BODY="${2:-(no detail provided)}"

# Address of an account configured in Mail.app. Deliberately not defaulted to a
# real address: this repo is public. Set DOTFILES_NOTIFY_SENDER in a
# machine-local file (e.g. ~/.zshrc.zalando) or ~/.config/dotfiles/notify.env.
[ -r "$HOME/.config/dotfiles/notify.env" ] && . "$HOME/.config/dotfiles/notify.env"
SENDER="${DOTFILES_NOTIFY_SENDER:-}"
RECIPIENT="${DOTFILES_NOTIFY_RECIPIENT:-$SENDER}"

if [ -z "$SENDER" ]; then
    # No address configured -- fall back to a desktop notification rather than
    # failing silently, and say how to enable email.
    mkdir -p "$(dirname "$0")/../tmp"
    echo "$(date '+%Y-%m-%d %H:%M:%S') no DOTFILES_NOTIFY_SENDER set; desktop notification only" \
        >> "$(cd "$(dirname "$0")/.." && pwd)/tmp/notify.log"
    /usr/bin/osascript -e "display notification \"${2:-failure}\" with title \"${1:-dotfiles}\"" 2>/dev/null
    exit 0
fi

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG="$REPO/tmp/notify.log"
STAMP="$REPO/tmp/.notify-stamp"
RATE_LIMIT_MIN="${DOTFILES_NOTIFY_RATE_MIN:-60}"

mkdir -p "$REPO/tmp"
echo "$(date '+%Y-%m-%d %H:%M:%S') $SUBJECT :: $BODY" >> "$LOG"

# Rate limit: suppress if we mailed within the window.
if [ -f "$STAMP" ] && [ -z "$(find "$STAMP" -maxdepth 0 -mmin +"$RATE_LIMIT_MIN" 2>/dev/null)" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') (email suppressed: rate limit)" >> "$LOG"
    exit 0
fi

# AppleScript string literals: escape backslashes then double quotes, and flatten
# newlines, so a multi-line git error cannot break out of the quoted string.
escape() { printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' | tr '\n' ' '; }
SUBJECT_ESC=$(escape "$SUBJECT")
BODY_ESC=$(escape "$BODY

--
host: $(hostname -s)
repo: $REPO
time: $(date '+%Y-%m-%d %H:%M:%S')")

# visible:false -- this runs from launchd in the background; the ETL scripts use
# visible:true, which pops a compose window and is wrong for an unattended job.
if /usr/bin/osascript <<EOF >>"$LOG" 2>&1
tell application "Mail"
    set newMessage to make new outgoing message with properties {visible:false, subject:"$SUBJECT_ESC", sender:"$SENDER", content:"$BODY_ESC"}
    tell newMessage
        make new to recipient with properties {address:"$RECIPIENT"}
        send
    end tell
end tell
EOF
then
    touch "$STAMP"
    echo "$(date '+%Y-%m-%d %H:%M:%S') (email sent to $RECIPIENT)" >> "$LOG"
else
    # Mail.app may be closed or unauthorised. Fall back to a desktop notification
    # so the failure is never silent.
    echo "$(date '+%Y-%m-%d %H:%M:%S') (email FAILED; falling back to notification)" >> "$LOG"
    /usr/bin/osascript -e "display notification \"$BODY_ESC\" with title \"$SUBJECT_ESC\"" 2>/dev/null
fi
