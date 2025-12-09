# Quick Deploy using GitHub Desktop Git
$ErrorActionPreference = "Continue"

Write-Host "Deploying to GitHub..." -ForegroundColor Green
Write-Host ""

$repoPath = Get-Location
Set-Location $repoPath

# Find GitHub Desktop Git
$possiblePaths = @(
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\GitHub Desktop\resources\app\git\cmd\git.exe"
)

$gitExe = $null
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $gitExe = $path
        break
    }
}

if (-not $gitExe) {
    Write-Host "GitHub Desktop Git not found. Opening GitHub Desktop..." -ForegroundColor Yellow
    $desktopPath = "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe"
    if (Test-Path $desktopPath) {
        Start-Process $desktopPath
        Write-Host "Please commit and push from GitHub Desktop" -ForegroundColor Cyan
    }
    exit 1
}

Write-Host "Using Git: $gitExe" -ForegroundColor Cyan
Write-Host ""

# Stage, commit, and push
& $gitExe add index.html script.js
& $gitExe commit -m "Update branding from JDR Farm to JDR"
$pushResult = & $gitExe push origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
    Write-Host "Repository: https://github.com/JDRFarm/jdrfarm-website" -ForegroundColor Cyan
    Write-Host "Live site: https://jdrfarm.com" -ForegroundColor Cyan
} else {
    Write-Host "Push failed. Trying master branch..." -ForegroundColor Yellow
    & $gitExe push origin master 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
    } else {
        Write-Host "Push failed. You may need to authenticate." -ForegroundColor Red
        Write-Host "Opening GitHub Desktop..." -ForegroundColor Yellow
        $desktopPath = "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe"
        if (Test-Path $desktopPath) {
            Start-Process $desktopPath
        }
    }
}

Write-Host ""
