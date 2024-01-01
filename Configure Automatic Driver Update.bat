@echo off
color 0a
title Configure Driver Update Through Windows Update v2.0
@set "ERRORLEVEL="
@CMD /C EXIT 0
@"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
@if NOT "%ERRORLEVEL%"=="0" (
@powershell -Command Start-Process ""%0"" -Verb runAs 2>nul
@exit
)
:--------------------------------------
:::
:::  _____  _______   ____   _____    _____   _____   _____ __      __ ______  _____    _    _  _____   _____             _______  ______ 
::: / ____||__   __| / __ \ |  __ \  |  __ \ |  __ \ |_   _|\ \    / /|  ____||  __ \  | |  | ||  __ \ |  __ \     /\    |__   __||  ____|
:::| (___     | |   | |  | || |__) | | |  | || |__) |  | |   \ \  / / | |__   | |__) | | |  | || |__) || |  | |   /  \      | |   | |__   
::: \___ \    | |   | |  | ||  ___/  | |  | ||  _  /   | |    \ \/ /  |  __|  |  _  /  | |  | ||  ___/ | |  | |  / /\ \     | |   |  __|  
::: ____) |   | |   | |__| || |      | |__| || | \ \  _| |_    \  /   | |____ | | \ \  | |__| || |     | |__| | / ____ \    | |   | |____ 
:::|_____/    |_|    \____/ |_|      |_____/ |_|  \_\|_____|    \/    |______||_|  \_\  \____/ |_|     |_____/ /_/    \_\   |_|   |______|                                                                                                                                       
:::
:::				___  _   _     _ ___ ____     ____ ____ _  _ _  _     ____ ___ ____ 
:::				|__]  \_/  .   |  |  [__      |__| [__  |__| |  |     |  |  |  |___ 
:::				|__]   |   .   |  |  ___] ___ |  | ___] |  | |__| ___ |__|  |  |    
:::                                                     								
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
:begin
echo       Configure Windows Driver Update
echo =============================================
echo.
echo 1) Disable Driver Update Offered By Windows
echo 2) Enable Driver Update Offered By Windows
echo,
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2

echo Please Pick an option:
goto begin

:op1
echo Disabling drivers download via Windows update...
echo.
echo Deleting the Existing Registry Key...
echo.
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching /f
echo.
echo Adding the new key in Registry which disables Automatic Driver Update...
echo.
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching /v SearchOrderConfig /t REG_DWORD /d 0 /f
echo.
echo Editing Group Policy to Exclude Drivers in Windows Update 
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState /v ExcludeWUDrivers /f 
echo.
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState /v ExcludeWUDrivers /t REG_DWORD /d 1 /f
pause

:op2
echo Enabling drivers download via Windows update...
echo.
echo Deleting the Existing Registry Key...
echo.
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching /f
echo.
echo Adding the new key in Registry which enables Automatic Driver Update
echo.
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching /v SearchOrderConfig /t REG_DWORD /d 1 /f
echo.
echo Editing Group Policy to Include Drivers in Windows Update
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState /v ExcludeWUDrivers /f 
echo.
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState /v ExcludeWUDrivers /t REG_DWORD /d 0 /f
pause
