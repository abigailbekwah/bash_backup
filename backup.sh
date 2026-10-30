#!/bin/bash

# ==============================================================================
# CONFIGURATION & DEFAULTS
# ==============================================================================
SOURCE="/home/Documents"
DEST="$HOME/backups"  # Fixed: $home should be capitalized $HOME
KEEP=7

# ==============================================================================
# UTILITY FUNCTIONS
# ==============================================================================

# Function for printing errors to stderr
print_error() {
    echo "Error: $1" >&2
}

# Function to show script usage
show_help() {
    echo "Usage: $(basename "$0") [-d DEST] [-k KEEP] SOURCE"
    echo "  SOURCE          Folder to backup"
    echo "  -d DEST         Where to save backup (Default: $HOME/backups)"
    echo "  -k KEEP         How many backups to keep (Default: 7)"
    echo "  -h              Show this help menu"
    exit 0
}

# ==============================================================================
# CORE LOGIC FUNCTIONS
# ==============================================================================

create_backup() {
    local src="$1"
    local dest="$2"

    # Validate source exists and is a directory
    if [ ! -d "$src" ]; then
        print_error "Source directory '$src' does not exist or is not a folder."
        exit 1
    fi

    # Create destination in case it does not exist
    mkdir -p "$dest"

    # Generate clean timestamp and filenames
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M%S")
    local folder_name
    folder_name=$(basename "$src")
    local backup_file="$dest/${folder_name}-${timestamp}.tar.gz"

    echo "Backing up $src to $backup_file..."

    # Compress using tar and gzip safely
    tar -czf "$backup_file" -C "$(dirname "$src")" "$folder_name"
    
    # Check if the backup succeeded
    if [ $? -eq 0 ]; then
        echo "Success: $backup_file created successfully."
    else
        print_error "Backup failed to complete."
        exit 1
    fi
}

rotate_backups() {
    local dest="$1"
    local keep="$2"
    local folder_name="$3"

    echo "Rotating backups in '$dest' (keeping last $keep)..."

    # Find matching backups, sort oldest first, and delete if they exceed KEEP count
    # This safer approach prevents parsing errors from raw 'ls' piping
    local backup_count
    backup_count=$(find "$dest" -maxdepth 1 -name "${folder_name}-*.tar.gz" | wc -l)

    if [ "$backup_count" -gt "$keep" ]; then
        local to_delete=$((backup_count - keep))
        echo "Found $backup_count backups. Deleting $to_delete oldest backup(s)..."
        
        # List oldest first and delete them
        find "$dest" -maxdepth 1 -name "${folder_name}-*.tar.gz" -printf '%T+ %p\n' | \
            sort | head -n "$to_delete" | awk '{print $2}' | while read -r old_file; do
                rm -f "$old_file"
                echo "Deleted old backup: $old_file"
            done
    else
        echo "No backup rotation needed ($backup_count/$keep backups present)."
    fi
}

# ==============================================================================
# MAIN EXECUTION THREAD
# ==============================================================================

# Parse options using getopts flags
while getopts "d:k:h" opt; do
    case "$opt" in
        d) DEST="$OPTARG" ;;
        k) KEEP="$OPTARG" ;;
        h) show_help ;;
        *) echo "Invalid option. Use -h for help." >&2; exit 1 ;;
    esac
done

# Shift off the options flags so $1 becomes our trailing SOURCE path
shift $((OPTIND -1))

# Check if a custom SOURCE was provided as a trailing argument; if so, override default
if [ -n "$1" ]; then
    SOURCE="$1"
fi

# Validate that KEEP is a positive integer
if ! [[ "$KEEP" =~ ^[1-9][0-9]*$ ]]; then
    print_error "KEEP must be a positive number greater than 0."
    exit 1
fi

# Run the core tasks cleanly
FOLDER_NAME=$(basename "$SOURCE")
create_backup "$SOURCE" "$DEST"
rotate_backups "$DEST" "$KEEP" "$FOLDER_NAME"

echo "Backup process fully completed."
exit 0
