#######################################################################################################
#������� ������ ���� ������� 
#######################################################################################################
Get-WmiObject -List


#######################################################################################################
#������� ������ ���� ����������� ���� ������� WMI
#######################################################################################################
Get-WMIObject -namespace "root" -class "__Namespace" | Select Name

#######################################################################################################
#������� ������ ������� ������ � ��������� 
#######################################################################################################
Get-WmiObject -List *print*

#######################################################################################################
#������� ���������� �� ������������ �������
#######################################################################################################
#About operation system
#Get-WmiObject -List *OperatingSystem*
#Get-WmiObject -class Win32_OperatingSystem | format-list -property *

Get-WmiObject -class Win32_OperatingSystem | Select-Object Caption, BuildNumber, MUILanguages, PSComputerName, Status, `
             FreeSpaceInPagingFiles, FreeVirtualMemory, CSName, NumberOfUsers, OSArchitecture



#######################################################################################################
#������� ���������� � ����� 
#######################################################################################################
Get-WmiObject -Class Win32_Bios 




#######################################################################################################
# 6.	������� ��������� ����� �� ��������� ������. �� ������ � �����.
#######################################################################################################
#Get-WmiObject Win32_LogicalDisk -ComputerName . | Select-Object -Property FreeSpace 

[int]$SummFreeSpaces=0

$FreeSpaces = Get-WmiObject win32_logicaldisk | Select-Object -Property Name, FreeSpace 
foreach ($Space in $FreeSpaces) {
    
    Write-Output ("�� ����� " + ($Space.Name) + " �������� - " + ($Space.FreeSpace/1Gb) + " Gb")
    $SummFreeSpaces += $Space.FreeSpace/1Gb
} 

Write-Output ("����� ���������� �����: " + $SummFreeSpaces + " Gb")

#######################################################################################################
# 7.	�������� ��������, ��������� ��������� ����� ���������� ���������� (�������� 10.0.0.1) � ����.
#######################################################################################################
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

#######################################################################################################
# 8.	������� ����-�������� ������ ������ ������������� ����������� ��������� � ���� ������� � ������ ��� � ������.
#######################################################################################################
Function Get-ProgrammInstalled { 
        
    [CmdletBinding()]

    <#
    .SYNOPSIS
    ������� ������ ������������� ����������� ��������� � ���� ������� � ������ ��� � ������.

    .DESCRIPTION
        ������ ������� ��������� ������� ������ ������������� ����������� ��������� � ���� ������� � ������ ��� � ������.

    .EXAMPLE
        #Get-ProgrammInstalled  ������ ������� �������  ������������� �� ��������� ���������� ����������� ��������. 
    
    #>

    param (
            
    )

    Get-WmiObject -class win32_product | Select-Object Name, Version

}

Get-ProgrammInstalled

#######################################################################################################
#9.	�������� ��������� ��� ������ ������� ���������� MS Word.
#######################################################################################################

[string]$AppProcName="WINWORD.exe"
[string]$StrQuery="select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' AND targetinstance.name='$($AppProcName)'"
$StrQuery
Register-wmievent -Query "$($StrQuery)" -sourceIdentifier "ProcessStarted" -Action { Write-Output "I am watching you!" }
