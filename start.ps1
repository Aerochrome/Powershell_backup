$confPath = "$($PSScriptRoot)\\config.json"
$tmpPath = "$($PSScriptRoot)\\tmp"

if (!(Test-Path $confPath)) {
    Write-Host -ForegroundColor Red "[ERROR] No config file found!"
    return
}

$config = Get-Content $confPath | ConvertFrom-Json

function backupToTargetPath([String] $source, [String] $targetPath) {
    if (!(Test-Path $source)) {
        Write-Host -ForegroundColor Red "[ERROR] Source '$($source)' does not exist!"
        return
    }

    if (!(Test-Path $targetPath)) {
        Write-Host -ForegroundColor Red "[ERROR] Target path '$($targetPath)' does not exist!"
        return
    }

    Write-Host "Start to copy Backup to '$($targetPath)'"
    copy $source $targetPath
    Write-Host -ForegroundColor Green "Copied Backup to '$($targetPath)' !"
} 

if (!(Test-Path $config.sourcePath)) {
    Write-Host -ForegroundColor Red "[ERROR] Source '$($config.sourcePath)' does not exist!"
    return
}

if ((Test-Path $tmpPath)) {
    rm "$($tmpPath)\\*"
} else {
    mkdir $tmpPath
}

$zipPath = "$($tmpPath)\\Backup_7dtd-$(get-date -f yyyy-MM-dd--HHmmss).zip"
Compress-Archive -Path $config.sourcePath -DestinationPath $zipPath

$config.targetPath | ForEach-Object {backupToTargetPath $zipPath $_}

