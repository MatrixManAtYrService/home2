#bindkey -e # masochistically learning emacs

bindkey -v  # old habits
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd E edit-command-line


# hist stuff
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory
setopt appendhistory

# pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-history-substring-search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd '^[[5~' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd '^[[6~' history-substring-search-down

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey -M viins '^[[2~' autosuggest-execute # insert key
bindkey -M viins '^[w' vi-forward-word
bindkey -M viins '^[e' vi-forward-blank-word
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
	end-of-line
	vi-end-of-line
	vi-add-eol
)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
	forward-char
	vi-forward-char
	forward-word
	emacs-forward-word
	vi-forward-word
	vi-forward-word-end
	vi-forward-blank-word
	vi-forward-blank-word-end
	vi-find-next-char
	vi-find-next-char-skip
	)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60' # solarized dark
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180' # solarized light


# allow multiline commands that start with comments (for easier history searching)
set -k

# https://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
vi-search-fix() {
zle vi-cmd-mode
zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix
bindkey "^?" backward-delete-char


# https://superuser.com/questions/516474/escape-not-idempotent-in-zshs-vi-emulation
noop () { }
zle -N noop
bindkey -M vicmd '\e' noop

# fzf
# (warning: deb-specific)
type fzf &> /dev/null
[ $? -eq 0 ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# use I beam for insert mode
# https://unix.stackexchange.com/q/433273
function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
 [[ $1 = 'block' ]]; then
echo -ne '\e[1 q'

elif [[ ${KEYMAP} == main ]] ||
   [[ ${KEYMAP} == viins ]] ||
   [[ ${KEYMAP} = '' ]] ||
   [[ $1 = 'beam' ]]; then
echo -ne '\e[5 q'
fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
echo -ne '\e[5 q'
}
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# wd
fpath+="~/.zsh/wd"
autoload -Uz wd



# custom functions
fpath+=${ZDOTDIR:-~}/.zsh_functions
autoload -Uz today todaydir bitch vscode
zle -N accept-line bitch

# apply non-git-synced modifications
touch "${HOME}/.zshrc2"
source "${HOME}/.zshrc2"
