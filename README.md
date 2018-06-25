The system_info.sh is a shell script that brings access to a number of system information utilities together
in one location. 


Most of the utilities are available by default on Ubuntu and most other distros, but a few are not.

To get the full use of the script it is recommended to install the following utilities from the repo:

apt install inxi

apt install pydf

apt install hwinfo

apt install lsscsi


The lshw and dmidecode utilities require sudo priviledges so if those are desired then run the script 
with sudo.

