#!/bin/bash
# Script to display basic system information

# Storing information in variables
USER=$(whoami)
HOST=$(hostname)
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
OS=$(uname -s)
CWD=$(pwd)
HOME_DIR=$HOME
USERS_COUNT=$(who | wc -l)
UPTIME_VAL=$(uptime -p)

# Displaying the information
echo "------------------------------"
echo "  SYSTEM INFORMATION DISPLAY"
echo "------------------------------"
echo "Username      : $USER"
echo "Hostname      : $HOST"
echo "Date & Time   : $CURRENT_TIME"
echo "OS            : $OS"
echo "Current Dir   : $CWD"
echo "Home Dir      : $HOME_DIR"
echo "Users Online  : $USERS_COUNT"
echo "Uptime        : $UPTIME_VAL"
echo "------------------------------"
