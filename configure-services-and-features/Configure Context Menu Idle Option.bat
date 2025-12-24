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
echo    IDLE INDICATOR CONTEXT MENU MANAGER
echo ==========================================
echo.
echo  [1] ADD "Enable/Disable Idle" to Context Menu
echo  [2] REMOVE "Enable/Disable Idle" from Context Menu
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto ADD
if "%choice%"=="2" goto REMOVE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   ADD TO CONTEXT MENU
:: ==============================
:ADD
cls
echo Adding items to Right-Click Context Menu...
echo.

:: Add "Disable Idle" (05menu)
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v "MUIVerb" /t REG_SZ /d "Disable Idle" /f
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f

:: Add "Enable Idle" (06menu) 
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v "MUIVerb" /t REG_SZ /d "Enable Idle" /f
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v "Icon" /t REG_SZ /d "powercpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f

echo.
echo [OK] Context menu items added.
pause
goto MENU

:: ==============================
::   REMOVE FROM CONTEXT MENU
:: ==============================
:REMOVE
cls
echo Removing items from Right-Click Context Menu...
echo.

:: Deleting the keys created in the ADD section
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /f >nul 2>&1
Reg.exe delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /f >nul 2>&1

if %errorlevel% equ 0 (
    echo [OK] Context menu items removed.
) else (
    echo [!] Items not found or already removed.
)

pause
goto MENU