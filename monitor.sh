#!/bin/bash
#https://medium.com/@FlorenceOkoli/smtp-mailutils-how-to-send-your-mails-via-the-linux-terminal-6d95803a1104
# https://medium.com/@subhomay/effective-linux-server-monitoring-with-a-shell-script-for-cpu-and-ram-usage-b3d1523892ed

while true
do
    # Get current CPU usage as a percentage
    #CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    CPU=$(top -bn1 | awk '{print $9}'|sed -n '8p')
    
    # Get current RAM usage as a percentage
    RAM=$(free -t| awk '/Tot/{printf("%.2f"), $3/$2*100}')
    
    # Check if either usage is above 80%
    if [ $(echo "$CPU > 80" | bc -l) -eq 1 ] || [ $(echo "$RAM > 80" | bc -l) -eq 1 ]
    then
        # Send an alert via email or any other desired method
        echo "Current CPU usage is $CPU% and Current RAM usage is $RAM%. Take action immediately." | mail -s "Alert: High resource usage on EC2 instance" ibrahimshaikh100@outlook.com
    fi
    
    # Sleep for 5 minute before checking again
    sleep 100
done
