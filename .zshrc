# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="james"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(svn osx)

# edit gvimrc and update it on github
alias github_zshrc="cp ~/.zshrc ~/zshrc && cp ~/.vimrc ~/zshrc && cd ~/zshrc && git commit -a -m 'automatic gitpush zshrc' && git push origin master && popd > /dev/null"

export http_proxy=http://syd-devproxy1:80
export HTTPS_PROXY=$http_proxy
export https_proxy=$HTTPS_PROXY

source $ZSH/oh-my-zsh.sh

alias svn=/usr/local/bin/svn

# Customize to your needs...
export PATH=~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

function wf () {
    dest=`sudo brew --cache $2`
    fname=${dest##*/}
    ssh jsalter.id.au "wget $1 -O ~/tmp/$fname"
    scp jsalter.id.au:~/tmp/$fname /tmp/$fname
    sudo mv /tmp/$fname ${dest%/*}
}

source ~/xplan/xplan_env
export VIRTUAL_ENV_DISABLE_PROMPT=1
source ~/xplan/ve/bin/activate

alias g="mvim --remote"

export OMNINAMES_LOGDIR=/tmp
alias on="rm /tmp/omninames-James-Salters-Mac-mini.local.* && omniNames -start 2810"
alias sz="source ~/.zshrc"

xbranch=trunk
BRANCHDIR=~/xplanbase/version/$xbranch

# ignore these in autocomplete
fignore=('*.pyc' '*.dat' '~')

alias sz='source ~/.zshrc'
alias ls='ls -G'
alias lsa='ls -altrG'
alias lsd='ls -d *(/)'

alias cdb='cd ~/xplan/$xbranch'
alias cds='cd `echo $PWD | gsed -e "s|/Users/jsalter/xplan/[^/]\+|/Users/jsalter/xplan/$xbranch|"`'
alias tr='export xbranch=trunk; cds;'
alias 20='export xbranch=2.0.999; cds;'
alias 21='export xbranch=2.1.999; cds;'
alias 22='export xbranch=2.2.999; cds'
alias 23='export xbranch=2.3.999; cds'
alias 24='export xbranch=2.4.999; cds'
alias 25='export xbranch=2.5.999; cds'
alias 34='export xbranch=1.34.999; cds'

alias xpt='cdb; cd src/py/xpt';
alias idl='cdb; cd idl';
alias ejs='www; cd ejs';
alias www='cdb; cd data/wwwroot';
alias wwwroot=www;
alias js='www; cd js';
alias css='www; cd css';
alias ih='cdb; cd data/ihtml';
alias ihtml=ih;
alias cxx='cdb; cd src/cxx';
alias hf='cd ~/xplan/hotfix';
alias hotfix=hf;
alias var='cd ~/xplan/var';
alias ack='ack --ignore-dir js.min --ignore-dir css.min';
export ACK_PAGER='less -FRX'
export ACK_OPTIONS="--type-set idl=.idl"
alias svnm="svn merge --ignore-ancestry" 
export CTAGS=/usr/local/Cellar/ctags/5.8/bin/ctags
alias ch="sh ~/xplan/hotfix/bin/compile_hotfix.sh"
export EDITOR=vim;
export PYTHONPATH=$PYTHONPATH:~/xplan/trunk/bin:~/xplan/trunk/py:~/xplan/trunk/lib/py:~/xplan/trunk/tools/py:~/xplan/trunk/src/py:~/xplan/trunk/lib/arch/darwin-x86:~/xplan/trunk/lib/arch/darwin-x86/pyxtools
export PYPY=~/xplan/ve_pypy/bin/pypy

function slog() {
    svn log $*[1,-2] | sed -n "/$*[$#]/,/----$/ p"
}

function cpk () {
    if [[ $1 == '' ]] then
        # determine rev to commit as last commit by us
        rev=`svn log ^/trunk/xplan -l 100 | grep jsalter | head -n 1 | grep '^r[0-9]\+' -o | sed s/r//`
    else
        rev=$1
    fi
    svn log ^/trunk/xplan -c $rev | tail -n +4 | head -1 > /tmp/mergelogmsg
    cat /tmp/mergelogmsg
    echo merging r$rev...
    svn update
    svn merge ^/trunk/xplan -c $rev --ignore-ancestry
}

ts () {
    if [[ $# = 1 ]]
    then
            2="."
    fi
    abspath=`cd $2; pwd`;
    abspath=`echo $abspath | sed -e s+/Users/jsalter++`
    p=Z:/jsalter\ On\ My\ Mac$abspath
    echo $p
    "/Applications/VMware Fusion.app/Contents/Library/vmrun" -T fusion -gu "James Salter" -gp novogah7 runProgramInGuest ~/Documents/Virtual\ Machines.localized/Windows\ 7.vmwarevm/Windows\ 7.vmx -interactive -noWait "c:\Program Files\TortoiseSVN\bin\proc.bat" "$1" $p $3 $4
}

qack () {
    mdfind -0 -onlyin . $1 | xargs -0 ack -H $1 $2 $3 $4 $5
}

gack () {
    ack -G GNUmakefile -a $1
}

alias sr='svn resolved'

st () {
    svn st | sed -e 's+^\([^ -].\{7\}\)+\1mvim:\/\/open\?url=file:\/\/'"$PWD"'\/+'
}

alias di='svn diff'

uhf () {
    curl --form process=__all__ --form hotfix=@$1 --form submit=Upload https://xplan.iress.com.au/$2/hotfix --form params=$3 --form params=$4
}

alias winpdb='/Library/Frameworks/Python.framework/Versions/2.7/bin/python /Users/jsalter/xplan/ve/lib/python2.7/site-packages/winpdb.py'

alias mkxl='make -C src/xlsm -j3'

alias nt="XFUDGE_SITENAME=autotest nosetests -c ~/xplan/trunk/src/py/nose-developer.cfg"
alias gdbnt="gdb --args python /Users/jsalter/xplan/ve/bin/nosetests -c ~/xplan/trunk/src/py/nose-developer.cfg"
alias xtest='cd ~/xplan/trunk/src/py/xtest'

export LESS=-I

alias gdbcx="gdb --pid=`ps -acx | grep cxxserver | cut -d ' ' -f 1`"
alias top='top -o cpu'

function revs_for_osc () {
    # $1 is 'since'
    svn log -r$1:HEAD | grep "OSC $2" -B 2 | grep '^r' | cut -b 2- | cut -d ' ' -f 1 | paste -d ' ' -s -
}

function merge_trunk () {
    svn update
    svnm -c $1 ^/trunk/xplan
}

unalias history

# enable core dumps
ulimit -c unlimited

alias ss='python bin/sitestart.py -d var=default'
