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
::   MAIN MENU
:: ==============================
:MENU
cls
echo ==========================================
echo      BLUETOOTH CONFIGURATION MANAGER
echo ==========================================
echo.
echo  [1] ENABLE Bluetooth (Services + Task)
echo  [2] DISABLE Bluetooth (Services + Task)
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ENABLE
if "%choice%"=="2" goto DISABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ENABLE BLUETOOTH
:: ==============================
:ENABLE
cls
echo Enabling Bluetooth Services...
echo.

:: Services from source [cite: 2]
sc config RFCOMM start= demand
sc config BthEnum start= demand
sc config bthleenum start= demand
sc config BTHMODEM start= demand
sc config BthA2dp start= demand
sc config microsoft_bluetooth_avrcptransport start= demand
sc config BthHFEnum start= demand
sc config BTAGService start= demand
sc config bthserv start= demand
sc config BluetoothUserService start= demand
sc config BthAvctpSvc start= demand
sc config BthMini start= demand
sc config BthPan start= demand
sc config BTHPORT start= demand
sc config BTHUSB start= demand
sc config HidBth start= demand

:: Enable Scheduled Task
echo Enabling Scheduled Task: UninstallDeviceTask...
schtasks /Change /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" /ENABLE

echo.
echo [OK] Bluetooth Enabled. Please reboot your system.
pause
goto MENU

:: ==============================
::   DISABLE BLUETOOTH
:: ==============================
:DISABLE
cls
echo Disabling Bluetooth Services...
echo.

:: Services from source [cite: 5]
sc config RFCOMM start= disabled
sc config BthEnum start= disabled
sc config bthleenum start= disabled
sc config BTHMODEM start= disabled
sc config BthA2dp start= disabled
sc config microsoft_bluetooth_avrcptransport start= disabled
sc config BthHFEnum start= disabled
sc config BTAGService start= disabled
sc config bthserv start= disabled
sc config BluetoothUserService start= disabled
sc config BthAvctpSvc start= disabled
sc config BthMini start= disabled
sc config BthPan start= disabled
sc config BTHPORT start= disabled
sc config BTHUSB start= disabled
sc config HidBth start= disabled

:: Disable Scheduled Task
echo Disabling Scheduled Task: UninstallDeviceTask...
schtasks /Change /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" /DISABLE

echo.
echo [OK] Bluetooth Disabled. Please reboot your system.
pause
goto MENU