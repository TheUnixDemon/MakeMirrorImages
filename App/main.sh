#!/bin/bash

# changing into script folder
cd "$(dirname "${BASH_SOURCE[0]}")"
# loading seperated bash scripts
source ./checkDirs.sh
source ./mirror.sh

# declaring (-A) dict for target directory to save
declare -A targetDirs=(
    ["/mnt/dr0/nas/device/"]="/mnt/dr1/nasBackup/device"
)

# checking and mirroring directories
checkDirs targetDirs # checks if directories exists
makeMirrorImage targetDirs # makes mirror images of targetDirs
