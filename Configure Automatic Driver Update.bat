@echo off
color 0a
title Configure Driver Update Through Windows Update v4.0
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
:::                             ___  _   _     _ ___ ____     ____ ____ _  _ _  _     ____ ___ ____ 
:::			            	    |__]  \_/  .   |  |  [__      |__| [__  |__| |  |     |  |  |  |___ 
:::				                |__]   |   .   |  |  ___] ___ |  | ___] |  | |__| ___ |__|  |  |    
:::                                                     								
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
:begin
echo       Configure Windows Driver Update
echo =============================================
echo.
echo 1) Disable Driver Updates Offered By Windows (Recommended)
echo 2) Enable Driver Updates Offered By Windows
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
:: ----Disable inclusion of drivers with Windows updates-----
:: ----------------------------------------------------------
echo --- Disable inclusion of drivers with Windows updates
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable Windows Update device driver search--------
:: ----------------------------------------------------------
echo --- Disable Windows Update device driver search
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t "REG_DWORD" /d "1" /f
:: ----------------------------------------------------------

powershell.exe -Command "& {
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -Name 'PreventDeviceMetadataFromNetwork' -Type DWord -Value 1

    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontPromptForWindowsUpdate' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontSearchWindowsUpdate' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DriverUpdateWizardWuSearchEnabled' -Type DWord -Value 0

    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ExcludeWUDriversInQualityUpdate' -Type DWord -Value 1
}"

:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0

:op2

:: Enable inclusion of drivers with Windows updates
echo --- Enable inclusion of drivers with Windows updates 
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Enable Windows Update device driver search ---
:: ----------------------------------------------------------
echo --- Enable Windows Update device driver search 
:: Key exists with value "4" (All data) since Windows 10 22H2, Windows 11 22H3
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t "REG_DWORD" /d "1" /f
:: ----------------------------------------------------------

powershell.exe -Command "& {
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -Name 'PreventDeviceMetadataFromNetwork' -ErrorAction SilentlyContinue
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata')) {
        Remove-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -ErrorAction SilentlyContinue
    }

    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontPromptForWindowsUpdate' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontSearchWindowsUpdate' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DriverUpdateWizardWuSearchEnabled' -ErrorAction SilentlyContinue
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching')) {
        Remove-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -ErrorAction SilentlyContinue
    }

    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ExcludeWUDriversInQualityUpdate' -ErrorAction SilentlyContinue
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate')) {
        Remove-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -ErrorAction SilentlyContinue
    }
}"

:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
