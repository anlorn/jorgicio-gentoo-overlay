#!/sbin/openrc-run

command="/usr/bin/python3 -u -m optimus_manager.daemon"
pidfile=${pidfile-/var/run/optimus-manager.pid}
description="Optimus Manager Commands daemon"

depend() {
    before xdm
}

start_pre() {
    /usr/bin/python3 -u -m optimus_manager.hooks.pre_daemon_start
    /usr/bin/python3 -u -m optimus_manager.hooks.pre_xorg_start
}

stop_post() {
  /usr/bin/python3 -u -m optimus_manager.hooks.post_daemon_stop
}

start() {
    ebegin "Starting Optimus Manager daemon"
    start-stop-daemon --quiet --background --start \
       --make-pidfile --pidfile $pidfile -- $command
    eend $? "Failed to start Optimus Manager daemon"
}

stop() {
    ebegin "Stopping Optimus Manager daemon"
    start-stop-daemon --quiet --stop --pidfile $pidfile --signal QUIT
    eend $? "Failed to stop Optimus Manager daemon"
}
