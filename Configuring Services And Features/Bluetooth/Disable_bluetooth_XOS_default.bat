@echo off
sc config RFCOMM start=disabled
sc config BthEnum start=disabled
sc config bthleenum start=disabled
sc config BTHMODEM start=disabled
sc config BthA2dp start=disabled
sc config microsoft_bluetooth_avrcptransport start=disabled
sc config BthHFEnum start=disabled
sc config BTAGService start=disabled
sc config bthserv start=disabled
sc config BluetoothUserService start=disabled
sc config BthAvctpSvc start=disabled
cls
echo Bluetooh disabled. Please reboot.
pause