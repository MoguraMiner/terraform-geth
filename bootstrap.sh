#!/bin/bash
sudo mkfs -t ext4 /dev/xvdf
sudo mkdir -p /data
sudo mount /dev/xvdf /data

# Persist the volume in /etc/fstab so it gets mounted again
sudo sh -c echo "\"/dev/xvdf /data ext4 defaults,nofail 0 2\" >> /etc/fstab"
