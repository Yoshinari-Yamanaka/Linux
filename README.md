# How to set up Windows Subsystem for Linux 2 (WSL2)

Properties

```
Windows 10 Home
Enabled WSL2
Ubuntu20.04
```

## Setup Windows Subsystem for Linux

**All references shown bellow**. Check it at first
https://docs.microsoft.com/en-us/windows/wsl/install-win10


1. Enable Windows Subsystem for Linux

    Control Panel > Programs > Programs and Features > Turn Windows features on or off > Check the box Windows Subsystem for Linux

2. Install Ubuntu from Microsoft Store . Check the version

3. Register Windows Insider Preview

4. Install Windows10 Insider Preview Build

    Settings > Update & Security > Windows Insider Program

5. WSL1 -> WSL2

    5-1. check the WSL version
    
        wsl -l -v

    5-2. Run PowerShell as Administrator, and input the following command
        
        wsl --set-version Ubuntu 2

    5-3. one more check it out
        
        wsl -l -v


    Tips.
    When you upgrade Windows Insider Preview Build and get the following error.
    you can download and install the Linux kernel update package from Microsoft.

    https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel



## Setup your own environment 

1. run setup.sh
Each Libraries and Programming Languages would be installed.

## 2. Do git.md
Do the things written in git.md

## 3. Do aws.md
Do the things written in aws.md