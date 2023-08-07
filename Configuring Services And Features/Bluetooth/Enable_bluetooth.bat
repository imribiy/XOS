@echo off
sc config RFCOMM start=demand
sc config BthEnum start=demand
sc config bthleenum start=demand
sc config BTHMODEM start=demand
sc config BthA2dp start=demand
sc config microsoft_bluetooth_avrcptransport start=demand
sc config BthHFEnum start=demand
sc config BTAGService start=demand
sc config bthserv start=demand
sc config BluetoothUserService start=demand
sc config BthAvctpSvc start=demand
cls
echo Bluetooh enabled. Please reboot.
pause