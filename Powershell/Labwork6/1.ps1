############################################################################
#1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
############################################################################
function Get-IpAddresses {
    
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true, HelpMessage = "Enter name of computer")]
        [string]$Computer="."
    )

    [int]$counter = 0
    $AllIp = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration"  -ComputerName $Computer  | Select-Object -ExpandProperty IPAddress
    $AllIp
}

Get-IpAddresses