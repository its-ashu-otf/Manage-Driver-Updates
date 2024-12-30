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

# Function to check internet connectivity
function Test-InternetConnection {
    try {
        # Try to reach a known public server (Google DNS)
        $testConnection = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        return $testConnection
    } catch {
        return $false
    }
}

# Function to use Windows Terminal or fallback to cmd.exe
function ExecuteWithTerminal {
    $terminalPath = Get-Command "wt" -ErrorAction SilentlyContinue
    if ($terminalPath) {
        # Windows Terminal found
        Write-Output "Windows Terminal found, using it to run the batch script..."
        Start-Process -FilePath "wt.exe" -ArgumentList "cmd.exe /c `"$localFilePath`"" -Verb RunAs -Wait
    } else {
        # Fall back to cmd.exe if Windows Terminal is not found
        Write-Output "Windows Terminal not found, falling back to cmd.exe..."
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$localFilePath`"" -Verb RunAs -Wait
    }
}

# Main script logic
try {
    # Check internet connectivity
    if (-not (Test-InternetConnection)) {
        Write-Host "No internet connectivity detected. Please check your network connection." -ForegroundColor Red
        exit
    }

    # Check if running with admin privileges
    if (-not (IsAdmin)) {
        Write-Output "This script needs to be run as an administrator." -ForegroundColor Red
        Write-Host "Please restart this script with elevated privileges (Run as Administrator)." -ForegroundColor Yellow
        pause
        exit
    }

    # Inform the user about the download process
    Write-Output "Fetching the Stop Driver Update to the temporary directory..." -ForegroundColor Green
    Invoke-WebRequest -Uri $batchScriptUrl -OutFile $localFilePath -ErrorAction Stop

    # Check if the script was downloaded successfully
    if (Test-Path $localFilePath) {
        Write-Output "Stop Driver Update script downloaded successfully to $localFilePath."
        
        # Execute the batch script with admin privileges
        Write-Output "Executing the Stop Driver Update script with elevated privileges..." -ForegroundColor Green
        ExecuteWithTerminal

        Write-Output "Batch script execution completed."
    } else {
        Write-Output "Failed to download the batch script. Please check the URL."
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
} finally {
    # Clean up the downloaded file
    Write-Output "Cleaning up temporary files..." -ForegroundColor Yellow
    Cleanup
}

