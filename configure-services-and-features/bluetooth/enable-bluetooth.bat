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

sc config bluetoothuserservice start=demand
sc config btagservice start=demand
sc config bthserv start=demand
sc config btha2dp start=demand
sc config bthenum start=demand
sc config bthhfenum start=demand
sc config bthleenum start=demand
sc config bthmini start=demand
sc config bthmodem start=demand
sc config bthport start=demand
sc config bthusb start=demand
sc config hidbth start=demand
sc config microsoft_bluetooth_avrcptransport start=demand
sc config rfcomm start=demand
devmanview /enable "Generic Bluetooth Adapter"
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" >nul 2>&1
cls
echo Bluetooh enabled. Please reboot.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
