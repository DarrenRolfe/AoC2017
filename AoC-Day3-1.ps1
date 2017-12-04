$target = 312051
#$target = 49
$value = 1
$incvalue = 1
$incjumps = 0
$a =""

do {
    $incjumps++
    $oldvalue = $value
    $value += $incvalue
    Write-Host "JUMP $incjumps | INC: $incvalue | VALUE: $value"
    $check = $incjumps/2
    if ([int32]::TryParse($check,[ref]$a)) {
        $incvalue++
    }
} until ($value -gt $target)

Write-Host "Target ($target) in jump $incjumps"



$midwaysteps = [math]::Ceiling($incvalue/2)
Write-Host "MIDWAY: $midwaysteps"

if ($midwaysteps -ne $incvalue/2) {
    $oldvalue--
}

$working = $oldvalue + $midwaysteps
if ($working -gt $target) {
    $steps = 0
    do {
        $target++
        $steps++
    } until ($target -eq $working)
} elseif ($working -eq $target) {
    $steps = 0
} else {
    $steps = 0
    do {
        $target--
        $steps++
    } until ($target -eq $working)
}

Write-Host "$steps steps along line"



$directjumps = [math]::Ceiling(($incjumps-1)/4)

Write-Host "$directjumps direct jumps"

$total = $steps + $directjumps

Write-Host "TOTAL: $total moves required"
