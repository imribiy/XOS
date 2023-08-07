@echo off
sc config Spooler start=disabled
sc config PrintWorkFlowUserSvc start=disabled
sc config StiSvc start=disabled
sc stop Spooler
sc stop PrintWorkFlowUserSvc
sc stop StiSvc
cls
echo Printing disabled.
pause