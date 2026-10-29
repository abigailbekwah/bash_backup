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

# 5. Naming the folder,timestamp and packing it cleanly
    DATE=$(date +"%y%M%d-%h%m%s")
    NAME=$(basename "$SOURCE")
    FILE="DEST/${NAME}-${NAME}-{DATE}.tar.gz"

        echo "Backing up $SOURCE to $FILE..."
        #NAME only folder name-> clean
        Src="/home/Abi/Documents"
        tar -czf "$Documents" -c "$(dirname "$SOURCE")"

