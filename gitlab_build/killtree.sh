#!/bin/bash

# it is able to kill a process provided and all child sub-processes of that process (doesn't affect parents)
# execute with: killtree <pid> <sig>
# ie: killtree 123 kill
killtree() {
    local _pid=$1
    local _sig=${2:-TERM}
    # needed to stop quickly forking parent from producing child between child killing and parent killing
    kill -stop ${_pid} 
    echo "kill -stop ${_pid}"
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    kill -${_sig} ${_pid}
    echo "kill -${_sig} ${_pid}"
}

if [ $# -eq 0 -o $# -gt 2 ]; then
    echo "Usage: $(basename $0) <pid> [signal]"
    exit 1
fi

killtree $@
