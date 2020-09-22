## Commonly-used functions

OS=$(uname)

function source_it() {
    [[ -e $1 ]] && source $1
}

function add_path() {
    [[ -d $1 ]] && export PATH="$PATH:$1"
}

function exe_installed() {
    if type "$1" > /dev/null; then
        return 0
    fi

    return 1
}
