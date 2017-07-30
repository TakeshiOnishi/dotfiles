#FROM: http://www.sirochro.com/note/terminal-zsh-prompt-customize/

# VCS$B$N>pJs$r<hF@$9$k(Bzsh$B4X?t(B
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

# PROMPT$BJQ?tFb$GJQ?t;2>H(B
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats $B@_Dj9`L\$G(B %c,%u $B$,;HMQ2D(B
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit $B$5$l$F$$$J$$%U%!%$%k$,$"$k(B
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add $B$5$l$F$$$J$$%U%!%$%k$,$"$k(B
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #$BDL>o(B
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase $BESCf(B,merge $B%3%s%U%j%/%HEy(B formats $B30$NI=<((B

# %b $B%V%i%s%A>pJs(B
# %a $B%"%/%7%g%sL>(B(merge$B$J$I(B)
# %c changes
# %u uncommit

# $B%W%m%s%W%HI=<(D>A0$K(B vcs_info $B8F$S=P$7(B
precmd () { vcs_info }

# $B%W%m%s%W%H!J:8!K(B
PROMPT='%{$fg[red]%}[%n@%m]%{$reset_color%}'
PROMPT=$PROMPT'${vcs_info_msg_0_} %{${fg[red]}%}%}$%{${reset_color}%} '

# $B%W%m%s%W%H!J1&!K(B
RPROMPT='%{${fg[red]}%}[%~]%{${reset_color}%}'
