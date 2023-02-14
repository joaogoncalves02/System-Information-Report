# Get system information using WMI
$computerSystem = Get-WmiObject Win32_ComputerSystem
$operatingSystem = Get-WmiObject Win32_OperatingSystem
$bios = Get-WmiObject Win32_BIOS
$processor = Get-WmiObject Win32_Processor
$memory = Get-WmiObject Win32_PhysicalMemory
$totalMemory = ($memory | Measure-Object -Property Capacity -Sum).Sum
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$graphicsCard = Get-WmiObject Win32_VideoController
$motherboard = Get-WmiObject Win32_Baseboard

# Define the output file path on the desktop
$outputFilePath = "$([Environment]::GetFolderPath('Desktop'))\system_config_report.txt"

# Output system information to the file
"System Information Report" | Out-File -FilePath $outputFilePath
"------------------------------------------------" | Out-File -FilePath $outputFilePath -Append
"Manufacturer: $($computerSystem.Manufacturer)" | Out-File -FilePath $outputFilePath -Append
"Model: $($computerSystem.Model)" | Out-File -FilePath $outputFilePath -Append
"BIOS Version: $($bios.SMBIOSBIOSVersion)" | Out-File -FilePath $outputFilePath -Append
"Motherboard: $($motherboard.Product), $($motherboard.Manufacturer)" | Out-File -FilePath $outputFilePath -Append
"Processor: $($processor.Name)" | Out-File -FilePath $outputFilePath -Append
"Number of Cores: $($processor.NumberOfCores)" | Out-File -FilePath $outputFilePath -Append
"Processor Base Frequency: $($processor.MaxClockSpeed) MHz" | Out-File -FilePath $outputFilePath -Append
"Memory: $($totalMemory / 1GB) GB" | Out-File -FilePath $outputFilePath -Append
"Disk Space: $($disk.FreeSpace / 1GB) GB free of $($disk.Size / 1GB) GB" | Out-File -FilePath $outputFilePath -Append
"Graphics Card: $($graphicsCard.Name)" | Out-File -FilePath $outputFilePath -Append
"Graphics Card Manufacturer: $($graphicsCard.VideoProcessor)" | Out-File -FilePath $outputFilePath -Append
"Graphics Card Memory: $($graphicsCard.AdapterRAM / 1GB) GB" | Out-File -FilePath $outputFilePath -Append
"Graphics Card Driver Version: $($graphicsCard.DriverVersion)" | Out-File -FilePath $outputFilePath -Append

# Note: Some graphics cards may have multiple processor cores with different clock speeds. This script only displays the base clock speed of the first core. Additional logic would be needed to handle multiple cores.
