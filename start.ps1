param ($Path)

if ($null -eq $Path) {
    Write-Host "A command line tool organizing arbitrary files based on its last updated time into directories"
    Write-Host "Usage: $($MyInvocation.MyCommand) <Path>"
    Write-Host ""
    Write-Host "Intended to be used in a directory with Stable Diffusion Web UI"
}
elseif (Test-Path $Path) {
    foreach ($x in $(Get-ChildItem -Path $Path -Filter "*.png") ) {
        $Date = Get-ChildItem $x.FullName | Select-Object LastWriteTime | ForEach-Object { $_.LastWriteTime.ToString("yyyy-MM-dd") }
        $NewDirectory = $(Join-Path -Path $Path -ChildPath $Date) # e.g. X:/dirname/yyyy-MM-dd
        if ((Test-Path $NewDirectory) -ne $true) {
            New-Item -Path $NewDirectory -ItemType Directory 
        }
        if (Test-Path $NewDirectory) {
            Move-Item -Path $x.FullName -Destination $NewDirectory
        }
    }
}
else {
    Write-Host "Error: Path not exists, or invalid string given"
}