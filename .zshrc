# Package manager
eval "$(sheldon source)"

# Enable arrow keys for selecting a tab completion
zstyle ':completion:*' menu select

export SCCACHE_DIR="$HOME/.cache/sccache"

# Add sbin to path
export PATH="$PATH:/usr/sbin"

#autoload ~/source-installs/zsh-autoenv/autoenv.zsh

# Better wayland support
export GDK_BACKEND=wayland
export XDG_SESSION_TYPE=wayland SDL_VIDEODRIVER=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1

# Cross compilers
export PATH="$HOME/.cross-compilers/bin:$PATH"

# Local
export PATH="$PATH:$HOME/.local/bin"

# Aseprite
# Installed from AUR
#export PATH="$PATH:$HOME/source-installs/aseprite/build/bin"

# Make compliant applications use neovim
export EDITOR="nvim"
export SYSTEMD_EDITOR="$EDITOR"
export BROWSER="firefox-developer-edition"

alias cat="bat"
#alias l="ls -la --color=auto"

# Bare git repo for dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Ctrl+arrow
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey -s '^o' 'nvim $(fzf)\n'
bindkey -s '^f' 'cd "$({fd --type d | fzf} || pwd)"\n'

# Node version management
eval "$(fnm env --use-on-cd --corepack-enabled)"

# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day. 
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;
