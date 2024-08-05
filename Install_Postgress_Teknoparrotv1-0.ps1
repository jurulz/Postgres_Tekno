Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to set console text color
function Set-ConsoleColor {
    param(
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$Color
    )
    $host.UI.RawUI.ForegroundColor = $Color
}

# Function to reset console text color to default
function Reset-ConsoleColor {
    $host.UI.RawUI.ForegroundColor = [System.ConsoleColor]::Gray
}

# Function to select folder using a dialog box
function Select-FolderDialog {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select the base folder where PostgreSQL should be installed and the installer will be downloaded"
    $folderBrowser.ShowNewFolderButton = $true

    if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderBrowser.SelectedPath
    } else {
        Set-ConsoleColor -Color Red
        Write-Output "No folder selected. Exiting script."
        Reset-ConsoleColor
        exit
    }
}

# Function to display header
function Display-Header {
    Set-ConsoleColor -Color Cyan
    Write-Output "########################################################################"
    Write-Output "PostgreSQL Installation and Validation for Teknoparrot by unspoiledpuma"
    Write-Output "########################################################################"
    Reset-ConsoleColor
}

# Step 1: Display header
Display-Header

# Step 2: Prompt the user to select the base folder location
Set-ConsoleColor -Color Yellow
Write-Output "Step 1: Select Installation Folder"
Reset-ConsoleColor
$baseFolder = Select-FolderDialog

# Define the PostgresDB base directory
$postgresDBFolder = Join-Path $baseFolder "PostgresDB"

# Set the destination folder for the installer files under PostgresDB
$destFolder = Join-Path $postgresDBFolder "installer_files"

# Create the PostgresDB and destination directories if they do not exist
if (-not (Test-Path $postgresDBFolder)) {
    New-Item -Path $postgresDBFolder -ItemType Directory | Out-Null
}

if (-not (Test-Path $destFolder)) {
    New-Item -Path $destFolder -ItemType Directory | Out-Null
}

# Step 3: Download the PostgreSQL installer
Set-ConsoleColor -Color Yellow
Write-Output "Step 2: Downloading PostgreSQL Installer..."
Reset-ConsoleColor
$installerUrl = "https://ftp.postgresql.org/pub/old/binary/v8.3.23/win32/postgresql-8.3.23-1.zip"
$installerPath = Join-Path $destFolder "postgresql-8.3.23-1.zip"
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
Set-ConsoleColor -Color Green
Write-Output "Download completed."
Reset-ConsoleColor

# Step 4: Unzip the PostgreSQL installer
Set-ConsoleColor -Color Yellow
Write-Output "Step 3: Unzipping PostgreSQL Installer..."
Reset-ConsoleColor
Expand-Archive -Path $installerPath -DestinationPath $destFolder
Set-ConsoleColor -Color Green
Write-Output "Unzipping completed."
Reset-ConsoleColor

# Step 5: Ensure Secondary Logon Service is Running
Set-ConsoleColor -Color Yellow
Write-Output "Step 4: Ensuring Secondary Logon Service is Running..."
Reset-ConsoleColor
$service = Get-Service -Name seclogon -ErrorAction SilentlyContinue
if ($service.Status -ne 'Running') {
    Start-Service -Name seclogon
    Set-ConsoleColor -Color Green
    Write-Output "Secondary Logon service started."
} else {
    Set-ConsoleColor -Color Green
    Write-Output "Secondary Logon service is already running."
}
Reset-ConsoleColor

# Step 6: Install Microsoft VC++ 2005 runtime libraries and PostgreSQL
Set-ConsoleColor -Color Yellow
Write-Output "Step 5: Installing Prerequisites and PostgreSQL..."
Reset-ConsoleColor

# Path to the VC++ installer
$vcredistPath = Join-Path $destFolder "vcredist_x86.exe"
# Path to the PostgreSQL MSI installer
$postgresMsiPath = Join-Path $destFolder "postgresql-8.3.msi"

# Install Microsoft VC++ 2005 runtime libraries
Write-Output "Installing Microsoft VC++ 2005 runtime libraries..."
Start-Process -FilePath $vcredistPath -ArgumentList "/q:a /c:`"msiexec /i vcredist.msi /qb!`"" -Wait
Set-ConsoleColor -Color Green
Write-Output "VC++ 2005 runtime installation completed."
Reset-ConsoleColor

# Install PostgreSQL
Write-Output "Installing PostgreSQL..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $postgresMsiPath" -Wait
Set-ConsoleColor -Color Green
Write-Output "PostgreSQL installation completed."
Reset-ConsoleColor

# Wait for installation to complete (assuming the user follows the prompts manually)
Set-ConsoleColor -Color Yellow
Write-Output "Please follow the installer prompts and use the password 'teknoparrot' when prompted."
Reset-ConsoleColor
Pause

# Step 7: Verify PostgreSQL installation
function Validate-PostgresService {
    $serviceName = "pgsql-8.3"

    try {
        $serviceStatus = & sc query $serviceName

        if ($serviceStatus -match "STATE\s*:\s*4\s*RUNNING") {
            Set-ConsoleColor -Color Green
            Write-Output "PostgreSQL service 'pgsql-8.3' is running."
            Set-ConsoleColor -Color White
            Write-Output "Service Status Details:"
            # Extract and display relevant service information
            $serviceStatusLines = $serviceStatus -split "`r`n"
            foreach ($line in $serviceStatusLines) {
                if ($line -match "^\s*SERVICE_NAME|^\s*DISPLAY_NAME|^\s*STATE|^\s*START_TYPE|^\s*WIN32_EXIT_CODE|^\s*SERVICE_TYPE") {
                    Write-Output $line.Trim()
                }
            }
            Reset-ConsoleColor
            return $true
        } else {
            Set-ConsoleColor -Color Red
            Write-Output "PostgreSQL service 'pgsql-8.3' is not running."
            Set-ConsoleColor -Color White
            Write-Output "Service Status Details:"
            Write-Output $serviceStatus
            Reset-ConsoleColor
            return $false
        }
    } catch {
        Set-ConsoleColor -Color Red
        Write-Output "Failed to query the PostgreSQL service. The service might not be installed."
        Write-Output $_.Exception.Message
        Reset-ConsoleColor
        return $false
    }
}

Set-ConsoleColor -Color Yellow
Write-Output "Step 6: Verifying PostgreSQL Installation..."
Reset-ConsoleColor
$installationSuccess = Validate-PostgresService

if ($installationSuccess) {
    Set-ConsoleColor -Color Green
    Write-Output "PostgreSQL installation verified successfully."
    Reset-ConsoleColor

    # Prompt user for reboot
    $dialogResult = [System.Windows.Forms.MessageBox]::Show("Do you want to reboot the computer now?", "Reboot Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)

    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::Yes) {
        Set-ConsoleColor -Color Yellow
        Write-Output "Rebooting the computer..."
        Reset-ConsoleColor
        Restart-Computer -Force
    } else {
        Set-ConsoleColor -Color Green
        Write-Output "Reboot postponed. Please reboot manually to complete the installation."
        Reset-ConsoleColor
    }
} else {
    Set-ConsoleColor -Color Red
    Write-Output "PostgreSQL installation verification failed. Please check the installation logs."
    Reset-ConsoleColor
    exit
}
