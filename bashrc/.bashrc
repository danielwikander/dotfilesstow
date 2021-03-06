#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

alias ls='ls --color=auto'

# get current branch in git repo
parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " - ${BRANCH}${STAT}"
	else
		echo ""
	fi
}

# get current status of git repo. return "*" if dirty
parse_git_dirty() {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${dirty}" == "0" ]; then
		echo "*"
	else
		echo ""
	fi
}

# nnn cd on quit
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# Set prompt
export PS1="\[\e[37m\]\W\[\e[m\]\[\e[92m\]\`parse_git_branch\`\[\e[m\]\[\e[91m\] →\[\e[m\] "

# Add scripts to path
export PATH="$HOME/.config/scripts:$PATH"

# Set default editor
export VISUAL='nvim'
export EDITOR='nvim' 

# Autocomplete ignore case
bind 'set completion-ignore-case on'

# Set fzf settings
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --ignore-case -g "!{node_modules,.git}"'
export FZF_DEFAULT_OPTS='-i' 
export FZF_CTRL_T_OPTS="-i --height 80% --reverse --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -100'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
