<#
  .DESCRIPTION
    Set of modules to simplify offline domain attach process

  .NOTES
    Version:	1.0
    Author: 	Robert Taylor
    Email:  	robert.taylor@andor.com.au

  .LINK
    https://andor.com.au
#>

Function Export-ADBlob
	{
		<#
			.DESCRIPTION
				Exports AD Blob for use in offline domain attach process.
        This function is performed on a domain controller that is a member of the domain that you wish to join.
        Please note that the generated file is for single PC only.

			.EXAMPLE
				Export-ADBlob -domain andor -machine andorpc001 -path "C:\Temp\andorpc001.txt"
			 
			.PARAMETER domain
				A path to were the customers exported AD data is currently located.

			.PARAMETER machine
				Path to the dictionary list containing passwords to test against customer AD export

			.PARAMETER path
				Path to where you'd like the results to be saved to.
			 
		#>
		[CmdletBinding()]
			Param
				(
					[Parameter(Mandatory=$true)][string]$domain,
					[Parameter(Mandatory=$true)][string]$machine,
					[Parameter(Mandatory=$true)][string]$path
				)
			END
				{
					Djoin /provision /domain $domain /machine $machine /savefile $path /reuse
				}
	}

Function Import-ADBlob
	{
		<#
			.DESCRIPTION
				Joins PC to domain using ad blob file.
        This function is performed on that you wish to join to the domain.
        Once join has been completed the blob file will be deleted.

			.EXAMPLE
				Import-ADBlob -path "C:\Temp\andorpc001.txt"
			 
			.PARAMETER path
				A path to were the ad blob file is located.

		#>
		[CmdletBinding()]
			Param
				(
					[Parameter(Mandatory=$true)][string]$path
				)
			END
				{
					Djoin /requestodj /loadfile $path /windowspath $env:WINDIR /localos
				}
	}

Function Update-DomainMgmt
	{
	<#
	.DESCRIPTION
		Running this will download the latest version of Domain-Mgmt module and install it to your PC
	 
	.EXAMPLE
		Update-DomainMgmt
	 
	#>
		Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/rob89m/Domain-Mgmt/master/Install.ps1'))
	}
