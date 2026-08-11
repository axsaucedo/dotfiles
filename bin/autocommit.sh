#!/usr/bin/env bash
# Commit changes under home/ automatically, triggered by launchd WatchPaths.
#
# Deliberately does NOT push. This repo is public, so an auto-push would publish
# a bad paste within seconds with no chance to catch it. The pre-commit hook is
# a strong guard but not a perfect one, so pushing stays a deliberate act
# (`dots push`, or the daily nudge). Set DOTFILES_AUTOPUSH=1 to opt in.
#
# Install: ../install.sh loads com.asaucedo.dotfiles.autocommit.plist
# Logs:    tmp/autocommit.log

set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCK="/tmp/dots-autocommit.lock"
LOG="$REPO/tmp/autocommit.log"
DEBOUNCE="${DOTFILES_DEBOUNCE:-30}"

mkdir -p "$REPO/tmp"
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >> "$LOG"; }

# Atomic lock via mkdir — no flock on macOS by default. Stale locks older than
# 10 minutes are cleared so a killed run cannot wedge this permanently (the same
# failure mode that made pyenv hang every shell for 60s).
if ! mkdir "$LOCK" 2>/dev/null; then
    if [ -n "$(find "$LOCK" -maxdepth 0 -mmin +10 2>/dev/null)" ]; then
        log "clearing stale lock"
        rmdir "$LOCK" 2>/dev/null
        mkdir "$LOCK" 2>/dev/null || exit 0
    else
        exit 0   # another run in flight; its debounce will cover these edits
    fi
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

cd "$REPO" || exit 1

# Editors write via temp file + rename, so a single save can fire the watch
# several times. Wait for the dust to settle before looking at the tree.
sleep "$DEBOUNCE"

git add -A home/ 2>>"$LOG"

if git diff --cached --quiet -- home/; then
    exit 0   # nothing to do; stay silent
fi

FILES=$(git diff --cached --name-only -- home/ | sed 's|^home/||' | tr '\n' ' ')

# Commit home/ ONLY. Without the pathspec this would sweep in anything else
# already staged -- a manual commit in progress elsewhere in the repo would be
# silently absorbed into an "auto:" commit.
if ! OUT=$(git commit -m "auto: ${FILES% }" -- home/ 2>&1); then
    # The pre-commit hook rejecting a secret lands here. That is the single most
    # important thing to be told about, since the edit is sitting staged.
    log "COMMIT FAILED: $OUT"
    git reset -q
    [ -x "$REPO/bin/notify-fail.sh" ] &&
        "$REPO/bin/notify-fail.sh" "dotfiles: auto-commit blocked" "$OUT"
    exit 1
fi

log "committed: ${FILES% }"

if [ "${DOTFILES_AUTOPUSH:-0}" = "1" ]; then
    if ! OUT=$(git push -q origin HEAD 2>&1); then
        log "PUSH FAILED: $OUT"
        [ -x "$REPO/bin/notify-fail.sh" ] &&
            "$REPO/bin/notify-fail.sh" "dotfiles: auto-push failed" "$OUT"
        exit 1
    fi
    log "pushed"
fi
