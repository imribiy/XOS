@echo off

:: Created by: Shawn Brink
:: http://www.tenforums.com/
:: Tutorial: http://www.tenforums.com/tutorials/5313-notification-area-icons-hide-show-windows-10-a.html


REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F

:: To kill and restart explorer
taskkill /f /im explorer.exe
start explorer.exe