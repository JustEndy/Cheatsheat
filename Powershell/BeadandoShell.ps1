$szavak = @{}
$inputContent = Get-Content -Path "parameter.txt" -Raw
$wordArray = $inputContent -split '\s+' | Where-Object { $_ -ne '' }

foreach ($word in $wordArray) {
    $lowerword = $word.ToLower()
    if ($szavak.ContainsKey($lowerword)) {
        $szavak[$lowerword]++
    } else {
        $szavak.Add("$lowerword",1)
    }
}

$maxind = $null
$maxért = 0

foreach ($szo in $szavak.Keys) {
    $currentszo = $szavak[$szo]
    if ($szavak[$szo] -gt $maxért) {
        $maxind = $szo
        $maxért = $szavak[$szo]
    }
}

if ($maxind -ne $null) {
    Write-Host "A legtöbbször előforduló szó az a: $maxind, $maxért alkalommal"
} else {
    Write-Host "A fájl nem létezett vagy nem tartalmazott szavakat."
}