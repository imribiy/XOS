@echo off
title Runtime Broker Disabler, made by imribiy#0001

echo.	DISABLING RUNTIMEBROKER WILL BREAK TASKBAR FUNCTIONALITY, NETWORK SETTINGS AND SIMILAR UWP FUNCTIONS
echo.	IF YOU NEED THEM, ENABLE RUNTIMEBROKER BACK
echo.
echo.	Press [D] to Disable Runtimebroker
echo.	Press [E] to Enable Runtimebroker
echo.
set /p c="What is your choice? "
if /i %c% equ D goto :disable
if /i %c% equ E goto :enable

:disable
taskkill /f /im explorer.exe
taskkill /f /im runtimebroker.exe
cd C:\Windows\System32
takeown /f "runtimebroker.exe"
icacls "C:\Windows\System32\RuntimeBroker.exe" /grant Administrators:F
ren runtimebroker.exe runtimebroker.old
start explorer.exe
pause
exit

:enable
taskkill /f /im explorer.exe
cd C:\Windows\System32
takeown /f "runtimebroker.old"
icacls "C:\Windows\System32\RuntimeBroker.old" /grant Administrators:F
ren runtimebroker.old runtimebroker.exe
start explorer.exe
start runtimebroker.exe
pause
exit