# Get all Store Apps
$packages = Get-AppxPackage | 
                Where-Object { $_.SignatureKind -eq "Store" -and
                                    (-not $_.IsFramework) -and
                                    (-not $_.NonRemovable) -and
                                    $_.Name -notlike "Microsoft.MSPaint" -and
                                    $_.Name -notlike "Microsoft.WindowsStore" -and
                                    $_.Name -notlike "Microsoft.WindowsCalculator"}

$packages | Remove-AppxPackage -Confirm:$false
