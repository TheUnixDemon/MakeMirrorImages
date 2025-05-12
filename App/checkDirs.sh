#!/bin/bash

# checks if directories exists and if not exit the program
function checkDirs {
    declare -n checkDirs=$1 # reference to targetDirs
    
    # checking directories
    echo "[checking directories]"
    for key in "${!checkDirs[@]}"; do
        # declaring dir variables
        targetDir="$key"
        destinationDir="${!checkDirs[@]}"
        
        # checking dirs and if fails exit program
        # targetDir
        if [ -d "$targetDir" ]; then
            echo "✓ $targetDir"
        else
            echo "❌ $targetDir"
            exit 1
        fi
        # destinationDir
        if [ -d "$destinationDir" ]; then
            echo "✓ $destinationDir"
        else
            echo "❌ $destinationDir"
            exit 1
        fi
    done
}