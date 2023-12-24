@echo off
title "Auto DSCP & FSE Utility"
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
pause
goto finish