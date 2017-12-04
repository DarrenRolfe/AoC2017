# array lengths ref previous arrays

$target = 312051
#$target = 49
$value = 1
$incvalue = 1
$incjumps = 0
$a = ""

do {
    $incjumps++
    foreach ($step in $incvalue) {
        $value = $jumpray[$step-1]
        $jumpray[$step] = $value,
    }
    $check = $incjumps/2
    if ([int32]::TryParse($check,[ref]$a)) {
        $incvalue++
    }
} until ($value -gt $target)

Write-Host "TARGET: $target | VALUE: $value | JUMP: $incjumps | JUMP INC: $incvalue"


 if $incjumps