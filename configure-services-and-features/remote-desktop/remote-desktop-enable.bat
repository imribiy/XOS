@echo off
devmanview /enable "Remote Desktop Device Redirector Bus"
sc config termservice start=demand
sc config umrdpservice start=demand
sc config winrm start=demand
sc config rdpbus start=demand
sc config rdpdr start=demand
sc config rdpvideominiport start=demand
sc config terminpt start=demand
sc config tsusbflt start=demand
sc config tsusbgd start=demand
sc config tsusbhub start=demand
cls
echo Remote Desktop enabled. Please reboot.
pause