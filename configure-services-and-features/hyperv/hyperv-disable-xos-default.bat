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

echo Hyper-V disabled. Please reboot your system.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
