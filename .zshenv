export PATH=$HOME/bin:$PATH
export R_HOME=/Library/Frameworks/R.framework/Resources

if [ -d $HOME/.phpenv ]; then
    export PATH=$HOME/.phpenv/shims:$HOME/.phpenv/bin:$PATH
    eval "$(phpenv init -)"
fi

if [ -d $HOME/.golang ]; then
    export GOPATH=$HOME/.golang
    PATH=$GOPATH/bin:$PATH
fi

if [ -d $HOME/.rbenv  ] ; then
  export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi
typeset -gxU PATH R_HOME GOPATH