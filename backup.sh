!#/bin/bash
#bash backuo tools to use
# configuration
#were the source is from,where to backup,where to save,how many to keep and how long.
    SOURCE="/home/documents"
    DEST="$home/backups"
    TIMESTAMP=$(date + "%y-%m-%d_%h-%m-%s")
    BACKUP_NAME="backup_${TIMESTAMP}.tar gz"
    KEEP=7

    echo "backing up sources"

    # 1. CHECKS
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist." >&2
    exit 1
fi

    #Create destination in case it does not exist
    mkdir -p "$DEST"

    # Generate timestamp and filenames
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M%S")
    local folder_name
    folder_name=$(basename "$src")
    local backup_file="$dest/${folder_name}-${timestamp}.tar.gz"

    # 2. compress -tar + gzip
    tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$NAME"
     local backup_status=$?

    # 3. check if it works
if [ $? -eq 0 ]; then
    echo "success: $BACKU_FILE created"
else
    echo "Failed to create backup"
    exit 1
fi


# Function for printing errors to stderr
print_error() {
    echo "Error: $1" >&2
}

# 4. function show help
    show_help() {
        echo "Usage: backup.sh [ -d DEST] [ -k KEEP] SOURCE"
        echo " SOURCE folder to backup"
        echo " -d DEST where to save backup"
        echo " -k KEEP how many backups to keep"
        echo " -h show this help"

        ]
    print_usage
        echo "Usage: backup.sh [-d DEST] [-k KEEP] SOURCE"
            exit 0

            ;;
        
            echo "Invalid option. Use -h for help." >&2
            exit 1

    create_backup() {
    local src="$1"
    local dest="$2"

# usage check for wrong usage (Exit Code 2)
if [ "$#" -ne 1 ]; then
    print_error "Missing required argument."
    echo "Error SOURCE is required"
    exit 2
fi

# 5. Naming the folder,timestamp and packing it cleanly
    DATE=$(date +"%y%M%d-%h%m%s")
    NAME=$(basename "$SOURCE")
    FILE="DEST/${NAME}-${NAME}-{DATE}.tar.gz"

    echo "Backing up $SOURCE to $FILE..."

# NAME only folder name-> clean
        Src="/home/Abi/Documents"
        tar -czf "$Documents" -c "$(dirname "$SOURCE")"

# Check if the backup failed(exit code 1)
if [ $BACKUP_SUCCESS -ne 0]; then
    print_usage "Error bachup failed to complete"
    exit 1
fi 

#  In case of success (Exit code)
    echo "backup was completed successfully"
    exit 0

    # Clean up older backups based on the KEEP limit
rotate_backups() {
    local dest="$1"
    local keep="$2"
    local folder_name="$3"

    echo "Rotating backups in '$dest' (keeping last $keep)..."

# 6. List backup newest first, skip the first KEEP first, delete the rest
    ls -1t "$DEST"/Documents-*.tar.gz |sor -r| tail -n +$((KEEP + 1)) | while IFS= read -r old; do
    rm -- "$old"
done
# 7. Check for unknown options (handled automatically by getopts / \?)
# 8. Check if KEEP is a positive number (1 or greater)
if ! [[ "$KEEP_DAYS" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: KEEP must be a positive number (1 >)." >&2
    exit 1
fi

# 9. Check if source was provided
if [ -z "$SOURCE_DIR" ]; then
    echo "Error: Missing source folder." >&2
    exit 1 
fi
# 10. Check if source exists and is actually a directory (folder)
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: '$SOURCE_DIR' is not a valid directory or a folder." >&2
    exit 1
fi

# Execute the core tasks
    local folder_name
    folder_name=$(basename "$source_dir")

    create_backup "$source_dir" "$dest_dir"
    rotate_backups "$dest_dir" "$keep_count" "$folder_name"

    echo "Backup process completed successfully."
    exit 0
}


