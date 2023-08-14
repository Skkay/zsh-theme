# skkay.zsh-theme
#
# Based on and inspired from af-magic (Andy Fleming), Pure (Sindre Sorhus)

# dashed separator size
function dashes_len {
    echo $COLUMNS - $(whoami | wc -c) - $(hostname | wc -c) - 13 
}

function generate_prompt {    
    # empty line
    PS1=$'\n' 

    # username and hostname, current time, dashed separator
    PS1+="${FG[005]}[$(whoami)@$(hostname)]%{$reset_color%} [%D{%H:%M:%S}] ${FG[250]}\${(l.\$(dashes_len)..-.)}%{$reset_color%}"

    # directory, git info, return code
    PS1+="${FG[032]}%~\$(git_prompt_info) %{$reset_color%} %(?..%{$fg[red]%}%? ↵%{$reset_color%})"

    # empty line (to prepare the venv name and/or prompt symbol)
    PS1+=$'\n'

    # venv name if exists
    if [ -n "$VIRTUAL_ENV" ]; then
        PS1+="(`basename $VIRTUAL_ENV`) "
    fi

    # prompt symbol
    PS1+="${FG[005]}%(!.#.❯) %{$reset_color%}"

    # multiline prompt
    PS2="%{$fg[red]%}\ %{$reset_color%}"
}

# generate_prompt

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[075]}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"

add-zsh-hook precmd generate_prompt
