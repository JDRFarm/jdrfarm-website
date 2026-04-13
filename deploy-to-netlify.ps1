# Direct Netlify Deployment Script
# This will attempt to deploy directly to Netlify

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Deploy to Netlify - Payment Feature" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check if Netlify CLI is available
$netlifyCLI = Get-Command netlify -ErrorAction SilentlyContinue

if ($netlifyCLI) {
    Write-Host "Netlify CLI found!" -ForegroundColor Green
    Write-Host "Deploying to Netlify..." -ForegroundColor Yellow
    Write-Host ""
    
    # Try to deploy
    netlify deploy --prod --dir=.
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "SUCCESS! Deployed to Netlify" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Your site is live!" -ForegroundColor Cyan
        Start-Process "https://app.netlify.com"
        exit 0
    }
}

# If Netlify CLI not available, try GitHub push which triggers Netlify
Write-Host "Netlify CLI not found. Using GitHub push method..." -ForegroundColor Yellow
Write-Host ""

# Try to find Git
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
    Write-Host "Found Git: $gitPath" -ForegroundColor Green
    Write-Host ""
    Write-Host "Pushing to GitHub (this triggers Netlify auto-deploy)..." -ForegroundColor Yellow
    
    & $gitPath add index.html script.js styles.css
    & $gitPath commit -m "Order on WhatsApp with delivery address and cart details" 2>&1 | Out-Host
    & $gitPath push origin main 2>&1 | Out-Host
    
    if ($LASTEXITCODE -ne 0) {
        & $gitPath push origin master 2>&1 | Out-Host
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "SUCCESS! Pushed to GitHub" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Netlify will auto-deploy in 1-2 minutes!" -ForegroundColor Cyan
        Write-Host "Check: https://app.netlify.com" -ForegroundColor White
        Start-Sleep -Seconds 2
        Start-Process "https://app.netlify.com"
        exit 0
    }
}

# Final fallback - open GitHub Desktop
Write-Host ""
Write-Host "Opening GitHub Desktop for manual push..." -ForegroundColor Yellow
Write-Host "Once pushed, Netlify will auto-deploy automatically!" -ForegroundColor Cyan
Write-Host ""

Start-Process "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe" -ErrorAction SilentlyContinue
Start-Process explorer.exe -ArgumentList (Get-Location)
Start-Process "https://app.netlify.com"

Write-Host "Instructions:" -ForegroundColor Cyan
Write-Host "1. In GitHub Desktop: Select jdrfarm-website" -ForegroundColor White
Write-Host "2. Commit message: 'Order on WhatsApp with delivery address and cart details'" -ForegroundColor White
Write-Host "3. Click 'Commit to main' then 'Push origin'" -ForegroundColor White
Write-Host "4. Netlify will auto-deploy!" -ForegroundColor Green
Write-Host ""

