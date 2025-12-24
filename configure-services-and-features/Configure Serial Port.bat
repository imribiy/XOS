@echo off
setlocal EnableDelayedExpansion

:: ==============================
::   AUTO-ADMIN / UAC ELEVATION
:: ==============================
:: Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting Administrator privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

:: ==============================
::   CONFIGURATION
:: ==============================
:: List of devices to target
set "DEVICES="Communications Port (COM1)" "Communications Port (COM2)" "Communications Port (SER1)" "Communications Port (SER2)""

:: ==============================
::   MAIN MENU
:: ==============================
:MENU
cls
echo ==========================================
echo       SERIAL PORT CONFIGURATION
echo ==========================================
echo.
echo  [1] ENABLE Serial Ports
echo.
echo  [2] DISABLE Serial Ports
echo      * WARNING: Most laptop touchpads connect via Serial Port.
echo        Disabling this may cause your touchpad to stop working.
echo.
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ENABLE
if "%choice%"=="2" goto DISABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ENABLE LOGIC
:: ==============================
:ENABLE
cls
echo Enabling Serial Ports...
echo.

for %%D in (%DEVICES%) do (
    call :EnableDevice "%%~D"
)

echo.
echo [OK] Serial Ports Enabled.
pause
goto MENU

:: ==============================
::   DISABLE LOGIC
:: ==============================
:DISABLE
cls
echo Disabling Serial Ports...
echo.

for %%D in (%DEVICES%) do (
    call :DisableDevice "%%~D"
)

echo.
echo [OK] Serial Ports Disabled.
pause
goto MENU

:: ==============================
::   SUBROUTINES
:: ==============================

:EnableDevice
set "DEV_NAME=%~1"
:: PowerShell command to Enable PnP Device
powershell -NoProfile -Command "$obj = Get-PnpDevice -FriendlyName '%DEV_NAME%' -ErrorAction Ignore; if ($obj) { Write-Host 'Enabling: %DEV_NAME%'; $obj | Enable-PnpDevice -Confirm:$false } else { Write-Host 'Not Found: %DEV_NAME%' }"
goto :eof

:DisableDevice
set "DEV_NAME=%~1"
:: PowerShell command to Disable PnP Device
powershell -NoProfile -Command "$obj = Get-PnpDevice -FriendlyName '%DEV_NAME%' -ErrorAction Ignore; if ($obj) { Write-Host 'Disabling: %DEV_NAME%'; $obj | Disable-PnpDevice -Confirm:$false } else { Write-Host 'Not Found: %DEV_NAME%' }"
goto :eof