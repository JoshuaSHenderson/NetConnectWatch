# every 5 minutes, ping internal dns server, ping external ip adddress, ping website by DNS name, Ping Default Gateway


Function HDSN-TestConnection{

#change this value if you want the script to be saved somewhere else.
$NetCSV = '.\HDSN-NetworkConnection.csv'

#ping variables
$Timeout = 100
$Ping = New-Object System.Net.NetworkInformation.Ping

#Ip Addresses you want to ping, Change as needed
$Externalip = '172.217.1.206'
$ExternalDNS = '8.8.8.8'
$ExternalSiteName = 'eff.org'
$defaultgateway = (Get-NetRoute "0.0.0.0/0").NextHop

#Test ping and then Append the CSV with the results
$Response = $Ping.Send($Externalip,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}},@{Name='DestinationType'; e={'ExternalIP'}}, @{Name='Destination'; e={$Externalip}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation

$Response = $Ping.Send($ExternalDNS,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}}, @{Name='DestinationType'; e={'ExternalDNS'}},@{Name='Destination'; e={$ExternalDNS}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation

$Response = $Ping.Send($ExternalSiteName,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}}, @{Name='DestinationType'; e={'ExternalSiteName'}},@{Name='Destination'; e={$ExternalSiteName}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation

$Response = $Ping.Send($defaultgateway,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}},@{Name='DestinationType'; e={'Gateway'}}, @{Name='Destination'; e={$defaultgateway}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation
}

#Run the function created above
HDSN-TestConnection -WindowStyle Hidden
