@echo off
title Enable Feature Script by imribiy#0001
set /p feature="Enter the name of the feature you want to enable: "
set feature=%feature%

%config% echo set feature=%feature%

dism /online /enable-feature /all /featurename:%feature%
pause