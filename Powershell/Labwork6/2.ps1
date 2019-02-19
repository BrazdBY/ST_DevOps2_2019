########################################################################################
#1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
########################################################################################

function Get-MacAddresses {
    [CmdletBinding()]

    Param (
        [parameter(Mandatory = $false, HelpMessage = "Enter name of computer")]
        [string]$Computer="."
    )

    $MyMac = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration"  -ComputerName $Computer | Select-Object -ExpandProperty MACAddress

    Write-Output ("Mac address of my computer is:") 
    $MyMac

    Write-Output ("Mac address of external computers is:")

    $hosts = @("VM1-Pogulaev", "VM2-Pogulev", "VM3-Pogulaev")
    Invoke-Command -ComputerName $hosts -Credential "Administrator" -ScriptBlock `
    {Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -Filter IPEnabled=TRUE | Select-Object -ExpandProperty MACAddress } 
}

Get-MacAddresses 