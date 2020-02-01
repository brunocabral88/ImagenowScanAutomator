# ImageNow Scan Automator
To avoid having to open every PDF document manually to create a new ImageNow file batch for each, this Powershell script automates this task and prints all PDFs in the current directory to the ImageNow (Perceptive Content) printer

## How it works
This script will read all PDF files in the current directory, print them to the ImageNow Printer and then move the processed files to a "Processed" folder. A document is processed every 5 seconds by default (defined in the ``$intervalBetweenFiles`` variable).

Note: ImageNow Printer must be your default printer and Imagenow client must be open before running this script

## Usage
Save file ImagenowAutoScan.ps1 to your computer, right click on it and choose "Run with Powershell"

If you get an error like the below, you have to change the Powershell Execution policy (Requires admin privileges) with ``Set-ExecutionPolicy Unrestricted -Force ``

```
File ImageNowAutoScanner.ps1 cannot be loaded because the execution of scripts is disabled on this system. Please see "get-help about_signing" for more details.
At line:1 char:13
+ .\hello.ps1 <<<<
+ CategoryInfo : NotSpecified: (:) [], PSSecurityException
+ FullyQualifiedErrorId : RuntimeException
```

Feel free to fork/adapt it to your needs
