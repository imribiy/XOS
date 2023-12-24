@echo off
powershell Enable-TpmAutoProvisioning
sc config tpm start=demand
devmanview /enable "AMD PSP 10.0 Device"
devmanview /enable "Trusted Platform Module 2.0"
cls
echo TPM enabled. Please reboot.
pause