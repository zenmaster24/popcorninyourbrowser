Param (
    [Parameter(Mandatory=$True)]
		[string[]]$orderby
)

$Movies = (Invoke-WebRequest http://popcorninyourbrowser.net/js/movies.js).Content
$HeaderPattern = '(?i){(.*?)}'

$MovieArray= @()

$Movies = ([regex]$HeaderPattern).Matches($Movies)|ConvertFrom-Json

Foreach ($Movie in $Movies){
    $MovieList = New-Object -TypeName PSObject
    $MovieList | Add-Member -Type NoteProperty -Name Title -value $Movie.Title
    $MovieList | Add-Member -Type NoteProperty -Name Year -value $Movie.Year
    $MovieList | Add-Member -Type NoteProperty -Name Cover -value $Movie.Cover
    
    $MovieArray += $MovieList
}

$MovieArray | Sort -Property $OrderBy | ft -AutoSize
"$($moviearray.count) movies found."