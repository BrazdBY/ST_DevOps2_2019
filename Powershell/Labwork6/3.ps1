##########################################################################################
#1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
##########################################################################################

function Set-DHCPToInterfaces {

    $hosts = @("VM1-Pogulaev", "VM2-Pogulev", "VM3-Pogulaev")
    #Turn on DHCP 
    Invoke-Command -ComputerName $hosts -Credential "Administrator" -ScriptBlock `
    {Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true and DHCPEnabled=false" | ForEach-Object -Process {$_.InvokeMethod("EnableDHCP", $null)}}

    #Check enable DHCP
    Invoke-Command -ComputerName $hosts -Credential "Administrator" -ScriptBlock `
    {Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true and DHCPEnabled=true"}

}