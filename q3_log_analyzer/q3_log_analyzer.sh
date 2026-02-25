#!/bin/bash
# Analyzes a web log file

LOGFILE=$1

# Check if file argument is provided and exists
if [[ -z "$LOGFILE" || ! -f "$LOGFILE" ]]; then
    echo "Error: Please provide a valid log file."
    exit 1
fi

echo "=== LOG FILE ANALYSIS ==="
echo "Log File: $LOGFILE"

# 1. Total Entries
echo "Total Entries: $(wc -l < "$LOGFILE")"

# 2. Unique IPs
echo "Unique IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort -u

# 3. Status Code Summary
echo "Status Code Summary:"
awk '{print $NF}' "$LOGFILE" | sort | uniq -c

# 4. Top 3 IP Addresses
echo "Top 3 IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 3