@echo off
net stop gupdate
sc delete gupdate
net stop googlechromeelevationservice
sc delete googlechromeelevationservice
net stop gupdatem
sc delete gupdatem
taskkill /f /im GoogleUpdate.exe 
rmdir "C:\Program Files (x86)\Google\Update" /s /q
cd /d "C:\Program Files\Google\Chrome\Application\"
dir chrmstp.exe /a /b /s
del chrmstp.exe /a /s
pause