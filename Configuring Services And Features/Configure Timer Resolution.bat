@echo off
if /i "%~1"=="/disable"         goto disable

title Timer Resolution Toggle Script
cls
echo.
echo.	Setting 0.5ms Timer will increase idle power consumption for laptop users.
echo.	Also for some users 0.5ms Timer will not be better, it's up to you to test.
echo.	XOS sets 0.5ms Timer by default.
echo.	
echo.	Press [E] to enable 0.5ms Timer
echo.	Press [D] to disable 0.5ms Timer
echo.
set /p c="Enter your answer: "
if /i %c% equ D goto :disable
if /i %c% equ E goto :enable

:disable
taskkill /f /im timerres.exe
Reg.exe delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /f
cls
pause
exit

:enable
taskkill /f /im timerres.exe
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Windows\timerres.exe --resolution 5071 --no-console" /f
start "" "C:\Windows\timerres.exe" --resolution 5071 --no-console
cls
pause
exit