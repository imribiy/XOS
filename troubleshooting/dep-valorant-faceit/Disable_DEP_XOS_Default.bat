@echo off
bcdedit /set {current} nx alwaysoff
echo "DEP Disabled, please reboot."
pause