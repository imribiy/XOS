@echo off
sc config Bowser start=demand
sc config rdbss start=demand
sc config KSecPkg start=boot
sc config mrxsmb20 start=demand
sc config mrxsmb start=demand
sc config srv2 start=demand
sc config LanmanWorkstation start=auto
DISM /Online /Enable-Feature /FeatureName:SmbDirect /norestart
cls
echo Lanman Workstation Enabled. Please restart.
pause