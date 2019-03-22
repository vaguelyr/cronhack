This lets you make sure a script is running at all times.
It starts the script if it isn't running and quits if it is.

Usage:
	crontab:
	* * * * * /path/to/cronhack.sh "uniqueid" "/path/to/target/script"

How it works:
	When it runs the script, it saves the pid to /tmp/cronhack/<uniqueid>.
	To check if the script is running, it checks if the id files exists and whether or not that pid is running. 

/tmp/ is used because it's normally a ramdisk that is cleared between boots. This will allow the option to just run a script once per boot instead of once continiously. 
