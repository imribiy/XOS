@echo off
fsutil behavior set disableencryption 1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Policies" /v "NtfsDisableEncryption" /t REG_DWORD /d "1" /f
cls
echo NTFS Encryption disabled, please reboot.
pause