
---
title: Let use zsh
link: https://notes.harues.com/let-use-zsh
author: euikook
description: 
tags: [Linux, zsh, Shell]
---

# Let use zsh

## .zshrc
```zsh
ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"
plugins=(git virtualenv)


ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/nvm/init-nvm.sh

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    CONTEXT="%(!.%{%F{yellow}%}.)%n"
    if [[ -n "$SSH_CLIENT" ]]; then
      CONTEXT="${CONTEXT}@%m"
      #prompt_segment black default "%(!.%{%F{yellow}%}.)%n@%m"
    fi
    prompt_segment black default ${CONTEXT}
  fi
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
```