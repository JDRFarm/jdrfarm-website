# Quick Deploy Script - Payment Feature
# This will commit and push changes if Git is available

$ErrorActionPreference = "SilentlyContinue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Quick Deploy - Payment Feature" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check for files
$files = @("index.html", "script.js", "styles.css")
$allExist = $true
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "✓ $file" -ForegroundColor Green
    } else {
        Write-Host "✗ $file missing" -ForegroundColor Red
        $allExist = $false
    }
}

if (-not $allExist) {
    Write-Host ""
    Write-Host "Some files are missing. Cannot deploy." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "All files ready for deployment!" -ForegroundColor Green
Write-Host ""

# Try to find and use Git
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $gitPath = $path
        break
    }
}

if ($gitPath) {
    Write-Host "Found Git: $gitPath" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Staging files..." -ForegroundColor Yellow
    & $gitPath add index.html script.js styles.css
    
    Write-Host "Committing..." -ForegroundColor Yellow
    & $gitPath commit -m "Add GPay/UPI QR code payment feature with email notifications"
    
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    & $gitPath push origin main 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        & $gitPath push origin master 2>&1 | Out-Null
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Netlify will auto-deploy in 1-2 minutes" -ForegroundColor Cyan
        Write-Host "Check: https://app.netlify.com" -ForegroundColor White
        Write-Host "Live: https://jdrfarm.com" -ForegroundColor White
        Start-Sleep -Seconds 2
        Start-Process "https://app.netlify.com"
    } else {
        Write-Host ""
        Write-Host "Push failed. Please use GitHub Desktop." -ForegroundColor Yellow
        Write-Host "Opening GitHub Desktop..." -ForegroundColor Cyan
        Start-Process "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe" -ErrorAction SilentlyContinue
    }
} else {
    Write-Host "Git not found in standard locations." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please use GitHub Desktop:" -ForegroundColor Cyan
    Write-Host "1. Open GitHub Desktop" -ForegroundColor White
    Write-Host "2. Select: jdrfarm-website" -ForegroundColor White
    Write-Host "3. Commit message: 'Add GPay/UPI QR code payment feature with email notifications'" -ForegroundColor White
    Write-Host "4. Click 'Commit to main'" -ForegroundColor White
    Write-Host "5. Click 'Push origin'" -ForegroundColor White
    Write-Host ""
    Write-Host "Opening GitHub Desktop..." -ForegroundColor Cyan
    Start-Process "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe" -ErrorAction SilentlyContinue
    Start-Process explorer.exe -ArgumentList (Get-Location)
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

