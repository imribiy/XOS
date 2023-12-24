@echo off
bcdedit /set {current} nx optin
echo "DEP Enabled, please reboot."
pause