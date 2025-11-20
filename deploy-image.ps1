# Deploy Image to GitHub and Netlify
# This script ensures the image file is committed and pushed

$repoPath = $PSScriptRoot
$imagePath = Join-Path $repoPath "image\download (1).jpg"

# Try to find git executable
$gitPath = $null
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "git"  # Try PATH as last resort
)

foreach ($path in $gitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $gitPath = "git"
            break
        } catch {
            continue
        }
    } elseif (Test-Path $path) {
        $gitPath = $path
        break
    }
}

if (-not $gitPath) {
    Write-Host "ERROR: Git not found. Please install Git or GitHub Desktop." -ForegroundColor Red
    Write-Host "`nPlease use GitHub Desktop to deploy:" -ForegroundColor Yellow
    Write-Host "1. Open GitHub Desktop" -ForegroundColor Yellow
    Write-Host "2. You should see the image file in changes" -ForegroundColor Yellow
    Write-Host "3. Add commit message: 'Add coconut oil product image'" -ForegroundColor Yellow
    Write-Host "4. Click 'Commit to main'" -ForegroundColor Yellow
    Write-Host "5. Click 'Push origin'" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "Deploy Image to GitHub/Netlify" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Repository: $repoPath" -ForegroundColor Cyan
Write-Host "Git: $gitPath" -ForegroundColor Cyan
Write-Host ""

# Check if image exists
if (-not (Test-Path $imagePath)) {
    Write-Host "ERROR: Image file not found!" -ForegroundColor Red
    Write-Host "Expected: $imagePath" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "✓ Image file found: image\download (1).jpg" -ForegroundColor Green
Write-Host ""

# Change to repository directory
Push-Location $repoPath

try {
    Write-Host "Step 1: Checking git status..." -ForegroundColor Yellow
    if ($gitPath -eq "git") {
        $status = & git status --short 2>&1
    } else {
        $status = & $gitPath status --short 2>&1
    }
    
    Write-Host "Current status:" -ForegroundColor Cyan
    if ($status) {
        Write-Host $status
    } else {
        Write-Host "  (no changes detected)" -ForegroundColor Gray
    }
    Write-Host ""
    
    Write-Host "Step 2: Adding image file..." -ForegroundColor Yellow
    if ($gitPath -eq "git") {
        & git add "image\download (1).jpg" 2>&1 | Out-Null
    } else {
        & $gitPath add "image\download (1).jpg" 2>&1 | Out-Null
    }
    Write-Host "✓ Image file added to staging" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 3: Adding updated HTML..." -ForegroundColor Yellow
    if ($gitPath -eq "git") {
        & git add index.html 2>&1 | Out-Null
    } else {
        & $gitPath add index.html 2>&1 | Out-Null
    }
    Write-Host "✓ HTML file added to staging" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 4: Committing changes..." -ForegroundColor Yellow
    $commitMessage = "Add coconut oil product image - download (1).jpg"
    if ($gitPath -eq "git") {
        $commitResult = & git commit -m $commitMessage 2>&1
    } else {
        $commitResult = & $gitPath commit -m $commitMessage 2>&1
    }
    
    if ($commitResult -match "nothing to commit" -or $commitResult -match "no changes added to commit") {
        Write-Host "  No changes to commit (may already be committed)" -ForegroundColor Gray
        Write-Host "  Checking if we need to push..." -ForegroundColor Yellow
    } else {
        Write-Host "✓ Changes committed successfully" -ForegroundColor Green
    }
    Write-Host ""
    
    Write-Host "Step 5: Pushing to GitHub..." -ForegroundColor Yellow
    if ($gitPath -eq "git") {
        $pushResult = & git push origin main 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  Trying master branch..." -ForegroundColor Yellow
            $pushResult = & git push origin master 2>&1
        }
    } else {
        $pushResult = & $gitPath push origin main 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  Trying master branch..." -ForegroundColor Yellow
            $pushResult = & $gitPath push origin master 2>&1
        }
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "SUCCESS!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "✓ Image has been pushed to GitHub!" -ForegroundColor Green
        Write-Host "✓ Netlify will automatically deploy in 1-2 minutes" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Check your site at: https://jdrfarm.com" -ForegroundColor Yellow
        Write-Host "Check Netlify: https://app.netlify.com → Deploys tab" -ForegroundColor Yellow
        Write-Host ""
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "PUSH FAILED" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Error: $pushResult" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please push manually using GitHub Desktop:" -ForegroundColor Yellow
        Write-Host "1. Open GitHub Desktop" -ForegroundColor Yellow
        Write-Host "2. You should see the changes" -ForegroundColor Yellow
        Write-Host "3. Click 'Commit to main'" -ForegroundColor Yellow
        Write-Host "4. Click 'Push origin'" -ForegroundColor Yellow
        Write-Host ""
    }
    
} catch {
    Write-Host ""
    Write-Host "ERROR: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please use GitHub Desktop to deploy manually." -ForegroundColor Yellow
} finally {
    Pop-Location
}

Write-Host ""
pause

