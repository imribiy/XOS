@echo off
title Disable Feature Script by imribiy#0001
set /p feature="Enter the name of the feature you want to disable: "
set feature=%feature%

%config% echo set feature=%feature%

dism /online /disable-feature /featurename:%feature%
pause