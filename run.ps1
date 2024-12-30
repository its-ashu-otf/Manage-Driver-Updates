# Define the URL of the batch script from GitHub
$batchScriptUrl = "https://raw.githubusercontent.com/its-ashu-otf/Manage-Automatic-Driver-Updates/refs/heads/main/Configure%20Automatic%20Driver%20Update.bat" # Replace with the raw URL of the batch file from GitHub
$localFilePath = "$env:TEMP\script.bat"

# Function to clean up the downloaded batch script
function Cleanup {
    if (Test-Path $localFilePath) {
        Remove-Item -Path $localFilePath -Force
        Write-Output "Cleaned up the downloaded batch script."
    }
}

try {
    # Download the batch script
    Write-Output "Downloading the batch script to $env:TEMP..."
    Invoke-WebRequest -Uri $batchScriptUrl -OutFile $localFilePath -ErrorAction Stop

    # Check if the script was downloaded successfully
    if (Test-Path $localFilePath) {
        Write-Output "Batch script downloaded successfully to $localFilePath."
        
        # Check if the script is already running with admin privileges
        if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-Output "Restarting script with admin privileges..."
            # Relaunch PowerShell with elevated privileges
            Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
            exit
        }

        # Execute the batch script with admin privileges
        Write-Output "Executing the batch script with admin privileges..."
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$localFilePath`"" -Verb RunAs -Wait
    } else {
        Write-Output "Failed to download the batch script. Please check the URL."
    }
} catch {
    Write-Output "An error occurred: $_"
} finally {
    # Clean up the downloaded file
    Cleanup
}
