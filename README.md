# termux_remote_restart

Quick and dirty script to deploy for termux-widgets to restart systemd unit. 


1. Deploy script into termux home folder.
2. Create additional .sh scripts in $HOME/.shortcuts/ that call this main script.
3. You will need to use the following format to call this script:
	./restartCon.sh service-name privilege-level

service-name = name of the systemd unit file you want to call
privilege-level = (0) run as user or (1) run as sudo 
