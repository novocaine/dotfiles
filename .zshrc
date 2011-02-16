export HOME="/cygdrive/c/users/jsalter"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
xbranch=1.35.999
BRANCHDIR=~/xplanbase/version/$xbranch

autoload -U compinit
compinit

. ~/.zsh_completion

autoload -U promptinit
promptinit

prompt fire red magenta blue white white white
# munge prompt to contain current devsite
PS1=`echo $PS1 | sed -e 's/%P}/%P} | %F{blue}$devsite/'`
setopt hist_ignore_all_dups
setopt extended_history
setopt share_history
setopt auto_pushd
setopt menu_complete
setopt auto_cd
setopt hist_verify

# ignore these in autocomplete
fignore=('*.pyc' '*.dat' '~')

alias gvimnofork='cyg-wrapper.sh "C:/Program Files (x86)/vim/vim72/gvim.exe" --binary-opt=-c,--cmd,-T,-t,--servername,--remote-send,--remote-expr'
alias gvim="gvimnofork --fork=1"
alias gvimr='gvim --remote'
alias g=gvimr

# edit gvimrc and update it on github
alias github_zshrc="cp ~/.zshrc ~/.zsh_completion ~/zshrc && cp ~/_vimrc ~/zshrc && cd ~/zshrc && git commit -a -m 'automatic gitpush zshrc' && git push origin master && popd > /dev/null"
alias gvz='gvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias ls='ls --color -G'
alias lsa='ls -altrG'
alias lsd='ls -d *(/)'

export PATH=/cygdrive/c/python26:/cygdrive/c/python26/Tools/Scripts:~/bin:$PATH
alias cygset='cygstart ~/bin/cygset'
export http_proxy=http://webironport

ts_color="dark"
log_name_color="yellow"
pid_color="bold blue"
bracket_color="bold blue"
st_color="green"
jsalter_color="bold"
alias -g ackpasscolor="ack --passthru --flush --color"
alias -g colorizelog="ackpasscolor --color-match=$jsalter_color '\[[^-]+,[0-9]+\]' | ackpasscolor --color-match=$ts_color '^\w+ \d{2} \d{2}:\d{2}:\d{2}.\d{3}' | ackpasscolor --color-match=$log_name_color '[a-z_\.]+\[[^\]]+\]: ' | ackpasscolor --color-match='$pid_color' '\[(-|j)[^\]]+\]:' | ackpasscolor --color-match=$st_color 'File.+line [0-9]+.*'"
alias -g colorizecxxlog="ackpasscolor --color-match=$ts_color '^\[[^\]]+\]'"

function logc () {
    cat ~/xplanbase/var/$devsite/log/server.log | colorizelog | less -R -S +G
}

function log () {
    less -S +F ~/xplanbase/var/$devsite/log/server.log
}

function cxxlogc() {
    less -S +F ~/xplanbase/var/$devsite/log/cxxserver.log
}

function cxxlog() {
    cat ~/xplanbase/var/$devsite/log/cxxserver.log | less -S -R +F
}

function upgradelog() {
    cat ~/xplanbase/var/$devsite/log/upgrade.log | colorizelog | less -R +G
}

export SVN_EDITOR="gvim -f"

alias cdb='cd ~/xplanbase/version/$xbranch'

# persistent branch setting stuff
setbranch() {
    cd ~/xplanbase/version/$xbranch;
}

# switch branches
alias 32='export xbranch="1.32.999"; setbranch; devsite_from_pwd;'
alias 33='export xbranch="1.33.999"; setbranch; devsite_from_pwd'
alias 34='export xbranch="1.34.999"; setbranch; devsite_from_pwd'
alias tr='export xbranch="1.35.999"; setbranch; devsite_from_pwd' 

alias xpt='cdb; cd src/py/xpt';
alias www='cdb; cd data/wwwroot';
alias wwwroot=www;
alias js='www; cd js';
alias css='www; cd css';
alias ih='cdb; cd data/ihtml';
alias ihtml=ih;
alias cxx='cdb; cd src/cxx';
alias hf='cd ~/xplanbase/hotfix';
alias hotfix=hf;
alias var='cd ~/xplanbase/var';

alias ack='ack --ignore-dir js.min --ignore-dir css.min';
export ACK_PAGER='less -R'
alias winpdb='cygstart "c:\python26\scripts\winpdb.bat"';
alias sitectrl="/cygdrive/c/xplanbase/sitemgr/sitectrl";

devsite=jamesdev;
function ds() {
    export devsite=$1;
}

function restart_site() {
    echo "Restarting site $devsite"
    sitectrl kill $1 && sitectrl start $1;
    while sitectrl status | grep "$1.*RUNNING.*(8080)" > /dev/null
    do
        sleep 1
    done

    # echo server status
    sitectrl status | grep "$1."    
}

function kill_site() {
    echo "Killing site $devsite"
    sitectrl kill $1
}

alias webget='curl -x webironport:80 -s'
ABC_RSS="http://www.abc.net.au/news/syndicate/topstoriesrss.xml"

function abc_news() {
    webget $ABC_RSS | python xml_printer.py
}

function random_abc_headline() {
    webget $ABC_RSS | python "c:\users\jsalter\bin\xml_printer.py" random
}

function devsite_from_pwd() {
    ver=`echo $PWD | grep -o 'version/\([^/]*\)' | sed -e 's/version\///'`;
    devsite=${site_instances[${ver}]};
}

# map site instances to dir names
typeset -A site_instances;
site_instances=(1.33.999 133server 1.34.999 134server 1.35.999 jamesdev);

function rtr() {
    devsite_from_pwd;
    random_abc_headline & restart_site $devsite;
}

function ktr() {
    devsite_from_pwd;
    kill_site $devsite;
}

alias ktr='kill_site $devsite';

alias stalk='python bin/runNightstalker_win32.py -c "Single-Instance Site (No IPS)" -v ../var/jamesdev'
# disable import tagging for ctags; this avoids always jumping to the bazillion
# import definitions for a given method
alias ctags='ctags --python-kinds=-i'

function mktags () {
    for dir in $BRANCHDIR/src/py $BRANCHDIR/src/cxx $BRANCHDIR/test/py $BRANCHDIR/include ~/xplanbase/build/vc90/omniORB-4.1-20100317 $BRANCHDIR/data/wwwroot/js
    do
        cd $dir && ctags -R
    done
}    

alias mk='make FAST=1'
alias mkxt='ktr && mk -C src/cxx && rtr'

function mkk () {
    ktr && mkw $* && rtr
}

alias mkxl='ktr && mk -C src/xlsm -j8'
alias mkcx='ktr && mk -C src/cxx'
alias mkcxc='mk clean -C src/cxx && mkcx -j8'
alias xcon='telnet localhost 18052'
alias al='tail -f ~/xplanbase/var/$devsite/log/access.log | ack -v "\.js|\.png|\.gif|\.css"'

export TERM=ansi

alias ss='svn status | cut -c 9- | python `cygpath -w ~/bin/recentfiles.py`'
num () {
        ss | awk -v lines=$1 'NR==lines' | cut -f 3 | tr '\n' ' '
}

onwards () {
        ss | awk -v lines=$1 'NR>=lines' | cut -f 3 | tr '\n' ' '
}

alias sr="svn resolve --accept=working"
alias su="svn update"
alias sc="svn commit"
alias sd="svn diff"
alias ex="explorer"
alias ch="sh ~/xplanbase/hotfix/bin/compile_hotfix.sh"

function jsl () {
    ~/bin/jslint $1 | grep -v 'Implied global'
}

# setup XPLAN vars
source ~/bin/xplan_env.sh

function f() {
    find . -name "$1"
}

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# which changes haven't I merged in 1.34?
function forgotten_merges() {
    34
    svn log -r 128701:HEAD | grep jsalter -A 3 > ~/tmp/34_changes.txt
    tr
    svn log -r 128701:HEAD | grep jsalter -A 3 > ~/tmp/tr_changes.txt
    diff ~/tmp/34_changes.txt ~/tmp/tr_changes.txt
}    

function cpk () {
    if [[ $1 == '' ]] then
        # determine rev to commit as last commit by us
        rev=`svn log ^/trunk/xplan -l 100 | grep jsalter | head -n 1 | grep '^r[0-9]\+' -o | sed s/r//`
    else
        rev=$1
    fi
    svn log ^/trunk/xplan -c $rev | tail -n +4 | head -1 > /tmp/mergelogmsg
    echo merging r$rev...
    cat /tmp/mergelogmsg
    svn merge ^/trunk/xplan -c $rev --ignore-ancestry && ts commit . /logmsgfile:`cygpath -w /tmp/mergelogmsg`
} 

set shell=c:\cygwin\bin\zsh.exe

alias o=cygstart

function pkill () {
    for pid in $(ps -aW | grep $1 | awk '{ print $4 }');
        do /bin/kill -f $pid;
    done
}
export ACK_OPTIONS="--type-set idl=.idl"

alias revertall="svn revert -R . *"

alias sel='java -jar `cygpath -a -w ~/downloads/selenium-server-1.0.3/selenium-server.jar` -port 14444'
