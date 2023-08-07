Get-PnpDevice -FriendlyName "Communications Port (COM1)" | enable-PnpDevice
Set-Service -Name "serial" -Status stopped -StartupType manual