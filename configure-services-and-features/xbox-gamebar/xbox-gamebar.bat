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

echo.
echo ==========================================
echo   Toggle Xbox Game Bar (Windows 11)
echo ==========================================
echo.
echo   [E] Enable Xbox Game Bar
echo   [D] Disable Xbox Game Bar
echo.
echo   XOS Default is Disabled
echo.
echo.

choice /c ED /n /m "Press E to Enable or D to Disable: "

if errorlevel 2 (
cls
    echo Disabling Xbox Game Bar...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
    echo Xbox Game Bar disabled.
) else if errorlevel 1 (
cls
    echo Enabling Xbox Game Bar...
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f
    echo Xbox Game Bar enabled.
)

:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
