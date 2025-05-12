#!/bin/bash

# changing into script folder & loading bash scripts
cd "$(dirname "${BASH_SOURCE[0]}")"
source ./checkDirs.sh

# declaring (-A) dict for target directory to save
declare -A targetDirs=(
    ["/mnt/dr0/nas"]="/mnt/dr1/nasBackup"
)

# checking if wished directories can be found
checkDirs targetDirs

