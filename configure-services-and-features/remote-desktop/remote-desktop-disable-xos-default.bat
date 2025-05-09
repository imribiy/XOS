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

devmanview /disable "Remote Desktop Device Redirector Bus"
sc config termservice start=disabled
sc config umrdpservice start=disabled
sc config winrm start=disabled
sc config rdpbus start=disabled
sc config rdpdr start=disabled
sc config rdpvideominiport start=disabled
sc config terminpt start=disabled
sc config tsusbflt start=disabled
sc config tsusbgd start=disabled
sc config tsusbhub start=disabled
sc config sessionenv start=disabled
devmanview /disable "Remote Desktop Device Redirector Bus"
cls
echo Remote Desktop disabled. Please reboot.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
