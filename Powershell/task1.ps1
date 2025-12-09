#1 feladat --help
param(
    [switch]$help
)
if ($help) { Show-Help; exit }
function Show-Help {
    "This application does sg"
}