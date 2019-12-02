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

export PS1="\[\e[37m\]\W\[\e[m\]\[\e[32m\]\`parse_git_branch\`\[\e[m\]\[\e[92m\] →\[\e[m\] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash