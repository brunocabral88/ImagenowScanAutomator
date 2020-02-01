
$defaultPrinter = Get-WmiObject -Query " SELECT * FROM Win32_Printer WHERE Default=$true" | select Name

# Check if ImageNow Printer is the default
if ($defaultPrinter.Name -ne "ImageNow Printer") {
    Write-Error "ImageNow is not your default printer. Please fix it before proceeding."
    return
} 

# Check if Imagenow is open
try {
    $process = Get-Process -Name "imagenow" -ErrorAction Stop
}
catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
    Write-Output "Imagenow is not running, please run it and log into the system before proceeding."
    return
}

$files = Get-ChildItem -Path ".\*.pdf"
$confirmation = Read-Host "Printing $($files.Count) files to Imagenow. Do you want to proceed? [Y] or [N]?"

if ($confirmation -ne "y" -and $confirmation -ne "yes") {
    Write-Output "Operation cancelled."
    return
}

$intervalBetweenFiles = 5 #seconds

# Print files
foreach ($file in $files) {
    Write-Output "Printing file $file"
    Start-Process -FilePath $file -Verb Print -PassThru | %{sleep $intervalBetweenFiles;$_} | kill

    # Create processed folder if not exists
    if (!(Test-Path -Path "Processed" -PathType Container)) {
        New-Item -ItemType Directory -Name "Processed"
    }

    # Move items to processed folder
    Move-Item -Path $file -Destination "Processed"
}