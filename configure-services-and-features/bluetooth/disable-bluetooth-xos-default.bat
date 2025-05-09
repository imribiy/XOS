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

sc config bluetoothuserservice start=disabled
sc config btagservice start=disabled
sc config bthserv start=disabled
sc config btha2dp start=disabled
sc config bthenum start=disabled
sc config bthhfenum start=disabled
sc config bthleenum start=disabled
sc config bthmini start=disabled
sc config bthmodem start=disabled
sc config bthport start=disabled
sc config bthusb start=disabled
sc config hidbth start=disabled
sc config microsoft_bluetooth_avrcptransport start=disabled
sc config rfcomm start=disabled
devmanview /disable "Generic Bluetooth Adapter"
powerrun "schtasks.exe" /change /disable /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" >nul 2>&1
cls
echo Bluetooh disabled. Please reboot.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
