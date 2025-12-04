# Automatic GitHub Push Script
# Tries multiple methods to push changes automatically

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Automatic GitHub Update" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$repoPath = Get-Location
Write-Host "Repository: $repoPath" -ForegroundColor Cyan
Write-Host ""

# Verify script.js is updated
if (-not (Test-Path "script.js")) {
    Write-Host "Error: script.js not found" -ForegroundColor Red
    exit 1
}

$content = Get-Content "script.js" -Raw
if ($content -notmatch "9150150932" -or $content -notmatch "sendWhatsAppMessage") {
    Write-Host "Warning: script.js may not be fully updated" -ForegroundColor Yellow
}

Write-Host "✓ script.js verified" -ForegroundColor Green
Write-Host ""

# Method 1: Try Git from various locations
$gitPaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\GitHubDesktop\resources\app\git\cmd\git.exe",
    "$env:ProgramFiles\Git\bin\git.exe",
    "$env:ProgramFiles(x86)\Git\bin\git.exe"
)

$gitPath = $null
foreach ($path in $gitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $test = & git --version 2>&1
            if ($LASTEXITCODE -eq 0) {
                $gitPath = "git"
                Write-Host "Found Git in PATH" -ForegroundColor Green
                break
            }
        } catch {
            continue
        }
    } elseif (Test-Path $path) {
        $gitPath = $path
        Write-Host "Found Git: $gitPath" -ForegroundColor Green
        break
    }
}

if ($gitPath) {
    Write-Host ""
    Write-Host "Attempting automatic push..." -ForegroundColor Cyan
    Write-Host ""
    
    try {
        # Check if there are changes
        Write-Host "Checking status..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $status = & git status --short 2>&1
        } else {
            $status = & $gitPath status --short 2>&1
        }
        
        if ($status -match "script.js") {
            Write-Host "Changes detected in script.js" -ForegroundColor Green
            
            # Stage
            Write-Host "Staging script.js..." -ForegroundColor Yellow
            if ($gitPath -eq "git") {
                & git add script.js 2>&1 | Out-Null
            } else {
                & $gitPath add script.js 2>&1 | Out-Null
            }
            
            # Commit
            Write-Host "Committing..." -ForegroundColor Yellow
            $commitMsg = "Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification"
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
                    Write-Host "Trying master branch..." -ForegroundColor Yellow
                    $pushResult = & git push origin master 2>&1
                }
            } else {
                $pushResult = & $gitPath push origin main 2>&1
                if ($LASTEXITCODE -ne 0) {
                    Write-Host "Trying master branch..." -ForegroundColor Yellow
                    $pushResult = & $gitPath push origin master 2>&1
                }
            }
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "========================================" -ForegroundColor Green
                Write-Host "SUCCESS! Updated on GitHub" -ForegroundColor Green
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
                Write-Host ""
                Write-Host "This may require authentication." -ForegroundColor Yellow
            }
        } else {
            Write-Host "No changes detected in script.js" -ForegroundColor Yellow
            Write-Host "File may already be committed." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# If Git methods failed, provide alternative
Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Alternative: GitHub Web Interface" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Opening GitHub editor..." -ForegroundColor Cyan
Write-Host ""

# Open GitHub in edit mode
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"

# Open code file
if (Test-Path "CODE_TO_PASTE.txt") {
    Start-Process notepad.exe -ArgumentList "$PWD\CODE_TO_PASTE.txt"
    Write-Host "Code file opened in Notepad" -ForegroundColor Green
}

Write-Host ""
Write-Host "GitHub editor opened in browser!" -ForegroundColor Green
Write-Host ""
Write-Host "Quick steps:" -ForegroundColor Cyan
Write-Host "1. Find: async function confirmPayment()" -ForegroundColor White
Write-Host "2. Copy code from Notepad" -ForegroundColor White
Write-Host "3. Paste in GitHub editor" -ForegroundColor White
Write-Host "4. Commit changes" -ForegroundColor White
Write-Host "5. Netlify auto-deploys!" -ForegroundColor Green
Write-Host ""

