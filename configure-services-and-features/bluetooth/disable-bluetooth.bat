@echo off
sc config bluetoothuserservice start=disabled
sc config btagservice start=disabled
sc config bthserv start=disabled
sc config btha2dp start=disabled
sc config bthenum start=disabled
sc config bthhfenum start=disabled
sc config bthleenum start=disabled
sc config bthmini start=disabled
sc config bthmodem start=disabled
sc config bthport start=disabled
sc config bthusb start=disabled
sc config hidbth start=disabled
sc config microsoft_bluetooth_avrcptransport start=disabled
sc config rfcomm start=disabled
devmanview /disable "Generic Bluetooth Adapter"
powerrun "schtasks.exe" /change /disable /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" >nul 2>&1
cls
echo Bluetooh disabled. Please reboot.
pause