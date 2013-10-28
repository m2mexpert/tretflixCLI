# tretflix vApp CLI

## Overview:
**tretflix vApp CLI**, the command set for the **tretflix vApp**
<br>

### Syntax:

**Appliance Commands:**

	Usage: tretflix appliance [COMMAND] [INPUT]

	Commands:
	  tretflix appliance setup  
	  tretflix appliance backup  
	  tretflix appliance restore [FILE]


**Application Commands:**

	Usage: tretflix application [OPTION] [COMMAND] [INPUT]

	COMMANDS:
	  tretflix application [OPTION] enable
	  tretflix application [OPTION] disable
	  tretflix application [OPTION] set username [USERNAME]
	  tretflix application [OPTION] set password [PASSWORD]
	  tretflix application [OPTION] set port [PORT]
	  tretflix application [OPTION] new apikey
	  tretflix application [OPTION] show config
	  tretflix application [OPTION] reset config

	OPTIONS:
	  -a, --all
	  -b, --sickbeard
	  -c, --couchpotato
	  -m, --maraschino
	  -s, --sabnzbd
	  -t, --transmission
	  
	  Note: 'all' option not available w/ the 'set port' command.
	  
	  
**Network Commands:**

	Usage: tretflix network [COMMAND] [INPUT]

	COMMANDS:
	  tretflix network set static [IPV4] [NETMASK] [GATEWAY]
	  tretflix network set dns [SERVER1] [SERVER2] ...
	  tretflix network set domain [DOMAIN]
	  tretflix network show config
	  tretflix network reset config
	  

**Storage Commands:**

	Usage: tretflix storage [COMMAND] [INPUT] [OPTION]

	COMMANDS:
	  tretflix storage add cifs [ADDRESS] [LABEL] [OPTION] ...
	  tretflix storage add nfs [ADDRESS] [LABEL] [OPTION] ...
	  tretflix storage del cifs [ADDRESS] [LABEL]
	  tretflix storage del nfs [ADDRESS] [LABEL]
	  tretflix storage show config
	  tretflix storage reset config

	OPTIONS:
	  -u, --username [USERNAME]
	  -p, --password [PASSWORD]