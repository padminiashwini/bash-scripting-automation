#!/bin/bash
# Analyzes a web log file

LOGFILE=$1

# Check if file argument is provided and exists
if [[ -z "$LOGFILE" || ! -f "$LOGFILE" ]]; then
    echo "Error: Please provide a valid log file."
    exit 1
fi

# Check if file is empty
if [[ ! -s "$LOGFILE" ]]; then
    echo "Error: Log file is empty."
    exit 1
fi

echo "=== LOG FILE ANALYSIS ==="
echo "Log File: $LOGFILE"

# 1. Total Entries
TOTAL=$(wc -l < "$LOGFILE")
echo "Total Entries: $TOTAL"

# 2. Unique IP Addresses (count + list)
echo "Unique IP Addresses:"
UNIQUE_IPS=$(awk '{print $1}' "$LOGFILE" | sort -u)
UNIQUE_COUNT=$(echo "$UNIQUE_IPS" | wc -l)

echo "$UNIQUE_COUNT"
echo "$UNIQUE_IPS" | awk '{print " - " $1}'

# 3. Status Code Summary
echo "Status Code Summary:"
awk '{print $NF}' "$LOGFILE" | sort | uniq -c | while read count code
do
    echo " $code: $count requests"
done

# 4. Most Frequently Accessed Page
echo "Most Frequently Accessed Page:"
awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 1 | \
awk '{print " " $2 " - " $1 " requests"}'

# 5. Top 3 IP Addresses
echo "Top 3 IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 3 | nl | \
while read num count ip
do
    echo " $num. $ip - $count requests"
done