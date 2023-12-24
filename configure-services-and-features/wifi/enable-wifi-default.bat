@echo off
sc config netprofm start=demand
sc config NlaSvc start=auto
sc config WlanSvc start=demand
sc config vwififlt start=system
sc config WlanSvc start=auto
sc config eventlog start=auto
cls
echo WiFi enabled. Please reboot.
pause