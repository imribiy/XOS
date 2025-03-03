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

sc config PptpMiniport start=demand >nul 2>&1
sc config RasAgileVpn start=demand >nul 2>&1
sc config Rasl2tp start=demand >nul 2>&1
sc config RasSstp start=demand >nul 2>&1
sc config RasPppoe start=demand >nul 2>&1
sc config RasMan start=auto >nul 2>&1
sc config SstpSvc start=demand >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Ras\MobilityManager" >nul 2>&1
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0