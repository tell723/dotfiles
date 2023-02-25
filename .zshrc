function exportPath() {
	export PATH=$1:$PATH
}

export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
exportPath ~/sh
export DEVELOPER_DIR="/Applications/Xcode13.2.1.app/Contents/Developer"


function bmd() {
	if [[ "${1}" ]]; then
		if [[ -d "${1}" ]]; then
			echo "${1}" >> ~/.bmd
		else
			echo "could not find directroy: ${1}" >&2
			return 1
		fi
	else
		echo "`pwd`" >> ~/.bmd
	fi
}

function show() {
	stdin=`cat`
	echo $stdin
	echo $stdin > ~/.tmpout
	open ~/.tmpout
}

function decodeurl() {
	echo $1 | nkf -w --url-input
}

source ~/.prjrc


alias change_profile='(){echo -e "\033]1337;SetProfile=$1\a"}'
alias cppwd=`pwd | pbcopy`
alias pg='pwgen -yB 10 10 | grep -v "[?|,\<\>#]" | awk "NR==1" | xargs echo'
alias cppg='pg | pbcopy'
alias ctags="`brew --prefix`/bin/ctags"
alias ls="ls --color=auto"

function cpppcom() {
	pass=`pg`
	echo $1' '$pass
	echo 'pp auth username '$1' '$pass | pbcopy
}



#alias git
alias pushnb="git push --set-upstream origin \`git branch --show-current\`"
alias git="git fetch 2> /dev/null &; git"



### fuzzy finder 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# alias fuzzy
alias fzswitch="git branch | fzf | xargs git switch"
alias fzcheckoutid="git log --oneline | fzf | cut -d \" \" -f1 | xargs git checkout"
alias fzcheckouttag="git tag | fzf | cut -d \" \" -f1 | xargs git checkout"
alias fzshowid="git log --oneline | fzf | cut -d \" \" -f1 | xargs git show"
alias fzmerge="git branch | fzf | xargs git merge"
alias fzapply="git stash apply $(git stash list | fzf | cut -d : -f1)"
alias fzadd="git diff --name-only | fzf | xargs git add -p "
alias fzlog="fzf | xargs git log"
alias fzcd='cd `cat ~/.bmd | fzf`'



### cpu architecture

if [ "$(uname -m)" = "arm64" ]; then
  # arm64
  change_profile ARM
else
  # x86_64
  change_profile Intel
fi



### powerline

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ] && [ "$(uname -m)" = "arm64" ]; then
    install_powerline_precmd
fi



#pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
export PATH="$HOMEBREW_PREFIX/bin:"$PATH
