function Invoke-SynoUniversalSearch {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[Parameter(Mandatory=$true)]
		[string] $keyword,

		[int] $From = 0,
		[int] $PageSize = 100,
		[string[]] $Fields
	)

	BEGIN {
		if (!$Fields) {
			$Fields = AcquisitionMake AcquisitionModel Album Aperture AudioBitRate AudioTrackNumber Authors Codecs ContentCreationDate ContentModificationDate Creator DurationSecond ExposureTimeString Extension FSCreationDate FSName FSSize ISOSpeed LastUsedDate MediaTypes MusicalGenre OwnerUserID OwnerUserName RecordingYear ResolutionHeightDPI ResolutionWidthDPI Title VideoBitRate IsEncrypted
		}

		$Parameters = @{
			api     = "SYNO.Finder.FileIndexing.Search"
			method  = "search"
			version = "1"
			fields = ConvertTo-Json -Compress ($Fields | % { "SYNOMD$_" })
			search_weight_list = '[{"field":"SYNOMDWildcard","weight":1},{"field":"SYNOMDTextContent","weight":1},{"field":"SYNOMDSearchFileName","weight":8.5,"trailing_wildcard":true}]'
			keyword = $Keyword
			agent = 'sus'
			query_serial = 2
			from = $From
			size = $PageSize
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
