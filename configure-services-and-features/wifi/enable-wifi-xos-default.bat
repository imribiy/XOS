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

sc config netprofm start=demand
sc config NlaSvc start=auto
sc config WlanSvc start=demand
sc config vwififlt start=system
sc config WlanSvc start=auto
sc config eventlog start=auto
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\WCM\WiFiTask" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\WlanSvc\CDSSync" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\WlanSvc\MoProfileManagement" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\WwanSvc\NotificationTask" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\WwanSvc\OobeDiscovery" >nul 2>&1
cls
echo WiFi enabled. Please reboot.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0