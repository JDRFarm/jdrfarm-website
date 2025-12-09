# Final Deploy Script - Uses GitHub Desktop Git
$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Deploy to GitHub" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$repoPath = Get-Location
Set-Location $repoPath

# Find GitHub Desktop Git
$gitHubPath = "C:\Users\dell12\AppData\Local\GitHubDesktop"
$gitExe = Get-ChildItem "$gitHubPath" -Recurse -Filter "git.exe" -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName

if (-not $gitExe) {
    Write-Host "Git not found. Opening GitHub Desktop..." -ForegroundColor Yellow
    $desktopExe = "$gitHubPath\GitHubDesktop.exe"
    if (Test-Path $desktopExe) {
        Start-Process $desktopExe
    }
    Write-Host "Please use GitHub Desktop to commit and push" -ForegroundColor Cyan
    exit 1
}

Write-Host "Using Git: $gitExe" -ForegroundColor Cyan
Write-Host ""

# Stage files
Write-Host "Staging files..." -ForegroundColor Yellow
& $gitExe add index.html script.js 2>&1 | Out-Null
Write-Host "✓ Files staged" -ForegroundColor Green

# Commit
Write-Host "Committing changes..." -ForegroundColor Yellow
$commitResult = & $gitExe commit -m "Update branding from JDR Farm to JDR" 2>&1
if ($commitResult -match "nothing to commit") {
    Write-Host "No changes to commit" -ForegroundColor Yellow
} else {
    Write-Host "✓ Committed" -ForegroundColor Green
}

# Push
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "(You may need to authenticate in your browser)" -ForegroundColor Cyan
Write-Host ""

$pushResult = & $gitExe push origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Repository: https://github.com/JDRFarm/jdrfarm-website" -ForegroundColor Cyan
    Write-Host "Live site: https://jdrfarm.com" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Changes will auto-deploy via Netlify/GitHub Pages" -ForegroundColor Yellow
    Write-Host "Deployment takes 1-2 minutes" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Push requires authentication" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Cyan
    Write-Host "1. Complete authentication in the browser window that opened" -ForegroundColor White
    Write-Host "2. Or use GitHub Desktop to push:" -ForegroundColor White
    Write-Host "   - Open GitHub Desktop" -ForegroundColor White
    Write-Host "   - Select repository: jdrfarm-website" -ForegroundColor White
    Write-Host "   - Click 'Push origin' button" -ForegroundColor White
    Write-Host ""
    
    # Open GitHub Desktop
    $desktopExe = "$gitHubPath\GitHubDesktop.exe"
    if (Test-Path $desktopExe) {
        Write-Host "Opening GitHub Desktop..." -ForegroundColor Cyan
        Start-Process $desktopExe
    }
}

Write-Host ""

