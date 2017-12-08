[string[]]$array = "b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
" -split "`n";

[string[]]$var = @()
[string[]]$vv = @()

foreach ($line in $array) {
    $var += ($line -split " ")[0].trim()
    $vv += 0
}

$n = 0
foreach ($line in $var) {
    Write-Host $var[$n],":",$vv[$n]
    $n++
}