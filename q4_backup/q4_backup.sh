#!/bin/bash

echo "=== AUTOMATED BACKUP SCRIPT ==="

# Record start time
start_time=$(date +%s)

# 1. Ask for source directory
read -p "Enter directory to backup: " SOURCE

# Validate source directory
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

# 2. Ask for destination directory
read -p "Enter backup destination: " DEST

# Create destination if it doesn't exist
mkdir -p "$DEST"

# 3. Ask for backup type
echo ""
echo "Backup Type:"
echo "1. Simple copy"
echo "2. Compressed archive (tar.gz)"
read -p "Enter choice (1 or 2): " choice

# 4. Create timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Perform backup
if [ "$choice" = "1" ]; then
    
    BACKUP_NAME="backup_$TIMESTAMP"
    cp -r "$SOURCE" "$DEST/$BACKUP_NAME"

elif [ "$choice" = "2" ]; then
    
    BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
    tar -czf "$DEST/$BACKUP_NAME" "$SOURCE"

else
    echo "Invalid choice."
    exit 1
fi

# 5. Verification
if [ -e "$DEST/$BACKUP_NAME" ]; then
    
    echo ""
    echo "Backup completed successfully!"

    # 6. Summary Details
    echo ""
    echo "Backup Details:"
    echo "File: $BACKUP_NAME"
    echo "Location: $DEST"
    
    echo -n "Size: "
    du -h "$DEST/$BACKUP_NAME" | cut -f1

    # Calculate time taken
    end_time=$(date +%s)
    time_taken=$((end_time - start_time))
    echo "Time taken: $time_taken seconds"

else
    echo "Backup failed."
fi