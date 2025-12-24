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
echo      CLIPBOARD HISTORY CONFIGURATION MANAGER
echo ==========================================
echo.
echo  [1] ENABLE Clipboard History
echo  [2] DISABLE Clipboard History
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ENABLE
if "%choice%"=="2" goto DISABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ENABLE Clipboard History
:: ==============================
:ENABLE
cls
echo Enabling Clipboard History Services...
echo.

sc config cbdhsvc start= auto


echo.
echo [OK] Clipboard History Enabled. Please reboot your system.
pause
goto MENU

:: ==============================
::   DISABLE Clipboard History
:: ==============================
:DISABLE
cls
echo Disabling Clipboard History Services...
echo.

sc config cbdhsvc start= disabled


echo.
echo [OK] Clipboard History Disabled. Please reboot your system.
pause
goto MENU