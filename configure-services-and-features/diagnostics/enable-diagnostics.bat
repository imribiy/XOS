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

PowerRun.exe /SW:0 "Reg.exe" add "HKLM\System\ControlSet001\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "3" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\System\ControlSet001\Services\diagsvc" /v "Start" /t REG_DWORD /d "3" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\System\ControlSet001\Services\DPS" /v "Start" /t REG_DWORD /d "2" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\System\ControlSet001\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "3" /f
PowerRun.exe /SW:0 "Reg.exe" add "HKLM\System\ControlSet001\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "3" /f
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Diagnosis\Scheduled" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\DiskFootprint\Diagnostics" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Management\Provisioning\MdmDiagnosticsCleanup" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\WDI\ResolutionHost" >nul 2>&1
cls
echo Diagnostics enabled. Please reboot your system.
:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
