#!/sbin/openrc-run

command="/usr/bin/optimus-manager-daemon"
pidfile=${pidfile-/var/run/optimus-manager.pid}
description="Optimus Manager Commands daemon"

depend() {
    before xdm
}

start_pre() {
    /sbin/prime-switch-boot || return $?
}

start() {
    ebegin "Starting Optimus Manager daemon"
    start-stop-daemon --quiet --background --start --exec $command \
       --make-pidfile --pidfile $pidfile -- ""
    eend $? "Failed to start Optimus Manager daemon"
}

stop() {
    ebegin "Stopping Optimus Manager daemon"
    start-stop-daemon --quiet --stop --pidfile $pidfile --signal QUIT
    eend $? "Failed to stop Optimus Manager daemon"
}
