param(
    [int]$tipp1 = 0,
    [int]$tipp2 = 0,
    [int]$tipp3 = 0
)
#[string]$help paramban
#if ($help -eq "--help") {
#    "valami"
#    exit
#}

#Write-Output "Hello World"
#"ez is hello world"

$random1 = Get-Random -Minimum 1 -Maximum 10
$random2 = Get-Random -Minimum 1 -Maximum 10
$random3 = Get-Random -Minimum 1 -Maximum 10
"n: $random1 | tipp: $tipp1"
"n: $random2 | tipp: $tipp2"
"n: $random3 | tipp: $tipp3"
if ($tipp1 -eq $random1) {
    if ($tipp2 -eq $random2) {
        if ($tipp3 -eq $random3) {
            "Istenkiralycsaszar vagy, az osszeset eltalatad"
        }
        else {
            "Majdnem Istenkiralycsaszar vagy, 2-t eltalaltal"
        }
     }
     else {
        "ehhh (csak 1-et talaltal el)"
    }

}
else {
    "egyet sem talaltal el, nagyon bena vagy"
}

#powershell -ExecutionPolicy Bypass -File MyScript.ps1
#igy lehet futtatni anelkul hogy valtoztatnank az execution policyt