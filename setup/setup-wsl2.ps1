$TEMP_PATH = "C:\temp"
$WSL_KERNEL_URL = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$WSL_KERNEL_INSTALLER = Join-Path $TEMP_PATH "wsl_update_x64.msi"
$RUNONCE_BAT = "wsl2.bat"
$RUNONCE_BAT_PATH = Join-Path $TEMP_PATH $RUNONCE_BAT
# Enable WSL
Write-Host "Enabling WSL..." -ForegroundColor Green
Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -All -NoRestart

# Enable Virtual Machine feature
Write-Host "Enabling VirtualMachinePlatform..." -ForegroundColor Green
Enable-WindowsOptionalFeature -FeatureName VirtualMachinePlatform -Online -All -NoRestart

# Create temporary directory for downloaded installers
if (-not (Test-Path $TEMP_PATH)) {
    New-Item -Path $TEMP_PATH -ItemType Directory
}

# Download WSL Kernel Update
Start-BitsTransfer -Source $WSL_KERNEL_URL -Destination $WSL_KERNEL_INSTALLER

# Create RunOnce Entry
$runonce_commands = @("start /wait msiexec.exe /i `"$WSL_KERNEL_INSTALLER`" /qn")
$runonce_commands += "wsl --set-default-version 2"
$runonce_commands | Out-File $RUNONCE_BAT_PATH -Encoding utf8

New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" `
    -Name "WSL2" -Value $RUNONCE_BAT_PATH -PropertyType String

Write-Host "Please reboot to complete the setup." -ForegroundColor "Yellow"
