# NetConnectWatch
Pings sites at set time frame diagnose network connection issues.

# NetConnectWatch
- PS file that runs the watcher

# HDSN-NetConnectWatch
- XML file to add file to Windows Task Scheduler

# What the script does
- on a schedule set by windows task scheduler, ping multiple different  IP addresses and write the output to a CSV.
- Let the script run for as long as needed to find correlation between network connection issues.

# How to use
1. Download the two files included in this repo
2. Place files in "C:/Scripts/NetConnectWatch/" (By default this is where the scheduled task will look for the file.)
3. open the file NetConnnectWatch.ps1
4. Change the values of $externalip, $ExternalDNS and $ExternalSiteName to what you would like the device to check regularly
5. Open Windows task scheduler and import HDSN-NetConnectWatch.xml, change values as you see fit and hit finish 
6. When the script runs, it will create a CSV doc logging pings every 5 minute (by default, set in windows task scheduler)
