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

        if ( $mask -match "[0-9]{1,3}\.{1,3}\.[0-9]{1,3}") {
            
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
        param (
            [parameter(Mandatory=$true)]
            [ValidateRange(1,32)]
            [int]$CIDRmask
        )
        
            $StandartMask = 32 - $CIDRmask

        return [string]$IpMask   
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
       $mask = Convert-CidrToIPMask  $mask
    } elseif ((Get-typeOfMask $mask) -eq "wrong") {
        $result = "Wrong mask. Please, Lets check it"
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

Check-IpAddresses -ip1 "192.168.0.1" -ip2 "192.168.3.3" -mask "255.255.255.0"
