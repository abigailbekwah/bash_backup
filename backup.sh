!#/bin/bash
#bash backuo tools to use
# configuration
#were the source is from,where to backup,where to save,how many to keep and how long.
    SOURCE="/home/documents"
    DEST="$home/backups"
    TIMESTAMP=$(date + "%y-%m-%d_%h-%m-%s")
    BACKUP_NAME="backup_${TIMESTAMP}.tar gz"
    HEEP=7

    echo "backing up sources"

    # 1. CHECKS
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist." >&2
    exit 1
fi

    #Create destination in case it does not exist
    mkdir -p "$DEST"

    # 2. compress -tar + gzip
    tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$NAME"

    # 3. check if it works
if [ $? -eq 0 ]; then
    echo "success: $BACKU_FILE created"
else
    echo "Failed to create backup"
    exit 1
fi


