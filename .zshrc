setopt appendhistory nomatch notify
setopt HIST_IGNORE_DUPS
unsetopt autocd beep extendedglob

autoload -U colors && colors

# Vim key bindings
bindkey -v

# Allow e.g. ../ for tab completion
zstyle ':completion:*' special-dirs true

autoload -Uz compinit
compinit

CASE_SENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

# History options
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=500000

. ~/.shellrc

# History search
[[ -n "\e[5~" ]] && bindkey "\e[5~" history-beginning-search-backward
[[ -n "\e[6~" ]] && bindkey "\e[6~" history-beginning-search-forward
[[ -n "\eOH" ]] && bindkey "\eOH" beginning-of-line
[[ -n "\eOF" ]] && bindkey "\eOF" end-of-line

# Dirstack (use dirs -v)
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  #[[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
# Remove duplicate entries
setopt pushdignoredups
# This reverts the +/- operators.
setopt pushdminus

# Fish-like syntax highlighting
. ~/pkg/install/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set PS1 according to server you are working on
if [ $UID -eq 0 ]; then
    # root
    colorUser="$fg[red]"
else
    # normal user
    colorUser="$fg[green]"
fi
colorPath="$fg[cyan]"
case "$HOST" in
    basil) colorServer="$fg_bold[red]";;
    *triumf*) colorServer="$fg[yellow]";;
    lxplus*) colorServer="$fg_bold[yellow]";;
    cmslpc*) colorServer="$fg[yellow]";;
    *) colorServer="$fg[magenta]";;
esac

# Personal theme
# Colors are black, red, green, yellow, blue, magenta, cyan, white
#PS1="%F{$colorUser}%n%{$reset_color%}@%F{$colorServer}%m %{$reset_color%}: %F{$colorPath}%~%{$reset_color%} $ "
PROMPT="%{$colorUser%}%n%{$reset_color%}@%{$colorServer%}%m%{$reset_color%}: %{$colorPath%}%(5~|%-1~/.../%3~|%4~)%{$reset_color%} $ "
RPROMPT="%(?..%{$fg[red]%}%? %{$reset_color%})"

# Get colored man pages
if [[ "$OSTYPE" = solaris* ]]
then
	if [[ ! -x "$HOME/bin/nroff" ]]
	then
		mkdir -p "$HOME/bin"
		cat > "$HOME/bin/nroff" <<EOF
#!/bin/sh
if [ -n "\$_NROFF_U" -a "\$1,\$2,\$3" = "-u0,-Tlp,-man" ]; then
	shift
	exec /usr/bin/nroff -u\$_NROFF_U "\$@"
fi
#-- Some other invocation of nroff
exec /usr/bin/nroff "\$@"
EOF
		chmod +x "$HOME/bin/nroff"
	fi
fi

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		PAGER="${commands[less]:-$PAGER}" \
		_NROFF_U=1 \
		PATH="$HOME/bin:$PATH" \
			man "$@"
}
