@echo off
devmanview /disable "Remote Desktop Device Redirector Bus"
sc config termservice start=disabled
sc config umrdpservice start=disabled
sc config winrm start=disabled
sc config rdpbus start=disabled
sc config rdpdr start=disabled
sc config rdpvideominiport start=disabled
sc config terminpt start=disabled
sc config tsusbflt start=disabled
sc config tsusbgd start=disabled
sc config tsusbhub start=disabled
cls
echo Remote Desktop disabled. Please reboot.
pause