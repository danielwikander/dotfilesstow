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
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " - ${BRANCH}${STAT}"
	else
		echo ""
	fi
}

# get current status of git repo. return "!" if dirty
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${dirty}" == "0" ]; then
		echo "!"
	else
		echo ""
	fi
}

# Set prompt
export PS1="\[\e[37m\]\W\[\e[m\]\[\e[92m\]\`parse_git_branch\`\[\e[m\]\[\e[91m\] →\[\e[m\] "

# Add scripts to path
export PATH="$HOME/.config/scripts:$PATH"

# Set default editor
export VISUAL='nvim'
export EDITOR='nvim' 

# Set fzf settings
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --ignore-case -g "!{node_modules,.git}"'
export FZF_DEFAULT_OPTS='-i' 
#export FZF_CTRL_T_OPTS='-i --height 90% --reverse --preview "head -85 {}"'
export FZF_CTRL_T_OPTS="-i --height 80% --reverse --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -100'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
