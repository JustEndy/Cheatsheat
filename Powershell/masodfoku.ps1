#Irj masodfoku egyenelet megoldokepletet T-T
<#if($args.Count -ne 3){
    "hibas hasznalat, hasznalat: <a> <b> <c>"
    exit
}#>
$a=[double](Read-Host "adj a-t")
$b=[double](Read-Host "adj b-t")
$c=[double](Read-Host "adj c-t")

#$D - diszkriminans kulon  es megnezni hogy nagyobb e mint 0
$D = ( $b * $b ) - ( 4 * $a * $c)
if ( $D -lt 0){
    $real = (-$b) / (2 * $a)
    $imag = [math]::Sqrt(-$D) / (2*$a)
    $mo1="$real + ${imag}i"
    $mo2="$real - ${imag}i"
}
else{
    $mo1=((-$b) + [Math]::Sqrt($D) ) / (2 * $a)
    $mo2=((-$b) - [Math]::Sqrt($D) ) / (2 * $a)
}
"x1 = $mo1"
"x2 = $mo2"
