@echo off
fsutil behavior set disableencryption 0
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Policies" /v "NtfsDisableEncryption" /f
cls
echo NTFS Encryption enabled, please reboot.
pause