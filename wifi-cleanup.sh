#!/bin/bash

# Switch to correct directory
cd /usr/local/etc/

# Generate a file with all currently saved networks. 
/usr/sbin/networksetup -listpreferredwirelessnetworks en0 > currentNetworks

# Compare to master list of networks and single out those that do not match
unwanted=`/usr/bin/comm -3 preferredNetworks currentNetworks`
/bin/echo $unwanted > deleteNet

eraseNet=`cat deleteNet`

IFS=$'\n'
# Delete the unwanted networks from my preferred list
for network in $eraseNet; do
	/usr/sbin/networksetup -removepreferredwirelessnetwork en0 $network
done

# Clean Up after myself
/bin/rm currentNetworks
/bin/rm deleteNet

exit 0
