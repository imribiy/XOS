@echo off
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: This script is meant to work on XOS, using on other operating systems may not be successful.
:: XOS Discord Server: https://discord.gg/XTYEjZNPgX

PowerRun.exe /SW:0 Reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures" /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f
PowerRun.exe /SW:0 Reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "ConfigureSystemGuardLaunch" /f
PowerRun.exe /SW:0 Reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "ConfigureKernelShadowStacksLaunch" /f
PowerRun.exe /SW:0 Reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "HypervisorEnforcedCodeIntegrity" /f
PowerRun.exe /SW:0 Reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "LsaCfgFlags" /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\System\ControlSet001\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\System\ControlSet001\Control\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d "0" /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\System\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\System\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\System\ControlSet001\Control\Lsa" /v "LsaCfgFlags" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\System\ControlSet001\Services\bttflt" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\gencounter" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\hvservice" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\hyperkbd" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\HyperVideo" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\storflt" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\Vid" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmbus" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmgid" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\System\ControlSet001\Services\vpci" /v "Start" /t REG_DWORD /d "4" /f
devmanview /disable "Microsoft Hyper-V Virtualization Infrastructure Driver"
bcdedit /set hypervisorlaunchtype off
cls
echo Defender enabled. Please reboot your system.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
