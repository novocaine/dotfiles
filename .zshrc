export HOME="/cygdrive/c/users/jsalter"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000


autoload -U compinit
compinit

autoload -U promptinit
promptinit

prompt fire red magenta blue white white white
# munge prompt to contain current devsite
PS1=`echo $PS1 | sed -e 's/%P}/%P} | %F{blue}$devsite/'`
setopt hist_ignore_all_dups
setopt auto_pushd
setopt menu_complete
setopt auto_cd

alias gvimnofork='cyg-wrapper.sh "C:/Program Files (x86)/vim/vim72/gvim.exe" --binary-opt=-c,--cmd,-T,-t,--servername,--remote-send,--remote-expr'
alias gvim="gvimnofork --fork=1"
alias gvimr='gvim --remote'

# edit gvimrc and update it on github
alias gvz='gvimnofork ~/.zshrc && cp ~/.zshrc ~/zshrc && cd ~/zshrc && git commit -a -m "automatic gitpush zshrc" && git push origin master && popd > /dev/null'
alias sz='source ~/.zshrc'
alias ls='ls --color -G'
alias lsa='ls -altrG'
alias lsd='ls -d *(/)'

export PATH=/cygdrive/c/python26:/cygdrive/c/python26/Tools/Scripts:~/bin:$PATH
alias cygset='cygstart ~/bin/cygset'
export http_proxy=http://webironport

alias log='tail -f ~/xplanbase/var/jamesdev/log/server.log'
alias cxxlog='tail -f ~/xplanbase/var/jamesdev/log/cxxserver.log'
export SVN_EDITOR="gvim -f"

alias cdb='cd ~/xplanbase/version/$xbranch'

# persistent branch setting stuff
setbranch() {
    cd ~/xplanbase/version/$xbranch;
}

# switch branches
alias 32='export xbranch="1.32.999"; setbranch;'
alias 33='export xbranch="1.33.999"; setbranch;'
alias rt='export xbranch="1.34.999"; setbranch;' 

alias xpt='cdb; cd src/py/xpt';
alias www='cdb; cd data/wwwroot';
alias js='www; cd js';
alias css='www; cd css';
alias ih='cdb; cd data/ihtml';
alias cxx='cdb; cd src/cxx';

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

alias webget='curl -x webironport:80 -s'
ABC_RSS="http://www.abc.net.au/news/syndicate/topstoriesrss.xml"

function abc_news() {
    webget $ABC_RSS | python xml_printer.py
}

function random_abc_headline() {
    webget $ABC_RSS | python "c:\users\jsalter\bin\xml_printer.py" random
}

alias rtr='random_abc_headline & restart_site $devsite';
alias stalk='python bin/runNightstalker_win32.py -c "Single-Instance Site (No IPS)" -v ../var/jamesdev'
# disable import tagging for ctags; this avoids always jumping to the bazillion
# import definitions for a given method
alias ctags='ctags --python-kinds=-i'
alias mkxt='sitectrl kill $devsite && make FAST=1 -C src/cxx -j8 && rtr'
alias mkxslm='sitectrl kill $devsite && make FAST=1 -C src/xslm && rtr'
alias xcon='telnet localhost 18052'
alias mk='make FAST=1'
alias al='tail -f ~/xplanbase/var/$devsite/log/access.log | ack -v "\.js|\.png|\.gif|\.css"'

# only permit svn in cygwin terminals i.e. console2
[[ $TERM != 'cygwin' ]] && alias svn='echo not in svn console: '

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

TORTOISE_PROC="/cygdrive/c/Program Files/TortoiseSVN/bin/TortoiseProc.exe"

function ts () {
    if [[ $# == 1 ]];
    then
        2=".";
    fi
    $TORTOISE_PROC /command:$1 /path:$2
}
