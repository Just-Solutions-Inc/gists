# csv of monitored services (either registered service name, or display name), and log file path
$monitorServices = @("nsi")
$logFile = "C:\service_monitor.log"


# max number of lines in the log file. this number of lines will log approx 20days/n where n == number of services being monitored, and should max out around 1.1MB
$retention = 30250  
if ( Test-Path -Path $logFile ) { Set-Content -Path $logFile -Value $( Get-Content -Path $logFile -Last $retention ) }



function Write-Log {
    param(
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "${timestamp}: $Message"

    Add-Content -Path $logFile -Value $logEntry
}

while ($true) {
    foreach ($service in $monitorServices) {
        try {
            $serviceObj = Get-Service $service
            if ($serviceObj.Status -ne "Running") {
                Write-Log "Service '$service' is not running. Starting..."
                Start-Service $service
            } else {
                Write-Log "Service '$service' is running."
            }
        } catch [System.Exception] {
            Write-Log "Error occurred for service '$service': $_"
        }
    }
    Start-Sleep -Seconds 60 # Check every minute
}
