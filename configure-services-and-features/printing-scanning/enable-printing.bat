@echo off
sc config Spooler start=auto
sc config PrintWorkFlowUserSvc start=demand
sc config StiSvc start=demand
sc start Spooler
sc start PrintWorkFlowUserSvc
sc start StiSvc
cls
echo Printing enabled. If it is still not working as intended, please reboot your system.
pause