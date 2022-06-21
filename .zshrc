export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export DEVELOPER_DIR="/Applications/Xcode12.app/Contents/Developer"

alias change_profile='(){echo -e "\033]1337;SetProfile=$1\a"}'
alias cd_gdoshop='cd ~/Documents/GDO/shopp_app/'
alias cd_smooth='cd ~/Documents/smooth_meeting/'

# alias fuzzy
alias fzswitch="git branch | fzf | xargs git switch"
alias fzupmodule="ls /Users/t-watanabe/Documents/GDO/module/stg | fzf | xargs upmodule.sh"
alias fzcheckoutid="git log --oneline | fzf | cut -d \" \" -f1 | xargs git checkout"
alias fzcheckouttag="git tag | fzf | cut -d \" \" -f1 | xargs git checkout"
alias fzshowid="git log --oneline | fzf | cut -d \" \" -f1 | xargs git show"
alias fzmerge="git branch | fzf | xargs git merge"
alias fzlog="fzf | xargs git log"

source $HOME/Documents/shell/zsh/gdo.sh

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

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
