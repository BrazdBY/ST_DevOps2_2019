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
######################################################################################
# 2.1. Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
######################################################################################

Get-Module -Name Hyper-V -ListAvailable

Get-WindowsOptionalFeature -Online -FeatureName *hyper-v* | select DisplayName, FeatureName
Get-WindowsFeature *hyper-v*
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

Get-Command -Module hyper-v 


############################################################################
#2.2.	Получить список виртуальных машин 
############################################################################

Get-VM
#########################################################
#2.3.	Получить состояние имеющихся виртуальных машин
#########################################################

Get-VM | Select-Object Name, State
##########################################################################
#2.4.	Выключить виртуальную машину
##########################################################################

Stop-VM -Name VM2-Pogulaev

#Shutdown All running VM
Get-VM | where {$_.State -eq 'Running'} | Stop-VM
#######################################################################
#2.5.	Создать новую виртуальную машину
#######################################################################


$VMName = "VM4-Pogulev"

$VM = @{
  Name = $VMName 
  MemoryStartupBytes = 2147483648
  Generation = 1
  NewVHDPath = "D:\VM\$VMName\$VMName.vhdx"
  NewVHDSizeBytes = 53687091200
  BootDevice = "VHD"
  Path = "D:\VM\$VMName"
  SwitchName = (Get-VMSwitch).Name
}

New-VM @VM
################################################################################
#2.6.	Создать динамический жесткий диск
################################################################################


$vhdpath = "D:\VM\VHDs\Test.vhdx"
$vhdsize = 127GB
New-VHD -Path $vhdpath -Dynamic -SizeBytes $vhdsize | Mount-VHD -Passthru |Initialize-Disk -Passthru |New-Partition -AssignDriveLetter -UseMaximumSize |Format-Volume -FileSystem NTFS -Confirm:$false -Force
##############################################################################################
#2.7.	Удалить созданную виртуальную машину
##############################################################################################

Get-VM -Name VM4-P* | Remove-VM -Force




#Записываем результаты всех файлов в общий файл
Get-content * -Exclude *.png | Set-Content All_task.ps1
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
###########################################################################################################################################################################################
#1.4.	Расшарить папку на компьютере
###########################################################################################################################################################################################

#Get-WmiObject -List | where{$_ -like "*share*"}


#Shares list 
Get-WmiObject win32_share


# create pointer to class
$comp=[WMICLASS]"Win32_share"
try {
    # create a new share
    $comp.create("c:\temp","mynewshare",0) 
}
catch {
  Write-Output "I cant' create share"
}


# see results
gwmi win32_share 

####################################################################################################
#1.5.	Удалить шару из п.1.4
####################################################################################################

Write-Output ("We have those shares:")
Get-WMIObject Win32_Share


$Shares = Get-WMIObject Win32_Share | Where {$_.Name -eq "mynewshare"}

Foreach ($Share in $Shares) {
   $Share.Delete()
}
Write-Output ""
Write-Output ("Share found and removed. And now we have:") 

 Get-WMIObject Win32_Share
####################################################################################################################################################
#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.
####################################################################################################################################################

function Check-IpAddresses
{
    <# 
    .SYNOPSIS  
        Проверить  в одной ли подсети адреса.

    .EXAMPLE 
        #Check-IpAddresses -ip1 192.168.8.2 -ip2 192.168.8.20 -mask 24 

    .EXAMPLE 
        #Check-IpAddresses -ip1 192.168.8.2 -ip2 192.168.8.20 -mask 255.255.255.0 
    #> 
 
    param ( 

        [ipaddress]$ip1, 
        [ipaddress]$ip2, 
        [string]$mask 
    
    ) 

    function Get-typeOfMask {


        param (
            [string]$Mask
        )
        $result ="empty"

        if ( $mask -match "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$") {
            
            Write-Output ("Mask is long")
               $result = "long"
        
        } else {
            #Write-Output ("mask is CIDR")
            try {
                [int]$maskCIDR = $Mask
                if ( (($MaskCIDR % 2 -eq 0 ) -or ($MaskCIDR % 2 -eq 1 )) -and ($maskCIDR -lt 32) ) {
                    $result = "CIDR"
                } else {
                    $result = "wrong"
                }
            } catch {
               $result = "wrong" 
            }
                       
        }        
        Write-Output ("Type of mask is - $($result)")
        return $result
    }
       
    function Convert-CidrToIPMask {
        <# 
            .SYNOPSIS  
                Перевести маску CIDR к обычной маске.

            .EXAMPLE 
                #Convert-CidrToIPMask -MaskBits 24 
    
        #> 
        
        param(
            [parameter(Mandatory=$true)]
            [ValidateRange(0,32)]
            [Int] $MaskBits
        )

        $mask = ([Math]::Pow(2, $MaskBits) - 1) * [Math]::Pow(2, (32 - $MaskBits))
        
        $bytes = [BitConverter]::GetBytes([UInt32] $mask)
        (($bytes.Count - 1)..0 | ForEach-Object { [String] $bytes[$_] }) -join "."
        
    }
    
      

    function Get-IpNetwork {
        param (
           [ipaddress]$ip,
           [ipaddress]$mask 
        )
        
        [ipaddress]$IpNetwork = [ipaddress]($ip.Address -band $mask.address)
        return [string]$IpNetwork.Address
    } 

    ############# solvation ###################################

    if ( (Get-typeOfMask -mask $mask) -eq "CIDR") {
       try {
        $mask = Convert-CidrToIPMask  $mask
       }
       catch {
           return Write-Output ("Wrong mask. Please, Let's check it")
       }
        
    } elseif ((Get-typeOfMask $mask) -eq "wrong") {
        $result = "Wrong mask. Please, Let's check it"
        return $result
    }
    

    Write-Output ("Result of check:")
    
    if ((Get-IpNetwork -ip $ip1 -mask $mask) -eq (Get-IpNetwork -ip $ip2 -mask $mask)) {
        $result = "$($ip1) and $($ip2) in same range"
    } else {
        $result = "$($ip1) and $($ip2) in diffirent range"
    }
    
    return $result

    
}


Check-IpAddresses -ip1 "192.168.0.1" -ip2 "192.168.3.3" -mask "255.255.0.0"
