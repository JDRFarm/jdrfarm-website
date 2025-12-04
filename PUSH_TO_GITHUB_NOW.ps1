# Push Changes to GitHub Automatically
# Removes checkout button and payment details, sends email directly

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Push to GitHub - Order Form Update" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Verify files are updated
$filesUpdated = $true

if (-not (Test-Path "index.html")) {
    Write-Host "Error: index.html not found" -ForegroundColor Red
    $filesUpdated = $false
}

if (-not (Test-Path "script.js")) {
    Write-Host "Error: script.js not found" -ForegroundColor Red
    $filesUpdated = $false
}

if ($filesUpdated) {
    $htmlContent = Get-Content "index.html" -Raw
    $jsContent = Get-Content "script.js" -Raw
    
    # Check if checkout button is removed
    if ($htmlContent -match "checkoutButton" -or $htmlContent -match "Proceed to Checkout") {
        Write-Host "Warning: Checkout button may still exist in HTML" -ForegroundColor Yellow
    } else {
        Write-Host "✓ Checkout button removed from HTML" -ForegroundColor Green
    }
    
    # Check if payment modal is removed
    if ($htmlContent -match "paymentModal" -or $htmlContent -match "payment-modal") {
        Write-Host "Warning: Payment modal may still exist in HTML" -ForegroundColor Yellow
    } else {
        Write-Host "✓ Payment modal removed from HTML" -ForegroundColor Green
    }
    
    # Check if email sending is implemented
    if ($jsContent -match "sendOrderEmail" -and $jsContent -match "info@jdrfarm.com") {
        Write-Host "✓ Email sending to info@jdrfarm.com implemented" -ForegroundColor Green
    } else {
        Write-Host "Warning: Email functionality may be missing" -ForegroundColor Yellow
    }
    
    # Check if payment functions are removed
    if ($jsContent -match "showPaymentModal" -or $jsContent -match "generateUPIQRCode" -or $jsContent -match "sendWhatsAppMessage") {
        Write-Host "Warning: Payment functions may still exist" -ForegroundColor Yellow
    } else {
        Write-Host "✓ Payment functions removed from JavaScript" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Attempting to push to GitHub..." -ForegroundColor Cyan
Write-Host ""

# Try to find Git
$gitPaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $test = & git --version 2>&1
            if ($LASTEXITCODE -eq 0) {
                $gitPath = "git"
                break
            }
        } catch {
            continue
        }
    } elseif (Test-Path $path) {
        $gitPath = $path
        break
    }
}

if ($gitPath) {
    Write-Host "Found Git: $gitPath" -ForegroundColor Green
    Write-Host ""
    
    try {
        # Stage files
        Write-Host "Staging files..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            & git add index.html script.js 2>&1 | Out-Null
        } else {
            & $gitPath add index.html script.js 2>&1 | Out-Null
        }
        
        # Commit
        Write-Host "Committing..." -ForegroundColor Yellow
        $commitMsg = "Remove checkout button and payment details, send email directly to info@jdrfarm.com on order"
        if ($gitPath -eq "git") {
            $commitResult = & git commit -m $commitMsg 2>&1
        } else {
            $commitResult = & $gitPath commit -m $commitMsg 2>&1
        }
        
        if ($commitResult -match "nothing to commit") {
            Write-Host "No changes to commit (may already be committed)" -ForegroundColor Yellow
        } else {
            Write-Host "✓ Committed" -ForegroundColor Green
        }
        
        # Push
        Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $pushResult = & git push origin main 2>&1
            if ($LASTEXITCODE -ne 0) {
                $pushResult = & git push origin master 2>&1
            }
        } else {
            $pushResult = & $gitPath push origin main 2>&1
            if ($LASTEXITCODE -ne 0) {
                $pushResult = & $gitPath push origin master 2>&1
            }
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "========================================" -ForegroundColor Green
            Write-Host "SUCCESS! Pushed to GitHub" -ForegroundColor Green
            Write-Host "========================================" -ForegroundColor Green
            Write-Host ""
            Write-Host "Netlify is now auto-deploying!" -ForegroundColor Cyan
            Write-Host "Check: https://app.netlify.com" -ForegroundColor White
            Write-Host "Live: https://jdrfarm.com" -ForegroundColor White
            Write-Host ""
            Write-Host "Deployment takes 1-2 minutes." -ForegroundColor Yellow
            Write-Host ""
            
            Start-Sleep -Seconds 2
            Start-Process "https://app.netlify.com"
            exit 0
        } else {
            Write-Host ""
            Write-Host "Push failed:" -ForegroundColor Red
            $pushResult | Out-Host
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# If Git not found, open GitHub
Write-Host ""
Write-Host "Opening GitHub for manual update..." -ForegroundColor Yellow
Write-Host ""

Start-Process "https://github.com/JDRFarm/jdrfarm-website"
Start-Sleep -Seconds 1
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/index.html"
Start-Sleep -Seconds 1
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"

Write-Host "GitHub editors opened!" -ForegroundColor Green
Write-Host ""
Write-Host "Files to update:" -ForegroundColor Cyan
Write-Host "1. index.html - Remove checkout button and payment modal" -ForegroundColor White
Write-Host "2. script.js - Remove payment functions, update order form" -ForegroundColor White
Write-Host ""
Write-Host "Commit message:" -ForegroundColor Cyan
Write-Host "Remove checkout button and payment details, send email directly to info@jdrfarm.com on order" -ForegroundColor White
Write-Host ""

