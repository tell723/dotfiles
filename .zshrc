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


alias change_profile='(){echo -e "\033]1337;SetProfile=$1\a"}'
alias cd_gdoshop='cd ~/Documents/GDO/shopp_app/'
alias cd_smooth='cd ~/Documents/smooth_meeting/'
alias cppwd=`pwd | pbcopy`
alias pg='pwgen -yB 10 10 | grep -v "[?|,\<\>#]" | awk "NR==1" | xargs echo'
alias cppg='pg | pbcopy'

function cpppcom() {
	pass=`pg`
	echo $1' '$pass
	echo 'pp auth username '$1' '$pass | pbcopy
}

# alias fuzzy
alias fzswitch="git branch | fzf | xargs git switch"
alias fzupmodule="ls /Users/t-watanabe/Documents/GDO/shop_app/module/ios/exports/stg | fzf | xargs upmodule.sh"
alias fzcheckoutid="git log --oneline | fzf | cut -d \" \" -f1 | xargs git checkout"
alias fzcheckouttag="git tag | fzf | cut -d \" \" -f1 | xargs git checkout"
alias fzshowid="git log --oneline | fzf | cut -d \" \" -f1 | xargs git show"
alias fzmerge="git branch | fzf | xargs git merge"
alias fzlog="fzf | xargs git log"
alias fzcd='cd `cat ~/.bmd | fzf`'
alias fzvim='vim `ls -a | fzf`'
if [ "$(uname -m)" = "arm64" ]; then
  # arm64
  change_profile ARM
else
  # x86_64
  change_profile Intel
fi

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
