@echo off
powershell Disable-TpmAutoProvisioning
sc config tpm start=disabled
devmanview /disable "AMD PSP 10.0 Device"
devmanview /disable "Trusted Platform Module 2.0"
cls
echo TPM disabled. Please reboot.
pause