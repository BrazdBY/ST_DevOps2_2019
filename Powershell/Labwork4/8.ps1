# 8.	������� ����-�������� ������ ������ ������������� ����������� ��������� � ���� ������� � ������ ��� � ������.

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

