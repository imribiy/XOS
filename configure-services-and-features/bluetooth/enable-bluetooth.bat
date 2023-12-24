@echo off
sc config bluetoothuserservice start=demand
sc config btagservice start=demand
sc config bthserv start=demand
sc config btha2dp start=demand
sc config bthenum start=demand
sc config bthhfenum start=demand
sc config bthleenum start=demand
sc config bthmini start=demand
sc config bthmodem start=demand
sc config bthport start=demand
sc config bthusb start=demand
sc config hidbth start=demand
sc config microsoft_bluetooth_avrcptransport start=demand
sc config rfcomm start=demand
devmanview /enable "Generic Bluetooth Adapter"
powerrun "schtasks.exe" /change /enable /TN "\Microsoft\Windows\Bluetooth\UninstallDeviceTask" >nul 2>&1
cls
echo Bluetooh enabled. Please reboot.
pause