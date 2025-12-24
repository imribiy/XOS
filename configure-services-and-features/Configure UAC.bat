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
echo       UAC CONFIGURATION MANAGER
echo ==========================================
echo.
echo.
echo      If you don't want applications to run as administrator 
echo      automatically, enable UAC back.
echo.
echo  [1] ENABLE UAC (Default Security)
echo  [2] DISABLE UAC (Auto-Admin)
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ENABLE
if "%choice%"=="2" goto DISABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ENABLE UAC
:: ==============================
:ENABLE
cls
echo Enabling User Account Control (UAC)...
echo.

:: Registry commands from enable-uac.bat
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\luafv" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d "3" /f

echo.
echo [OK] UAC Enabled. Please reboot your system.
pause
goto MENU

:: ==============================
::   DISABLE UAC
:: ==============================
:DISABLE
cls
echo Disabling User Account Control (UAC)...
echo.

:: Registry commands from disable-uac.bat
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\luafv" /v "Start" /t REG_DWORD /d "4" /f

echo.
echo [OK] UAC Disabled. Please reboot your system.
pause
goto MENU