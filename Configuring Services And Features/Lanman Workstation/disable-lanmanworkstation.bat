@echo off
sc config Bowser start=disabled
sc config rdbss start=disabled
sc config KSecPkg start=disabled
sc config mrxsmb20 start=disabled
sc config mrxsmb start=disabled
sc config LanmanWorkstation start=disabled
DISM /Online /Disable-Feature /FeatureName:SmbDirect /norestart
cls
echo Lanman Workstation Disabled. Please restart.
pause