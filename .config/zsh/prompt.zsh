setopt PROMPT_SUBST

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true

# branch
zstyle ':vcs_info:git:*' formats '[%b]'

# dirty
zstyle ':vcs_info:git:*' stagedstr '*'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats '%u%m[%b]'

precmd() {
    vcs_info
}

PROMPT='${vcs_info_msg_0_}[%~]$ '
