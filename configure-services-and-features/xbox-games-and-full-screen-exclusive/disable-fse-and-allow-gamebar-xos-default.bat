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

REM ;;CREDITS TO GGOS AND PHLEGM
Reg.exe delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "GamePanelStartupTipIndex" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\GameBar" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /f
Reg.exe delete "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe delete "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "0" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "1" /f
sc config xblauthmanager start=demand
sc config xblgamesave start=demand
sc config xboxgipsvc start=demand
sc config xboxnetapisvc start=demand
sc config gameinputsvc start=demand
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\XblGameSave\XblGameSaveTask" >nul 2>&1

:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0