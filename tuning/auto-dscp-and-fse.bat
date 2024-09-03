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

echo "Compiled and improved by imribiy, codes taken from AtlasOS and EVA"
echo.
echo.
echo "Please select the game you play."

for /f "tokens=* delims=\" %%i in ('C:\Windows\filepicker.exe exe') do (
    if "%%i"=="cancelled by user" exit
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Application Name" /t REG_SZ /d "%%~ni%%~xi" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Version" /t REG_SZ /d "1.0" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Protocol" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Local Port" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Local IP" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Local IP Prefix Length" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Remote Port" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Remote IP" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Remote IP Prefix Length" /t REG_SZ /d "*" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "DSCP Value" /t REG_SZ /d "46" /f
    reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\QoS\%%~ni%%~xi" /v "Throttle Rate" /t REG_SZ /d "-1" /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%%i" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE HIGHDPIAWARE" /f
    powershell New-NetQosPolicy -Name "%%~ni%%~xi" -AppPathNameMatchCondition "%%~ni%%~xi" -Precedence 127 -DSCPAction 46 -IPProtocol Both
)
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
