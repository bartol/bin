#--- oh my zsh
# https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
# https://github.com/robbyrussell/oh-my-zsh#basic-installation

export ZSH="/Users/bartol/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh



#--- pure prompt
# https://github.com/sindresorhus/pure#install

autoload -U promptinit; promptinit

PURE_PROMPT_SYMBOL="➜"
zstyle ':prompt:pure:prompt:success' color green

# show hostname if ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PROMPT_PURE_SSH_CONNECTION=HH:MM
fi

prompt pure



#--- git
alias gs="git status"
alias ga="git add"
alias gp="git push"

alias gc="git checkout"
alias gb="git branch"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"

# pull request
# lost source url :(
gpr() {
  if [ $? -eq 0 ]; then
    github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
    branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
    pr_url=$github_url"/compare/master..."$branch_name
    open $pr_url;
  else
    echo 'failed to open a pull request.';
  fi
}



#--- yarn
# https://yarnpkg.com/lang/en/docs/install

alias ya="yarn add"
alias yr="yarn remove"

alias yd="yarn dev"
alias yb="yarn build"
alias yt="yarn test"



#--- z
# https://github.com/rupa/z

. $(brew --prefix)/etc/profile.d/z.sh



#--- exa (better ls)
# https://github.com/ogham/exa#installation
alias ls="exa -la --git --links"



#--- bat (better cat)
# https://github.com/sharkdp/bat#installation

alias cat="bat"



#--- ip
alias ip="curl http://ipecho.net/plain; echo"



#--- zip with password
alias zipwithpw="zip -er"












export VISUAL=nvim
export VIMCONFIG=~/.vim
export VIMDATA=~/.vim



if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

alias zshrc='code ~/.zshrc'
alias vimrc='code ~/.vimrc'
alias update="source ~/.zshrc"
alias runp="lsof -i "
alias h="history"
alias s="spotify pause"
alias sn="spotify next"
alias sp="spotify prev"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# golang
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

# fuck
eval $(thefuck --alias)

# transfer.sh
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/bartol/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/bartol/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/bartol/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/bartol/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/bartol/.config/yarn/global/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/bartol/.config/yarn/global/node_modules/tabtab/.completions/slss.zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

#export FZF_DEFAULT_COMMAND="rg --files --follow --hidden -g '!.git'"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"
# rg --files --hidden -g '!.git'


