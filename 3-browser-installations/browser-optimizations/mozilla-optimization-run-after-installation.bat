@echo off
taskkill /f /im maintenanceservice.exe
taskkill /f /im uninstall.exe
net stop MozillaMaintenance
sc delete MozillaMaintenance
rmdir "C:\Program Files (x86)\Mozilla Maintenance Service" /s /q
del /f "C:\Program Files\Mozilla Firefox\maintenanceservice_installer.exe"
del /f "C:\Program Files\Mozilla Firefox\maintenanceservice.exe"
del /f "C:\Program Files\Mozilla Firefox\updater.exe"
pause