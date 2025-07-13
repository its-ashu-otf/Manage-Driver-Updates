@echo off
color 0a
title Manage Driver Updates v6.0
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
::: 
:::    __  ___                                ____       _                    __  __          __      __           
:::   /  |/  /___ _____  ____ _____ ____     / __ \_____(_)   _____  _____   / / / /___  ____/ /___ _/ /____  _____
:::  / /|_/ / __ `/ __ \/ __ `/ __ `/ _ \   / / / / ___/ / | / / _ \/ ___/  / / / / __ \/ __  / __ `/ __/ _ \/ ___/
::: / /  / / /_/ / / / / /_/ / /_/ /  __/  / /_/ / /  / /| |/ /  __/ /     / /_/ / /_/ / /_/ / /_/ / /_/  __(__  ) 
:::/_/  /_/\__,_/_/ /_/\__,_/\__, /\___/  /_____/_/  /_/ |___/\___/_/      \____/ .___/\__,_/\__,_/\__/\___/____/  
:::                         /____/                                             /_/                                 
:::     
:--------------------------------------
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
:begin
echo       Configure Windows Driver Update
echo =============================================
echo.
echo 1) Disable Driver Updates Offered By Windows (Recommended)
echo 2) Disable Driver Updates Offered By Windows Agressive (NOT Recommended)
echo 3) Enable Driver Updates Offered By Windows
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
:: ---------Disable Windows Update driver downloads----------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver downloads
:: Set the registry value: "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'; $data =  '1'; reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState!ExcludeWUDrivers"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState' /v 'ExcludeWUDrivers' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate!value"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate' /v 'value' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable Windows Update driver search-----------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver search
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching!SearchOrderConfig"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching'; $data =  '0'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' /v 'SearchOrderConfig' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching!SearchOrderConfig"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching'; $data =  '2'; reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' /v 'SearchOrderConfig' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable Windows Update driver installation wizard-----
:: ----------------------------------------------------------
echo --- Disable Windows Update driver installation wizard
:: Set the registry value: "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching'; $data =  '0'; reg add 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching'; $data =  '0'; reg add 'HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\Software\Microsoft\Windows\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Microsoft\Windows\DriverSearching'; $data =  '0'; reg add 'HKLM\Software\Microsoft\Windows\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable Windows Update fallback driver search-------
:: ----------------------------------------------------------
echo --- Disable Windows Update fallback driver search
:: Set the registry value: "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DontSearchWindowsUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching'; $data =  '1'; reg add 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DontSearchWindowsUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable Windows Update driver download server-------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver download server
:: Set the registry value: "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DriverServerSelection"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching'; $data =  '1'; reg add 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DriverServerSelection' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0

:op2

:: ----------------------------------------------------------
:: --Disable Windows Update hardware information collection--
:: ----------------------------------------------------------
echo --- Disable Windows Update hardware information collection
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata!PreventDeviceMetadataFromNetwork"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata' /v 'PreventDeviceMetadataFromNetwork' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata!PreventDeviceMetadataFromNetwork"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata'; $data =  '1'; reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' /v 'PreventDeviceMetadataFromNetwork' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-DeviceSetupManager/Admin!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-DeviceSetupManager/Admin'; $data =  '0'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-DeviceSetupManager/Admin' /v 'Enabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata!DeviceMetadataServiceURL"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata'; $data =  'http://127.0.0.1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata' /v 'DeviceMetadataServiceURL' /t 'REG_SZ' /d "^""$data"^"" /f"
:: Soft delete files matching pattern: "%SYSTEMROOT%\System32\DeviceMetadataRetrievalClient.dll" with additional permissions 
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\DeviceMetadataRetrievalClient.dll"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; Add-Type -TypeDefinition "^""using System;`r`nusing System.Runtime.InteropServices;`r`npublic class Privileges {`r`n    [DllImport(`"^""advapi32.dll`"^"", ExactSpelling = true, SetLastError = true)]`r`n    internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall,`r`n        ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr relen);`r`n    [DllImport(`"^""advapi32.dll`"^"", ExactSpelling = true, SetLastError = true)]`r`n    internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr phtok);`r`n    [DllImport(`"^""advapi32.dll`"^"", SetLastError = true)]`r`n    internal static extern bool LookupPrivilegeValue(string host, string name, ref long pluid);`r`n    [StructLayout(LayoutKind.Sequential, Pack = 1)]`r`n    internal struct TokPriv1Luid {`r`n        public int Count;`r`n        public long Luid;`r`n        public int Attr;`r`n    }`r`n    internal const int SE_PRIVILEGE_ENABLED = 0x00000002;`r`n    internal const int TOKEN_QUERY = 0x00000008;`r`n    internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;`r`n    public static bool AddPrivilege(string privilege) {`r`n        try {`r`n            bool retVal;`r`n            TokPriv1Luid tp;`r`n            IntPtr hproc = GetCurrentProcess();`r`n            IntPtr htok = IntPtr.Zero;`r`n            retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);`r`n            tp.Count = 1;`r`n            tp.Luid = 0;`r`n            tp.Attr = SE_PRIVILEGE_ENABLED;`r`n            retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);`r`n            retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);`r`n            return retVal;`r`n        } catch (Exception ex) {`r`n            throw new Exception(`"^""Failed to adjust token privileges`"^"", ex);`r`n        }`r`n    }`r`n    public static bool RemovePrivilege(string privilege) {`r`n        try {`r`n            bool retVal;`r`n            TokPriv1Luid tp;`r`n            IntPtr hproc = GetCurrentProcess();`r`n            IntPtr htok = IntPtr.Zero;`r`n            retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);`r`n            tp.Count = 1;`r`n            tp.Luid = 0;`r`n            tp.Attr = 0;  // This line is changed to revoke the privilege`r`n            retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);`r`n            retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);`r`n            return retVal;`r`n        } catch (Exception ex) {`r`n            throw new Exception(`"^""Failed to adjust token privileges`"^"", ex);`r`n        }`r`n    }`r`n    [DllImport(`"^""kernel32.dll`"^"", CharSet = CharSet.Auto)]`r`n    public static extern IntPtr GetCurrentProcess();`r`n}"^""; [Privileges]::AddPrivilege('SeRestorePrivilege') | Out-Null; [Privileges]::AddPrivilege('SeTakeOwnershipPrivilege') | Out-Null; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminFullControlAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule( $adminAccount, [System.Security.AccessControl.FileSystemRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $foundAbsolutePaths = @(); try { $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] { <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) { Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) { if (Test-Path -Path $path -PathType Container) { Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) { if (-not $path.EndsWith('.OLD')) { Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else { if ($path.EndsWith('.OLD')) { Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) { Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; $originalAcl = Get-Acl -Path "^""$originalFilePath"^""; $accessGranted = $false; try { $acl = Get-Acl -Path "^""$originalFilePath"^""; $acl.SetOwner($adminAccount) <# Take Ownership (because file is owned by TrustedInstaller) #>; $acl.AddAccessRule($adminFullControlAccessRule) <# Grant rights to be able to move the file #>; Set-Acl -Path $originalFilePath -AclObject $acl -ErrorAction Stop; $accessGranted = $true; } catch { Write-Warning "^""Failed to grant access to `"^""$originalFilePath`"^"": $($_.Exception.Message)"^""; }; if ($revert -eq $true) { $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else { $newFilePath = "^""$($originalFilePath).OLD"^""; }; try { Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; if ($accessGranted) { try { Set-Acl -Path $newFilePath -AclObject $originalAcl -ErrorAction Stop; } catch { Write-Warning "^""Failed to restore access on `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; }; }; } catch { Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; if ($accessGranted) { try { Set-Acl -Path $originalFilePath -AclObject $originalAcl -ErrorAction Stop; } catch { Write-Warning "^""Failed to restore access on `"^""$originalFilePath`"^"": $($_.Exception.Message)"^""; }; }; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) { Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) { Write-Warning "^""Failed to process $($failedCount) items."^""; }; [Privileges]::RemovePrivilege('SeRestorePrivilege') | Out-Null; [Privileges]::RemovePrivilege('SeTakeOwnershipPrivilege') | Out-Null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable Windows Update driver downloads----------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver downloads
:: Set the registry value: "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'; $data =  '1'; reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState!ExcludeWUDrivers"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState' /v 'ExcludeWUDrivers' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate!value"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate' /v 'value' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate'; $data =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable Windows Update driver search-----------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver search
:: Set the registry value: "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching!SearchOrderConfig"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching'; $data =  '0'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' /v 'SearchOrderConfig' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching!SearchOrderConfig"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching'; $data =  '2'; reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' /v 'SearchOrderConfig' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable Windows Update driver installation wizard-----
:: ----------------------------------------------------------
echo --- Disable Windows Update driver installation wizard
:: Set the registry value: "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching'; $data =  '0'; reg add 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching'; $data =  '0'; reg add 'HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKLM\Software\Microsoft\Windows\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Microsoft\Windows\DriverSearching'; $data =  '0'; reg add 'HKLM\Software\Microsoft\Windows\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable Windows Update fallback driver search-------
:: ----------------------------------------------------------
echo --- Disable Windows Update fallback driver search
:: Set the registry value: "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DontSearchWindowsUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching'; $data =  '1'; reg add 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DontSearchWindowsUpdate' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable Windows Update driver download server-------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver download server
:: Set the registry value: "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DriverServerSelection"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching'; $data =  '1'; reg add 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DriverServerSelection' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0

:op3

:: ----------------------------------------------------------
:: -----Disable Windows Update driver downloads (revert)-----
:: ----------------------------------------------------------
echo --- Disable Windows Update driver downloads (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' /v 'ExcludeWUDriversInQualityUpdate' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState!ExcludeWUDrivers"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState' /v 'ExcludeWUDrivers' /f 2>$null"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate!value"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate' /v 'value' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update' /v 'ExcludeWUDriversInQualityUpdate' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update' /v 'ExcludeWUDriversInQualityUpdate' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate!ExcludeWUDriversInQualityUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable Windows Update driver search (revert)-------
:: ----------------------------------------------------------
echo --- Disable Windows Update driver search (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching!SearchOrderConfig"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData =  '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' /v 'SearchOrderConfig' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching!SearchOrderConfig"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' /v 'SearchOrderConfig' /f 2>$null"
:: ----------------------------------------------------------


:: Disable Windows Update driver installation wizard (revert)
echo --- Disable Windows Update driver installation wizard (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /f 2>$null"
:: Delete the registry value "HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /f 2>$null"
:: Delete the registry value "HKLM\Software\Microsoft\Windows\DriverSearching!DriverUpdateWizardWuSearchEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Microsoft\Windows\DriverSearching' /v 'DriverUpdateWizardWuSearchEnabled' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable Windows Update fallback driver search (revert)--
:: ----------------------------------------------------------
echo --- Disable Windows Update fallback driver search (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DontSearchWindowsUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DontSearchWindowsUpdate' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable Windows Update driver download server (revert)--
:: ----------------------------------------------------------
echo --- Disable Windows Update driver download server (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\DriverSearching!DriverServerSelection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\DriverSearching' /v 'DriverServerSelection' /f 2>$null"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
