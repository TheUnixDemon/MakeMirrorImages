# Mirroring

This little project is about making a simple automated mirror image from a target *dir* to a wished destination *dir*. This will be made with **rsync**. 

It's not about making a incremental backup systems but only to sync a set of data to a wished location. So we have a backup from the current set of data. (If it's about making a incremental backup you could look after **borgbackup**.)

# How it works

This automation script is seperated into some Bash scripts. To start the process execute `main.sh` but before you have to define the directories for the mirroring wihin `main.sh`. Also exclusion directories can be defined in the `exclude.txt`.

## Detailed explaination

Here a short look into the scripts and other files located in the folder `./App`. 

* [`main.sh`](./App/main.sh)
    * defines the directories which will been mirrored
    * where `checkDir.sh` and `mirror.sh` will be loaded and executed
* [`checkDirs.sh`](./App/checkDirs.sh)
    * checks if the defined directories exists and if not it exits the process
* [`mirror.sh`](./App/mirror.sh)
    * makes a mirror image from `targetDir` to `destinationDir` with `rsync -av ...`
    * `exclude.txt`
        * *excluding directories* for mirroring process