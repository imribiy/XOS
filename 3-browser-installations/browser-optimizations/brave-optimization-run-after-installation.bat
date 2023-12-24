@echo off
net stop brave
sc delete brave
net stop bravem
sc delete bravem
taskkill /f /im BraveUpdate.exe
rmdir "C:\Program Files (x86)\BraveSoftware\Update" /s /q
pause