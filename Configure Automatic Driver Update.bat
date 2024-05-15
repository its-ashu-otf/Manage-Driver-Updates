@echo off
color 0a
title Configure Driver Update Through Windows Update v2.0
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion

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
echo =============================================
echo.
echo,
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2

echo Please Pick an option:
goto begin

:op1
:: ----------------------------------------------------------
:: -------Disable Windows Update device driver search--------
:: ----------------------------------------------------------
echo --- Disable Windows Update device driver search
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable inclusion of drivers with Windows updates-----
:: ----------------------------------------------------------
echo --- Disable inclusion of drivers with Windows updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0

:op2
echo Enabling drivers download via Windows update...
:: Disable inclusion of drivers with Windows updates (revert)
echo --- Disable inclusion of drivers with Windows updates (revert)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 0 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Disable Windows Update device driver search (revert)---
:: ----------------------------------------------------------
echo --- Disable Windows Update device driver search (revert)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
