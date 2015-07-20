#!/bin/bash

function sigterm_handler() {
    echo "SIGTERM signal received, try to gracefully shutdown all services..."
    gitlab-ctl stop
}

trap "sigterm_handler; exit" TERM

function entrypoint() {
    # Default is to run runit and reconfigure GitLab
    mv /tmp/gitlab.rb /etc/gitlab/gitlab.rb &
    gitlab-ctl reconfigure &
    /opt/gitlab/embedded/bin/runsvdir-start
}

entrypoint
