@echo off
if /i "%~1"=="/disable"         goto disable

title Write-Cache Buffer Flushing Toggle Script
cls

echo.	Press [D] to disable Write-Cache Buffer Flushing
echo.	Press [E] to enable Write-Cache Buffer Flushing
echo.
echo. If you have regular power shortages in your area please leave this setting enabled.
echo. Disabling this setting will cause data loss during power shortages.
echo.
set /p c="Enter your answer: "
if /i %c% equ D goto :disable
if /i %c% equ E goto :enable

:disable
echo "Disabling Write-Cache Buffer Flushing on Disks"
for /f "Delims=" %%k in ('Reg.exe Query hklm\SYSTEM\CurrentControlSet\Enum /f "{4d36e967-e325-11ce-bfc1-08002be10318}" /d /s^|Find "HKEY"') do (
  Reg.exe add "%%k\Device Parameters\Disk" /v UserWriteCacheSetting /t reg_dword /d 1 /f
  Reg.exe add "%%k\Device Parameters\Disk" /v CacheIsPowerProtected /t reg_dword /d 1 /f
)
pause
exit

:enable
echo "Enabling Write-Cache Buffer Flushing on Disks"
for /f "Delims=" %%k in ('Reg.exe Query hklm\SYSTEM\CurrentControlSet\Enum /f "{4d36e967-e325-11ce-bfc1-08002be10318}" /d /s^|Find "HKEY"') do (
  Reg.exe delete "%%k\Device Parameters\Disk" /v UserWriteCacheSetting /f
  Reg.exe delete "%%k\Device Parameters\Disk" /v CacheIsPowerProtected /f
)
pause
exit