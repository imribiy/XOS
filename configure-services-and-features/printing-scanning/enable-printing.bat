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

sc config Spooler start=auto
sc config PrintWorkFlowUserSvc start=demand
sc config StiSvc start=demand
sc start Spooler
sc start PrintWorkFlowUserSvc
sc start StiSvc
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Printing\PrintJobCleanupTask" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Printing\PrinterCleanupTask" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Printing\EduPrintProv" >nul 2>&1
:: Enable Print and Document Services
dism /online /enable-feature /featurename:Printing-Foundation-Features
:: Enable Internet Printing Client
dism /online /enable-feature /featurename:Internet-Printing-Client
:: Enable LPD Print Service
dism /online /enable-feature /featurename:Printing-LPDPrintService
:: Enable LPR Port Monitor
dism /online /enable-feature /featurename:Printing-LPRPortMonitor
cls
echo Printing enabled. If it is still not working as intended, please reboot your system.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
