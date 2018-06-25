#! /bin/bash

# Program to collect various system information collection methods in one place
# for easy running and exporting.

version="1.0"
date="Jun 22 2018"

case $1 in

    -h)
        echo "System Info v$version"
        echo ""
        echo "This script accesses a number of BASH commands to list system information.
Some of the commands require running the script with sudo priviledges.
They are marked with (S). Running those commands without sudo priviledges will
return incomplete information or will fail entirely.
Several of the programs are not installed by default. To get full use of the
script, it is recommended that you install the following packages:

apt install hwinfo
apt install inxi
apt install pydf
apt install lsscsi

If you select to run the entire package to be saved to a file, the file will 
be located on your desktop ~/Desktop/sys_info.txt"
        exit 0 ;;
    -v)
        echo "sys_info.sh version $version  $date"
        exit 0 ;;
esac

function main_menu {
clear
echo "System Information Script
=========================

Items marked with (S) require this script to be run as sudo
(Navigate to the directory containing the script and run with sudo ./sys_info.sh)

Items marked with (*) are not installed by default in Ubuntu
but are available in the repo (sudo apt install <name>)
Run script with -h for help or -v for version
It is recomended that this script be run with the terminal at full screen."
echo ""

echo "Enter the number of the command you would like to run:

1).......df - display free disk space. In human readable format with grand total.
2)..(*)..pydf - improved df, colorized disk space usage. Listed in powers of 1000
3).......pydf -h - same as above but listed in powers of 1024
4).......lscpu - display information about the CPU architecture.
5).......lspci - list all PI devices. Uses -v (verbose) flag
6)..(S)..lshw - list hardware. Uses -short flag for brevity.
7).......lsblk - list block devices, including UUID
8)..(*)..hwinfo - probe for hardware. Uses the --short flag for brevity
9)..(*)..lsscsi - lists SCSI devices, and their attributes
10).(*)..inxi - nice detailed system infomation. Uses -Fxim flags
11)......inxi -r - show distro repository data for this machine (for supported repos)
12)......free - display amount of free and used memory in human readable format
13).(S)..dmidecode -t processor - display detailed processor/CPU information
14).(S)..dmidecode -t memory - display detailed memory information
15).(S)..dmidecode -t bios - display detailed information about the BIOS
e) (S) export static details of system to file saved at ~/Desktop/system_details.txt
   File will include choices 4, 5, 6, 7, 8, 9, 10, 13, 14, 15
x) export current state of system to file saved at ~/Desktop/system_state.txt
   File will include choices 1 and 12 
q) quit"
echo ""

selection
}

function selection {
    read -p "Your selection: " choice

    while true; do
    case $choice in
        e) if [ -x "$(command -v inxi)" ]; then
               echo "" > ~/Desktop/system_details.txt
               echo "INXI - System information report" >>~/Desktop/system_details.txt
               echo "================================" >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
               inxi -Fxim >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
           else 
               echo "" >> ~/Desktop/system_details.txt
               echo "INXI Not Installed..." >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
           fi
           echo "LSCPU - CPU Architecture information" >> ~/Desktop/system_details.txt
           echo "====================================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           lscpu >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           echo "LSPCI - PCI Devices" >> ~/Desktop/system_details.txt
           echo "===================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           lspci -v >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           echo "LSHW - Hardware List" >> ~/Desktop/system_details.txt
           echo "====================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           lshw -short >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           echo "LSBLK - List of Block Devices" >> ~/Desktop/system_details.txt
           echo "=============================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           lsblk -o +UUID >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           if [ -x "$(command -v hwinfo)" ]; then
               echo "HWINFO - Hardware Probe" >> ~/Desktop/system_details.txt
               echo "=======================" >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
               hwinfo --short >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
           else
               echo "HWINFO Not Installed..." >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
           fi
           if [ -x "$(command lsscsi)" ]; then
               echo "LSSCSI - SCSI Device List" >> ~/Desktop/system_details.txt
               echo "=========================" >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
               lsscsi -s >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
           else
               echo "LSSCSI Not Installed..." >> ~/Desktop/system_details.txt
               echo "" >> ~/Desktop/system_details.txt
           fi
           echo "DMIDECODE - CPU Information" >> ~/Desktop/system_details.txt
           echo "===========================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           dmidecode -t processor >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           echo "DMIDECODE - Memory Information" >> ~/Desktop/system_details.txt
           echo "==============================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           dmidecode -t memory >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           echo "DMIDECODE - Bios Information" >> ~/Desktop/system_details.txt
           echo "============================" >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           dmidecode -t bios >> ~/Desktop/system_details.txt
           echo "" >> ~/Desktop/system_details.txt
           break ;;
           
            
        x) echo "" >> ~/Desktop/system_state.txt
           echo "DF - Disk Space Usage" > ~/Desktop/system_state.txt
           echo "=====================" >> ~/Desktop/system_state.txt
           echo "" >> ~/Desktop/system_state.txt
           df -h --total >> ~/Desktop/system_state.txt
           echo "" >> ~/Desktop/system_state.txt
           free -h >> ~/Desktop/system_state.txt 
           break;;
        
        1) echo 
           df -h --total
           echo
           break;;
        2) echo "" 
           pydf
           echo ""
           break ;;
        3) echo
           pydf -h
           echo
           break ;;
        4) echo
           lscpu
           echo
           break ;;
        5) echo
           lspci -v
           echo
           break ;;
        6) echo
           lshw -short
           echo
           break ;;
        7) echo
           lsblk -o +UUID
           echo
           break ;;
        8) echo
           hwinfo --short
           echo
           break ;;
        9) echo
           lsscsi -s
           echo
           break ;;
        10) echo
            inxi -Fxim
            echo
            break ;;
        11) echo
            inxi -r
            echo
            break ;;
        12) echo 
            free -h
            echo
            break ;;
        13) echo
            dmidecode -t processor
            echo
            break ;;
        14) echo
            dmidecode -t memory
            echo
            break ;;
        15) echo
            dmidecode -t bios
            echo
            break ;;
        q) echo
           echo "Goodbye..."
           echo
           exit 0 ;; 
    esac
    done
    again
}

function again {
    read -p "Would you like to run another command? (Y/N) " run_again
    case $run_again in
        [Yy]) main_menu ;;
        [Nn]) echo ""
              echo "Goodbye"
              echo ""
              exit 0 ;;
    esac
}
main_menu



 
