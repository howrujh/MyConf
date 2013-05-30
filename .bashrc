# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
############### TERM ###########################################
export XTERM=xterm
#export LANG=ko_KR.UTF-8

################ SVN ##############################################

SVN_EDITOR="$HOME/local/bin/vim -X"
GIT_EDITOR="$HOME/local/bin/vim -X"
export SVN_EDITOR
export GIT_EDITOR
############### CTRL + S command off ###########################
stty ixany
stty ixoff -ixon
############## SSH DISPLAY #######################################
#export DISPLAY=$DISPLAY #:19.0 #screen X11, echo $DISPLAY than (screen->) export DISPLAY=:value



######### alias #############################################
alias grep='grep --color=always'
alias grepr='source ~/bin/grepr.sh'
alias g='source ~/bin/grepr.sh'
alias greprs='source ~/bin/greprs.sh'

alias less='less -R'

alias c='clear'
alias l='ls'
alias p='pwd'
alias sr='screen -S jh_session -X setenv DISPLAY "$DISPLAY"; screen -S jh_session -rd'

alias ta='source ~/bin/tmux_get_display.sh; ~/local/bin/tmux attach-session -t  orz_jh || ~/local/bin/tmux new-session -s orz_jh'
#alias ta='source ~/bin/tmux_get_display.sh; /usr/bin/tmux attach-session -t  orz_jh || /usr/bin/tmux new-session -s orz_jh'
alias td='source ~/bin/tmux_set_display.sh'

alias sb='source ~/.bashrc'

alias home='cd ~/'
alias '~'='cd ~/'


alias e='~/local/bin/emacs -nw'
alias em='~/local/bin/emacs -nw'
alias emacs='~/local/bin/emacs -nw'
alias t1='cd ~/tp1k'
alias t1.b='cd ~/tp1k/bios/u-boot'
alias t1.k='cd ~/tp1k/kernel'
alias t1.a='cd ~/tp1k/app.xm3k'
alias vim='vim -X'
alias vi='vim'
#alias vim='source ~/bin/vim_include_selector.sh; vim'
alias vir='vim -R'
#alias mkcscope='rm -rf cscope.files cscope.out; find $PWD \( -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.h' -o -name '*.hh' -o -name '*.s' -o -name '*.S' \) -print > cscope.files; cscope -i cscope.files'

alias mkcscope='source ~/bin/cscope_maker.sh'

########  cscope ##################################################################

#CSCOPE_DB=/home/jinhwan/work/tp1k/cscope.out #define cscope.out location
#CSCOPE_DB=$CSCOPE_DB

#export CSCOPE_DB



############ PATH EXPORT ###########################################################

#export PATH=$PATH:$HOME/local/bin



. ~/abr/bin/abr_bashrc
. ~/xm4k/bin/abr_bashrc -d ~/xm4k -p "sd4k xm40 xm4k hd4k"

#PROJECT_BASE=~/xm4k PROJECTS="xm40 xm41 hd4k sd4k" . ~/xm4k/bin/abr_bashrc
#. ~/tp1k/bin/x3k_bashrc
