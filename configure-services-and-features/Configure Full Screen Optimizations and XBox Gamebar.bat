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
echo       GAME MODE ^& FSE MANAGER
echo ==========================================
echo.
echo  There is NO best when the topic comes to FSE/FSO.
echo  Some games runs better with FSO while some works better on FSE.
echo  Please do your own testing.
echo.
echo.
echo   --- COMBINED SETTINGS ---
echo  [1] OPTIMIZE: Enable FSE ^& Disable Game Bar
echo      (Disables FSO, Forces FSE, Disables Overlay)
echo.
echo  [2] RESTORE: Enable Game Bar ^& Restore FSO
echo      (Restores Default Windows Behavior)
echo.
echo   --- GAME BAR ONLY (FSO/FSE UNTOUCHED) ---
echo  [3] DISABLE Game Bar Only
echo      (Keeps your current FSO/FSE settings)
echo.
echo  [4] ENABLE Game Bar Only
echo      (Keeps your current FSO/FSE settings)
echo.
echo  [5] Exit
echo.
set /p "choice=Select an option (1-5): "

if "%choice%"=="1" goto OPTIMIZE
if "%choice%"=="2" goto RESTORE
if "%choice%"=="3" goto DISABLE_BAR_ONLY
if "%choice%"=="4" goto ENABLE_BAR_ONLY
if "%choice%"=="5" exit
goto MENU

:: ==============================
::   [1] OPTIMIZE (Enable FSE / Disable Game Bar)
:: ==============================
:OPTIMIZE
cls
echo Applying Gaming Optimizations (FSE ON, GameBar OFF)...
echo.

:: --- HKCU GameBar Settings ---
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "GamePanelStartupTipIndex" /t REG_DWORD /d "3" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f

:: --- HKCU GameDVR Settings ---
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f

:: --- HKCU GameConfigStore (FSE/FSO) ---
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "2" /f

:: --- HKLM Policies ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f

echo.
echo [OK] FSE Enabled and Game Bar Disabled.
pause
goto MENU

:: ==============================
::   [2] RESTORE (Enable Game Bar / Default)
:: ==============================
:RESTORE
cls
echo Restoring Windows Defaults (GameBar ON, FSE Default)...
echo.

:: --- HKCU GameBar Settings ---
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "GamePanelStartupTipIndex" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /f >nul 2>&1

:: --- HKCU GameDVR Settings ---
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f >nul 2>&1

:: --- HKCU GameConfigStore (FSE/FSO) ---
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "0" /f

:: --- HKLM Policies ---
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "1" /f

echo.
echo [OK] Windows Default Settings Restored.
pause
goto MENU

:: ==============================
::   [3] DISABLE GAME BAR ONLY
:: ==============================
:DISABLE_BAR_ONLY
cls
echo Disabling Game Bar (Preserving FSE/FSO State)...
echo.

:: --- HKCU GameBar Settings ---
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f

:: --- HKCU GameDVR Settings ---
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f

:: --- HKLM Policies ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f

echo.
echo [OK] Game Bar Disabled. FSE/FSO settings were not touched.
pause
goto MENU

:: ==============================
::   [4] ENABLE GAME BAR ONLY
:: ==============================
:ENABLE_BAR_ONLY
cls
echo Enabling Game Bar (Preserving FSE/FSO State)...
echo.

:: --- HKCU GameBar Settings ---
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /f >nul 2>&1

:: --- HKCU GameDVR Settings ---
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "1" /f

:: --- HKLM Policies ---
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "1" /f

echo.
echo [OK] Game Bar Enabled. FSE/FSO settings were not touched.
pause
goto MENU