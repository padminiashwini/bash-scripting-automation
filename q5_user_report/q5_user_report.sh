#!/bin/bash

echo "======================================"
echo "         USER SYSTEM REPORT           "
echo "======================================"
echo

# 1. USER STATISTICS

echo "========== USER STATISTICS =========="

# Total users
total_users=$(awk -F: 'END {print NR}' /etc/passwd)

# System users (UID < 1000)
system_users=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)

# Regular users (UID >= 1000)
regular_users=$(awk -F: '$3 >= 1000 {count++} END {print count}' /etc/passwd)

# Currently logged in users
logged_in=$(who | wc -l)

echo "Total Users: $total_users"
echo "System Users (UID < 1000): $system_users"
echo "Regular Users (UID >= 1000): $regular_users"
echo "Currently Logged In Users: $logged_in"
echo

# 2. USER DETAILS TABLE

echo "========== USER DETAILS =========="
printf "%-15s %-8s %-20s %-15s %-20s\n" "Username" "UID" "Home Directory" "Shell" "Last Login"
echo "---------------------------------------------------------------------------------------"

awk -F: '$3 >= 1000 {
    username=$1
    uid=$3
    home=$6
    shell=$7

    # Get last login (only first line)
    cmd = "lastlog -u " username " | tail -n 1"
    cmd | getline lastlogin
    close(cmd)

    printf "%-15s %-8s %-20s %-15s %-20s\n", username, uid, home, shell, lastlogin
}' /etc/passwd

echo

# 3. GROUP INFORMATION


echo "========== GROUP INFORMATION =========="

awk -F: '
{
    groupname=$1
    members=$4

    if (members == "")
        count=0
    else
        count=split(members, arr, ",")

    printf "Group: %-20s Members: %d\n", groupname, count
}
' /etc/group

echo


# 4. SECURITY CHECK


echo "========== SECURITY CHECK =========="

echo "Users with UID 0 (Root Privileges):"
awk -F: '$3 == 0 {print " - " $1}' /etc/passwd
echo

echo "Users without passwords (check /etc/shadow):"
sudo awk -F: '($2 == "" || $2 == "!" || $2 == "*") {print " - " $1}' /etc/shadow
echo

echo "Inactive users (Never logged in):"
lastlog | grep "Never logged in" | awk '{print " - " $1}'

echo
echo "============= END OF REPORT ============="