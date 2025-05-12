#!/bin/bash

# copies all changes to destinationDir & removes non existing files from targetDir in destinationDir
function makeMirrorImage {
    declare -n mirrorDirs=$1 # target & destination dirs

    # make mirror image; targetDir -> {mirroring to} -> destinationDir
    for key in "${!mirrorDirs[@]}"; do
        targetDir="$key"
        destinationDir="${!mirrorDirs[@]}"
        
        # starting mirroring process using rsync
        rsync -av --delete --exclude-from="exclude.txt" "$targetDir" "$destinationDir" # (could use -z for compression for transfer)
}