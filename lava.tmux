#!/usr/bin/env bash
# TPM entry point: `set -g @plugin 'pompeitech/pompeitech'`
# Pick the variant with `set -g @lava_style 'light'` (default: dark).
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
style="$(tmux show-option -gqv @lava_style)"
tmux source-file "$CURRENT_DIR/extras/tmux/lava-${style:-dark}.tmux"

# tmux-floax copies its colors into the environment when it loads, so refresh
# them in case it was loaded before us.
tmux setenv -g FLOAX_BORDER_COLOR "$(tmux show-option -gqv @floax-border-color)"
tmux setenv -g FLOAX_TEXT_COLOR "$(tmux show-option -gqv @floax-text-color)"

# fzf-based plugins (tmux-fzf, tmux-fzf-url…) run with the server environment,
# not your shell's, so hand them the Lava fzf colors too.
FZF_DEFAULT_OPTS="$(tmux show-environment -g FZF_DEFAULT_OPTS 2>/dev/null | sed -n 's/^FZF_DEFAULT_OPTS=//p')"
. "$CURRENT_DIR/extras/fzf/lava-${style:-dark}.sh"
tmux set-environment -g FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS"
