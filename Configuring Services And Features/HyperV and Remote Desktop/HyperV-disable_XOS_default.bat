@echo off
sc config vmickvpexchange start=disabled
sc config vmicguestinterface start=disabled
sc config vmicshutdown start=disabled
sc config vmicheartbeat start=disabled
sc config vmicvmsession start=disabled
sc config vmicrdv start=disabled
sc config vmictimesync start=disabled
sc config vmicvss start=disabled
sc config hyperkbd start=disabled
sc config hypervideo start=disabled
sc config gencounter start=disabled
sc config vmgid start=disabled
sc config storflt start=disabled
sc config bttflt start=disabled
sc config vpci start=disabled
sc config hvservice start=disabled
sc config hvcrash start=disabled
sc config HvHost start=disabled
devmanview /disable "Remote Desktop Device Redirector Bus"
cls
echo HyperV disabled. Please reboot.
pause