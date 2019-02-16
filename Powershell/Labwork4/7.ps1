# 7.	�������� ��������, ��������� ��������� ����� ���������� ���������� (�������� 10.0.0.1) � ����.

Function Get-PingTimeResponse { 
        
    [CmdletBinding()]

    <#
    .SYNOPSIS
        ��������� �������� ����� � ���������� ���������� (Ping �� Powershell).

    .DESCRIPTION
        ������ ������� ��������� ������� ����� ����������  IP ������ � �������.

    .EXAMPLE
        #Get-PingTimeResponse -IpAddress 8.8.8.8 -CountTry 4 ������ ������� �������  ��������� 4 �������  ���������� ����� 8.8.8.8 

    .PARAMETER IpAddress
        ����� ���������� � ���� (IPv4). 

    .PARAMETER CountTry
        ���������� �������. (�� ������������ ��������)

    #>

    param (
            [PARAMETER(Mandatory=$true, Position=0)]
            [ValidateNotNullOrEmpty()]
            [ValidateScript({$_ -match [IPAddress]$_ })]
            [String]$IpAddress="8.8.8.8",
            
            [PARAMETER(Mandatory=$false,Position=1)]
            [ValidateNotNullOrEmpty()]
            [ValidatePattern ("[0-9]")]
            [int]$CountTry=4
    )

    [int]$SumResponseTime = 0
    Write-Output ""
    Write-Output ("����� �������� � " + $IpAddress + " ���������� ������� - " + $CountTry + ":" )
    
    for ($i=1; $i -le $CountTry;$i++){
        $Ping = Get-WmiObject -Class Win32_PingStatus -Filter ("Address= '" + $IpAddress + "'") -ComputerName . | Select-Object -Property Address,ResponseTime,StatusCode,ResponseTimeToLive
    
        if ($ping.StatusCode -eq "0"){
            $SumResponseTime += $ping.ResponseTime;
            Write-Output ("����� ��  $($IpAddress) ����� �������= $($Ping.ResponseTime)ms TTL=$($Ping.ResponseTimeToLive)")
            
        }
    }
    
    Write-Output ("����� ����� ����������� �� ������� ���������� -  $($SumResponseTime)")

    

}
Get-PingTimeResponse
