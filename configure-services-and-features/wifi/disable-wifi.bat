@echo off
sc config WlanSvc start=disabled
sc config vwififlt start=disabled
cls
echo WiFi disabled. Please reboot.
pause