# Update prompt swap function
function ps1 {
    red="\[\e[31m\]"
    green="\[\e[32m\]"
    blue="\[\e[34m\]"
    end="\[\e[0m\]"
    bold="\[\e[1m\]"

    # Set PROMPT_IND on default
    if [[ "$1" != "" ]]; then
        PROMPT_IND=$(("$1" - 1))
    elif [[ "${PROMPT_IND}" == "" ]]; then
        PROMPT_IND=-1
    fi

    # Hardcoded list of prompts
    prompts=(
        "[\u@\h \W]\$ " # default
        "${bold}${green}\$${end} " # simple
        "${bold}${blue}\W ${green}\$${end} " # dirname
        "$bold$blue\W \$(if [[ \"\$(git rev-parse --is-inside-work-tree 2>/dev/null)\" == \"true\" ]]; then echo \"$red\$(basename \$(git rev-parse --show-toplevel))<\$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)> \"; fi)$green\$$end " # git prompt
    )

    # Cycle through prompts
    PROMPT_IND=$(( (${PROMPT_IND}+1) % ${#prompts[@]} ))

    # Set PS1
    PS1="${prompts[$((${PROMPT_IND}))]}"

    # Only print if it wasn't given as a parameter.
    if [[ "$1" == "" ]]; then
        echo PROMPT_IND="${PROMPT_IND}" PS1=\""${PS1}"\"
    fi
}

# Set default prompt.
ps1 3

export TERM="xterm-256color"

# Emacs aliases
export EDITOR="emacsclient -nw"
alias ed="pkill emacs; emacs --daemon" # ed = emacs daemon
alias ec="${EDITOR}"                   # ec = emacs client

# Turn off flow control
stty -ixon
