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

# Deploy as a Service

After testing the Bash script can be implemented with `Systemd` using a *Daemon* (Service) to do that. Also it is helpful and more efficient to use a timer implemented as a `*.timer` file. I created for that a template for the Daemon and the Timer. Both have to be the same basename (here `mirroring`). So the Timer and the Daemon only differ in the suffix and both have to be saved in `/etc/systemd/system/`.

## Template

* [`mirroring.service` - Daemon](./Service/mirroring.service)
* [`mirroring.timer` - Timer](./Service/mirroring.timer)

## Step by step deployment

Moving the templates into the right folder for enabling the Timer.

```bash
#!/bin/bash
sudo su
mv Service/mirroring.* /etc/systemd/system
systemctl daemon-reload
systemctl enable --now mirroring.timer # for starting *mirroring.service* through that
```

After that check if the Daemon is set using Timer as initializer abd the Timer for the Daemon is enabled and set to the wished time. Here an example how it can look like if set up right.

```bash
#!/bin/bash
$ systemctl status mirroring.service
○ mirroring.service - creates with *rsync* mirroring backups
     Loaded: loaded (/etc/systemd/system/mirroring.service; static)
     Active: inactive (dead)
TriggeredBy: ● mirroring.timer

$ systemctl status mirroring.timer
● mirroring.timer - weeky mirror backup sync
     Loaded: loaded (/etc/systemd/system/mirroring.timer; enabled; preset: enabled)
     Active: active (waiting) since Tue 2025-05-13 00:24:46 CEST; 6min ago
    Trigger: Sun 2025-05-18 05:00:00 CEST; 5 days left
   Triggers: ● mirroring.service
```

Now you can make a test run through the Daemon itself to check if it will work out as wished. You can check out the `*.log` files if you want to follow up with the progress of the Daemon.

```bash
sudo systemctl start mirroring.service
```