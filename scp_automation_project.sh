#!/usr/bin/env bash
# For this script 'at' program needed 
# If it is missing try to install
# sudo apt-get install <debian/ubuntu>
# sudo yum install at <fedora/redhat>
# scp switch port local_file user@address:/path/to/remote | at timer;
read -p "SCP switch: [Enter for -P] " swith
if [[ -z $switch ]]; then switch="-P"; fi
read -p "Port: [Enter for 22] "  port
if [[ -z $port ]]; then port=22; fi
read -p "Exact path to your local file: [/path/to/your/file] " local_path
while [[ -z $local_path ]]; do read -p "Local path needed!: " local_path; done
read -p "Username to login through SSH: " ssh_username
while [[ -z $ssh_username ]]; do read -p "SSH username needed!: " ssh_username; done
read -p "SSH address: " ssh_address
while [[ -z $ssh_address ]]; do read -p "SSH address needed!: " ssh_address; done
read -p "Path to remote folder: [/path/to/remote/folder] " remote_folder
while [[ -z $remote_folder ]]; do read -p "Remote folder needed!: " remote_folder; done
read -p "When does it have to be executed: [HH:MM] (enter for execute now) " timer
if [[ -z $timer ]];then
    scp $switch $port $local_path $ssh_username@$ssh_address:$remote_folder
    printf "Done at $(date)\n"
else
    scp $switch $port $local_path $ssh_username@$ssh_address:$remote_folder | at $timer
    printf "Done at $(date)\n" | at $timer
fi