#!/usr/bin/env bash
# Idempotent installer: symlink home/ into $HOME, wire up hooks and launchd,
# seed machine-local files. Safe to re-run at any time.
#
#   ./install.sh          install / repair
#   ./install.sh --dry    show what would change, touch nothing

set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY=0
[ "${1:-}" = "--dry" ] && DRY=1

say()  { printf '  %s\n' "$*"; }
run()  { [ "$DRY" = 1 ] && { say "would: $*"; return 0; }; "$@"; }

echo ""
echo "dotfiles installer${DRY:+ (dry run)}"
echo "  repo: $REPO"
echo ""

# ---------------------------------------------------------------- symlinks
echo "symlinks:"
cd "$REPO/home" || exit 1
LINKED=0 SKIPPED=0 BACKED=0
while IFS= read -r f; do
    src="$REPO/home/$f"
    dest="$HOME/$f"

    # Already pointing at us -- nothing to do.
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    [ "$DRY" = 0 ] && mkdir -p "$(dirname "$dest")"

    # A real file (or a link pointing elsewhere) is moved aside, never deleted.
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        bak="$dest.bak.$(date +%s)"
        say "backup $f -> $(basename "$bak")"
        run mv "$dest" "$bak"
        BACKED=$((BACKED + 1))
    fi

    say "link   $f"
    run ln -s "$src" "$dest"
    LINKED=$((LINKED + 1))
done < <(find . -type f ! -name .DS_Store | sed 's|^\./||')
cd "$REPO" || exit 1
say "linked $LINKED, already-correct $SKIPPED, backed up $BACKED"

# ------------------------------------------------------------------- hooks
echo ""
echo "git hooks:"
if [ "$(git -C "$REPO" config --get core.hooksPath 2>/dev/null)" = "hooks" ]; then
    say "core.hooksPath already set"
else
    run git -C "$REPO" config core.hooksPath hooks
    say "core.hooksPath -> hooks"
fi
run chmod +x "$REPO/hooks/pre-commit" "$REPO/bin/"*.sh
command -v gitleaks >/dev/null 2>&1 ||
    say "WARNING: gitleaks not installed -- run: brew install gitleaks"

# ------------------------------------------------------- machine-local files
echo ""
echo "machine-local files:"
# Machine-local files are never templated from this repo -- a template of what
# to hide is itself a disclosure. They are simply reported as absent.
for f in .zshrc.zalando .zshrc.local; do
    if [ -e "$HOME/$f" ]; then
        run chmod 600 "$HOME/$f"
        say "$f present"
    else
        say "$f absent -- work-specific commands will be unavailable until created"
    fi
done
[ -e "$HOME/.all_secret_keys" ] && { run chmod 600 "$HOME/.all_secret_keys"; say ".all_secret_keys -> 600"; }

# ----------------------------------------------------------------- launchd
echo ""
echo "launchd auto-commit:"
PLIST="com.asaucedo.dotfiles.autocommit.plist"
TARGET="$HOME/Library/LaunchAgents/$PLIST"
run mkdir -p "$HOME/Library/LaunchAgents"
if [ -L "$TARGET" ] || [ -e "$TARGET" ]; then
    run launchctl unload "$TARGET" 2>/dev/null
    run rm -f "$TARGET"
fi
run ln -s "$REPO/launchd/$PLIST" "$TARGET"
run launchctl load "$TARGET"
say "loaded (watching home/, commit-only -- no auto-push)"

echo ""
echo "done. open a new shell to pick up changes."
echo ""
