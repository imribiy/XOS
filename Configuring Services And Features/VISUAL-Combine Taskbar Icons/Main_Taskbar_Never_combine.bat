:: Created by: Shawn Brink
:: http://www.tenforums.com
:: Tutorial: http://www.tenforums.com/tutorials/25732-taskbar-buttons-always-sometimes-never-combine-windows-10-a.html


REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarGlomLevel /T REG_DWORD /D 2 /F

taskkill /f /im explorer.exe
start explorer.exe