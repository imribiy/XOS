@echo off
title Enable Virtualization Based Security (VBS)

:: =========================================================
:: Check for Administrator privileges
:: =========================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo [!] Administrator privileges required.
    echo     Right-click this script and select "Run as administrator".
    echo.
    pause
    exit /b
)

:: =========================================================
:: Enable VBS and related features
:: =========================================================
echo Enabling Virtualization-Based Security (VBS) settings...

Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "LsaCfgFlags" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "HypervisorEnforcedCodeIntegrity" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "ConfigureSystemGuardLaunch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "ConfigureKernelShadowStacksLaunch" /t REG_DWORD /d "1" /f

:: =========================================================
:: Enable Hypervisor-Enforced Code Integrity (HVCI)
:: =========================================================
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f

:: =========================================================
:: Enable System Guard Secure Launch
:: =========================================================
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard" /v "Enabled" /t REG_DWORD /d "1" /f

:: =========================================================
:: Enable Hypervisor at Boot
:: =========================================================
bcdedit /set hypervisorlaunchtype auto

:: =========================================================
:: Done
:: =========================================================
echo.
echo Changes applied successfully.
echo Restart your computer for VBS to take effect.
echo After reboot, verify under:
echo    Windows Security > Device security > Core isolation
echo.
pause
