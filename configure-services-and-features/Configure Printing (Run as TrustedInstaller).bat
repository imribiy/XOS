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
echo        PRINTING CONFIGURATION MANAGER
echo ==========================================
echo.
echo  [1] ENABLE Printing
echo      (Services, Scheduled Tasks, Windows Features)
echo.
echo  [2] DISABLE Printing
echo      (Services, Scheduled Tasks, Windows Features)
echo.
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ENABLE
if "%choice%"=="2" goto DISABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ENABLE PRINTING
:: ==============================
:ENABLE
cls
echo Enabling Printing Services...
echo.

:: Services (from Enable_printing.bat)
sc config Spooler start= auto
sc config PrintWorkFlowUserSvc start= demand
sc config StiSvc start= demand
sc start Spooler
sc start PrintWorkFlowUserSvc
sc start StiSvc

echo.
echo Enabling Scheduled Tasks...
:: Scheduled Tasks
schtasks /Change /TN "\Microsoft\Windows\Printing\EduPrintProv" /ENABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\PrinterCleanupTask" /ENABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\PrintJobCleanupTask" /ENABLE >nul 2>&1

echo.
echo Enabling Windows Features (DISM)...
:: DISM Features
dism /Online /Enable-Feature /FeatureName:Printing-Foundation-Features /NoRestart
dism /Online /Enable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client /NoRestart
dism /Online /Enable-Feature /FeatureName:Printing-Foundation-LPDPrintService /NoRestart
dism /Online /Enable-Feature /FeatureName:Printing-Foundation-LPRPortMonitor /NoRestart
dism /Online /Enable-Feature /FeatureName:Printing-PrintToPDFServices-Features /NoRestart
dism /Online /Enable-Feature /FeatureName:Printing-XPSServices-Features /NoRestart

echo.
echo [OK] Printing Enabled.
echo Please reboot your system to finalize feature changes.
pause
goto MENU

:: ==============================
::   DISABLE PRINTING
:: ==============================
:DISABLE
cls
echo Disabling Printing Services...
echo.

:: Services (from Disable_printing.bat)
sc config Spooler start= disabled
sc config PrintWorkFlowUserSvc start= disabled
sc config StiSvc start= disabled
sc stop Spooler
sc stop PrintWorkFlowUserSvc
sc stop StiSvc

echo.
echo Disabling Scheduled Tasks...
:: Scheduled Tasks
schtasks /Change /TN "\Microsoft\Windows\Printing\EduPrintProv" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\PrinterCleanupTask" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Printing\PrintJobCleanupTask" /DISABLE >nul 2>&1

echo.
echo Disabling Windows Features (DISM)...
:: DISM Features
dism /Online /Disable-Feature /FeatureName:Printing-Foundation-Features /NoRestart
dism /Online /Disable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client /NoRestart
dism /Online /Disable-Feature /FeatureName:Printing-Foundation-LPDPrintService /NoRestart
dism /Online /Disable-Feature /FeatureName:Printing-Foundation-LPRPortMonitor /NoRestart
dism /Online /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features /NoRestart
dism /Online /Disable-Feature /FeatureName:Printing-XPSServices-Features /NoRestart

echo.
echo [OK] Printing Disabled.
echo Please reboot your system to finalize feature changes.
pause
goto MENU