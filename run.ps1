# Define the URL of the batch script from GitHub
$batchScriptUrl = "https://raw.githubusercontent.com/its-ashu-otf/Manage-Automatic-Driver-Updates/refs/heads/main/Configure%20Automatic%20Driver%20Update.bat" # Replace with the raw URL of the batch file from GitHub
$localFilePath = "$env:TEMP\script.bat"

# Function to clean up the downloaded batch script
function Cleanup {
    if (Test-Path $localFilePath) {
        Remove-Item -Path $localFilePath -Force
        Write-Output "Temporary file cleaned up: $localFilePath"
    }
}

# Function to check if the script is running as admin
function IsAdmin {
    return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

# Main script logic
try {
    # Check if running with admin privileges
    if (-not (IsAdmin)) {
        Write-Output "This script needs to be run as an administrator."
        Write-Host "Please restart this script with elevated privileges (Run as Administrator)." -ForegroundColor Yellow
        pause
        exit
    }

    # Inform the user about the download process
    Write-Output "Downloading the batch script to the temporary directory..."
    Invoke-WebRequest -Uri $batchScriptUrl -OutFile $localFilePath -ErrorAction Stop

    # Check if the script was downloaded successfully
    if (Test-Path $localFilePath) {
        Write-Output "Batch script downloaded successfully to $localFilePath."
        
        # Execute the batch script with admin privileges
        Write-Output "Executing the batch script with elevated privileges..."
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$localFilePath`"" -Verb RunAs -Wait

        Write-Output "Batch script execution completed."
    } else {
        Write-Output "Failed to download the batch script. Please check the URL."
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
} finally {
    # Clean up the downloaded file
    Write-Output "Cleaning up temporary files..."
    Cleanup
}
