﻿function Clear-SYNOFSFavoriteStatus {
	<#
	.SYNOPSIS
	Delete all favourites with broken status.

	.DESCRIPTION
	Invokes the "clear_broken" method of SYNO.FileStation.Favorite

	.EXAMPLE
	Clear-SYNOFSFavoriteStatus

	Deletes all favourites with status of broken.

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
			method  = "clear_broken"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response
		}

	}#process

	END { }#end

}