Get-PnpDevice | Where-Object { $_.FriendlyName -match "Communications Port (COM1)" } | Disable-PnpDevice
Set-Service -Name "serial" -Status stopped -StartupType disabled