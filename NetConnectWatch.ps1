# every 5 minutes, ping a DNS external dns server, ping internal dns server, ping external ip adddress, ping website by DNS name

#set external ips to ping

Function HDSN-TestConnection{

$NetCSV = '.\HDSN-NetworkConnection.csv'
$Timeout = 100
$Ping = New-Object System.Net.NetworkInformation.Ping

$Externalip = '172.217.1.206'
$ExternalDNS = '8.8.8.8'
$ExternalSiteName = 'eff.org'
$defaultgateway = (Get-NetRoute "0.0.0.0/0").NextHop

$Response = $Ping.Send($Externalip,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}},@{Name='DestinationType'; e={'ExternalIP'}}, @{Name='Destination'; e={$Externalip}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation

$Response = $Ping.Send($ExternalDNS,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}}, @{Name='DestinationType'; e={'ExternalDNS'}},@{Name='Destination'; e={$ExternalDNS}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation

$Response = $Ping.Send($ExternalSiteName,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}}, @{Name='DestinationType'; e={'ExternalSiteName'}},@{Name='Destination'; e={$ExternalSiteName}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation

$Response = $Ping.Send($defaultgateway,$Timeout)
$response | select @{n='TimeStamp';e={Get-Date}},@{Name='DestinationType'; e={'Gateway'}}, @{Name='Destination'; e={$defaultgateway}}, status, RoundTripTime | Export-Csv $NetCSV -append -notypeinformation
}

#change this value to turn off autorun every minute
$run = 'yes'

While($run='yes'){
HDSN-TestConnection -WindowStyle Hidden
sleep 60
}