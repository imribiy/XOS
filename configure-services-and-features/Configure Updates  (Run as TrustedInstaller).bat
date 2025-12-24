@echo off
:: Check Admin
fsutil dirty query %systemdrive% >nul 2>&1 || (powershell -c "Start-Process -Verb RunAs '%~f0'" & exit /b)

:MENU
cls & echo 1. Hard Disable (No Store, No Drivers, No Metadata) & echo 2. Moderate (Manual Updates, No Drivers) & echo 3. Enable All & echo 4. Manage Drivers ^& Devices Only
choice /c 1234 /m "Select"
set "opt=%errorlevel%"

set "PolWU=HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
set "PolDr=HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching"
set "SysDr=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"
set "Meta=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"
set "Svcs=wuauserv bits dosvc UsoSvc WaaSMedicSvc"
set "Tasks="\Microsoft\Windows\WindowsUpdate\Scheduled Start" "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" "\Microsoft\Windows\WaaSMedic\PerformRemediation""

if %opt%==1 (
    for %%s in (%Svcs%) do sc stop %%s >nul & sc config %%s start= disabled >nul
    for %%t in (%Tasks%) do schtasks /Change /TN %%t /DISABLE >nul 2>&1
    reg add "%PolWU%" /v DoNotConnectToWindowsUpdateInternetLocations /t REG_DWORD /d 1 /f >nul
    reg add "%PolWU%" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul
    reg add "%PolWU%\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
    reg add "%PolWU%" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul
    reg add "%PolDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
    reg add "%SysDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
    reg add "%Meta%" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
)

if %opt%==2 (
    for %%s in (%Svcs%) do sc config %%s start= demand >nul & sc start %%s >nul
    for %%t in (%Tasks%) do schtasks /Change /TN %%t /ENABLE >nul 2>&1
    reg delete "%PolWU%" /v DoNotConnectToWindowsUpdateInternetLocations /f >nul 2>&1
    reg delete "%PolWU%" /v DisableWindowsUpdateAccess /f >nul 2>&1
    reg add "%PolWU%\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
    reg add "%PolWU%" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul
    reg add "%PolDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
)

if %opt%==3 (
    for %%s in (%Svcs%) do sc config %%s start= auto >nul & sc start %%s >nul
    for %%t in (%Tasks%) do schtasks /Change /TN %%t /ENABLE >nul 2>&1
    reg delete "%PolWU%" /f >nul 2>&1
    reg delete "%PolDr%" /f >nul 2>&1
    reg add "%SysDr%" /v SearchOrderConfig /t REG_DWORD /d 1 /f >nul
    reg delete "%Meta%" /v PreventDeviceMetadataFromNetwork /f >nul 2>&1
)

if %opt%==4 (
    cls & echo 1. Block Drivers ^& Metadata & echo 2. Allow Drivers ^& Metadata
    choice /c 12 /m "Select"
    if errorlevel 2 (
        reg delete "%PolWU%" /v ExcludeWUDriversInQualityUpdate /f >nul 2>&1
        reg delete "%PolDr%" /f >nul 2>&1
        reg add "%SysDr%" /v SearchOrderConfig /t REG_DWORD /d 1 /f >nul
        reg delete "%Meta%" /v PreventDeviceMetadataFromNetwork /f >nul 2>&1
    ) else (
        reg add "%PolWU%" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul
        reg add "%PolDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
        reg add "%SysDr%" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
        reg add "%Meta%" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul
    )
)
exit /b