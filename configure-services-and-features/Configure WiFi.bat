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
echo         WI-FI CONFIGURATION MANAGER
echo ==========================================
echo.
echo  [1] ENABLE Wi-Fi Services
echo  [2] DISABLE Wi-Fi Services
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ENABLE
if "%choice%"=="2" goto DISABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ENABLE WI-FI
:: ==============================
:ENABLE
cls
echo Enabling Wi-Fi Services...
echo.

sc config netprofm start= demand
sc config NlaSvc start= auto
sc config WlanSvc start= demand
sc config vwififlt start= system
sc config WlanSvc start= auto
sc config eventlog start= auto

echo.
echo [OK] WiFi enabled
echo Please reboot your system
pause
goto MENU

:: ==============================
::   DISABLE WI-FI
:: ==============================
:DISABLE
cls
echo Disabling Wi-Fi Services...
echo.

sc config WlanSvc start= disabled
sc config vwififlt start= disabled

echo.
echo [OK] WiFi disabled
echo Please reboot your system
pause
goto MENU