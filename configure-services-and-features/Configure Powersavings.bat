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
echo       POWER SAVINGS MANAGER
echo ==========================================
echo.
echo  [1] DISABLE Power Savings (Performance)
echo      * NOT recommended for laptops (Risk of overheating)
echo.
echo  [2] ENABLE Power Savings (Default/Laptop)
echo      * Recommended for battery life and thermals
echo.
echo  [3] Exit
echo.
set /p "choice=Select an option (1-3): "

if "%choice%"=="1" goto DISABLE_WARNING
if "%choice%"=="2" goto ENABLE
if "%choice%"=="3" exit
goto MENU

:: ==============================
::   WARNING CHECK
:: ==============================
:DISABLE_WARNING
cls
color 0E
echo ========================================================
echo                 !!! WARNING !!!
echo ========================================================
echo.
echo  You are about to DISABLE power savings.
echo.
echo  [!] NOT RECOMMENDED FOR LAPTOPS.
echo  [!] Disabling these features on a laptop will cause:
echo      - Increased heat generation
echo      - THERMAL THROTTLING (Loss of performance)
echo      - Reduced battery life
echo.
echo ========================================================
set /p "confirm=Are you sure you want to proceed? (Y/N): "
color 07
if /I "%confirm%"=="Y" goto DISABLE_LOGIC
goto MENU

:: ==============================
::   DISABLE POWER SAVINGS
:: ==============================
:DISABLE_LOGIC
cls
echo Disabling Power Savings (Performance Mode)...
echo.

for %%a in (
    EnhancedPowerManagementEnabled
    AllowIdleIrpInD3
    EnableSelectiveSuspend
    DeviceSelectiveSuspended
    SelectiveSuspendEnabled
    SelectiveSuspendOn
    WaitWakeEnabled
    D3ColdSupported
    WdfDirectedPowerTransitionEnable
    EnableIdlePowerManagement
    IdleInWorkingState
    WakeEnabled
) do for /f "delims=" %%b in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do Reg.exe add "%%b" /v "%%a" /t REG_DWORD /d "0" /f >nul 2>&1

powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableLPM" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "Ceip" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableSelectiveSuspendUI" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "D3ColdSupport" /t REG_DWORD /d "0" /f

wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1

Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Power Savings DISABLED.
pause
goto MENU

:: ==============================
::   ENABLE POWER SAVINGS
:: ==============================
:ENABLE
cls
echo Enabling Power Savings (Default Mode)...
echo.

for %%a in (
    EnhancedPowerManagementEnabled
    AllowIdleIrpInD3
    EnableSelectiveSuspend
    DeviceSelectiveSuspended
    SelectiveSuspendEnabled
    SelectiveSuspendOn
    WaitWakeEnabled
    D3ColdSupported
    WdfDirectedPowerTransitionEnable
    EnableIdlePowerManagement
    IdleInWorkingState
    WakeEnabled
) do for /f "delims=" %%b in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do Reg.exe add "%%b" /v "%%a" /t REG_DWORD /d "1" /f >nul 2>&1

powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1

Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableLPM" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "D3ColdSupported" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "Ceip" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "DisableSelectiveSuspendUI" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v "D3ColdSupported" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "D3ColdSupported" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "D3ColdSupport" /f

wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:true >nul 2>&1

Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Power Savings ENABLED.
pause
goto MENU