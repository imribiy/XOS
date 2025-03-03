@echo off
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: This script is meant to work on XOS, using on other operating systems may not be successful.
:: XOS Discord Server: https://discord.gg/XTYEjZNPgX

sc config Spooler start=disabled
sc config PrintWorkFlowUserSvc start=disabled
sc config StiSvc start=disabled
sc stop Spooler
sc stop PrintWorkFlowUserSvc
sc stop StiSvc
powerrun "schtasks.exe" /change /disable /TN "\Microsoft\Windows\Printing\PrintJobCleanupTask" >nul 2>&1
powerrun "schtasks.exe" /change /disable /TN "\Microsoft\Windows\Printing\PrinterCleanupTask" >nul 2>&1
powerrun "schtasks.exe" /change /disable /TN "\Microsoft\Windows\Printing\EduPrintProv" >nul 2>&1
:: Disable Print and Document Services
dism /online /disable-feature /featurename:Printing-Foundation-Features
:: Disable Internet Printing Client
dism /online /disable-feature /featurename:Internet-Printing-Client
:: Disable LPD Print Service
dism /online /disable-feature /featurename:Printing-LPDPrintService
:: Disable LPR Port Monitor
dism /online /disable-feature /featurename:Printing-LPRPortMonitor
cls
echo Printing disabled. Please reboot
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
