param([String[]] $servers)
# start the script .\script_name.ps1 server1, server2, server3 .....
# The script check time and break/exit with 1 in case of more then 1 minute difference

if(!$servers) {
	cls
	Write-Host "Please add minimum two server to the script"
	Write-Host "Example .\CheckTime.ps1 server1, server2, server3, server4"
	exit 1
	}

foreach ($server in $servers){
$dt = Get-WmiObject win32_operatingsystem -computer $server
$dt_local = $dt.converttodatetime($dt.localdatetime)
write-host "Current local time at server $($server) is $($dt_local)"

$ThisServerTime = "$($dt_local.hour):$($dt_local.minute)"
if($SecondServerTime) {
	if ("$ThisServerTime" -ne "$SecondServerTime") {
		cls
		Write-Host "Please check the time at server $($server)!"
		EXIT 1
		}
	}
$SecondServerTime = "$($dt_local.hour):$($dt_local.minute)"
} 
