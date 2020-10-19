function Invoke-SynoUniversalSearch {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[Parameter(Mandatory=$true)]
		[string] $keyword
	)

	BEGIN {
		$Parameters = @{
			api     = "SYNO.Finder.FileIndexing.Search"
			method  = "search"
			version = "1"
			fields = '["SYNOMDAcquisitionMake","SYNOMDAcquisitionModel","SYNOMDAlbum","SYNOMDAperture","SYNOMDAudioBitRate","SYNOMDAudioTrackNumber","SYNOMDAuthors","SYNOMDCodecs","SYNOMDContentCreationDate","SYNOMDContentModificationDate","SYNOMDCreator","SYNOMDDurationSecond","SYNOMDExposureTimeString","SYNOMDExtension","SYNOMDFSCreationDate","SYNOMDFSName","SYNOMDFSSize","SYNOMDISOSpeed","SYNOMDLastUsedDate","SYNOMDMediaTypes","SYNOMDMusicalGenre","SYNOMDOwnerUserID","SYNOMDOwnerUserName","SYNOMDRecordingYear","SYNOMDResolutionHeightDPI","SYNOMDResolutionWidthDPI","SYNOMDTitle","SYNOMDVideoBitRate","SYNOMDIsEncrypted"]'
			search_weight_list = '[{"field":"SYNOMDWildcard","weight":1},{"field":"SYNOMDTextContent","weight":1},{"field":"SYNOMDSearchFileName","weight":8.5,"trailing_wildcard":true}]'
			keyword = $Keyword
			agent = 'sus'
			query_serial = 2
			from = 0
			size = 11
			sorder_field = 'relevance'
			sorter_direction = 'asc'
			sorter_use_nature_sort = 'false'
			sorter_show_directory_first = 'true'
			orig_keyword = $Keyword
		}

		$WebAPIPath = "/webapi/entry.cgi?"
	}

	PROCESS {
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"
		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {
			Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession
		}
	}
}
