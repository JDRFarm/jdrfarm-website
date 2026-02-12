# Check Netlify Deployment Status and Fix Issues
# This script checks why the repo is not deploying to the domain

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Netlify Deployment Diagnostic Tool" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Step 1: Check if Netlify CLI is installed
Write-Host "Step 1: Checking Netlify CLI..." -ForegroundColor Cyan
$netlifyCLI = Get-Command netlify -ErrorAction SilentlyContinue

if ($netlifyCLI) {
    Write-Host "✓ Netlify CLI found!" -ForegroundColor Green
    Write-Host ""
    
    # Check if logged in
    Write-Host "Checking Netlify login status..." -ForegroundColor Yellow
    $loginStatus = & netlify status 2>&1
    
    if ($loginStatus -match "Logged in" -or $loginStatus -match "You are logged in") {
        Write-Host "✓ Already logged in to Netlify!" -ForegroundColor Green
        $loggedIn = $true
    } else {
        Write-Host "⚠ Not logged in to Netlify" -ForegroundColor Yellow
        Write-Host "Logging in to Netlify..." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "A browser window will open for authentication..." -ForegroundColor Cyan
        Start-Sleep -Seconds 2
        
        & netlify login
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Successfully logged in to Netlify!" -ForegroundColor Green
            $loggedIn = $true
        } else {
            Write-Host "✗ Failed to log in. Please log in manually." -ForegroundColor Red
            $loggedIn = $false
        }
    }
    
    Write-Host ""
    
    if ($loggedIn) {
        # Check site status
        Write-Host "Step 2: Checking site status..." -ForegroundColor Cyan
        $siteStatus = & netlify status 2>&1
        Write-Host $siteStatus
        
        # List sites
        Write-Host ""
        Write-Host "Step 3: Listing your Netlify sites..." -ForegroundColor Cyan
        & netlify sites:list
        
        Write-Host ""
        Write-Host "Step 4: Checking deployment status..." -ForegroundColor Cyan
        & netlify deploy:list --json 2>&1 | ConvertFrom-Json | Select-Object -First 5 | Format-Table
        
    }
} else {
    Write-Host "✗ Netlify CLI not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Netlify CLI..." -ForegroundColor Yellow
    
    # Check if npm is available
    $npm = Get-Command npm -ErrorAction SilentlyContinue
    if ($npm) {
        Write-Host "Installing via npm..." -ForegroundColor Yellow
        & npm install -g netlify-cli
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Netlify CLI installed!" -ForegroundColor Green
            Write-Host "Please run this script again." -ForegroundColor Yellow
        } else {
            Write-Host "✗ Failed to install Netlify CLI" -ForegroundColor Red
        }
    } else {
        Write-Host "✗ npm not found. Cannot install Netlify CLI automatically." -ForegroundColor Red
        Write-Host ""
        Write-Host "Please install Netlify CLI manually:" -ForegroundColor Yellow
        Write-Host "1. Install Node.js: https://nodejs.org" -ForegroundColor White
        Write-Host "2. Run: npm install -g netlify-cli" -ForegroundColor White
        Write-Host "3. Or download from: https://cli.netlify.com" -ForegroundColor White
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Step 5: Checking GitHub Connection" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check Git repository
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
    Write-Host "✓ Git found: $gitPath" -ForegroundColor Green
    Write-Host ""
    
    # Check if this is a git repo
    if ($gitPath -eq "git") {
        $isRepo = & git rev-parse --git-dir 2>&1
    } else {
        $isRepo = & $gitPath rev-parse --git-dir 2>&1
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ This is a Git repository" -ForegroundColor Green
        
        # Check remote
        Write-Host ""
        Write-Host "Checking remote repository..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $remote = & git remote -v 2>&1
        } else {
            $remote = & $gitPath remote -v 2>&1
        }
        Write-Host $remote
        
        # Check current branch
        Write-Host ""
        Write-Host "Checking current branch..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $branch = & git branch --show-current 2>&1
        } else {
            $branch = & $gitPath branch --show-current 2>&1
        }
        Write-Host "Current branch: $branch" -ForegroundColor Cyan
        
        # Check if there are uncommitted changes
        Write-Host ""
        Write-Host "Checking for uncommitted changes..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $status = & git status --short 2>&1
        } else {
            $status = & $gitPath status --short 2>&1
        }
        
        if ($status) {
            Write-Host "⚠ You have uncommitted changes:" -ForegroundColor Yellow
            Write-Host $status
            Write-Host ""
            Write-Host "These changes need to be committed and pushed for Netlify to deploy them." -ForegroundColor Yellow
        } else {
            Write-Host "✓ No uncommitted changes" -ForegroundColor Green
        }
        
        # Check last commit
        Write-Host ""
        Write-Host "Checking last commit..." -ForegroundColor Yellow
        if ($gitPath -eq "git") {
            $lastCommit = & git log -1 --oneline 2>&1
        } else {
            $lastCommit = & $gitPath log -1 --oneline 2>&1
        }
        Write-Host "Last commit: $lastCommit" -ForegroundColor Cyan
        
    } else {
        Write-Host "✗ This is not a Git repository" -ForegroundColor Red
        Write-Host "Initialize with: git init" -ForegroundColor Yellow
    }
} else {
    Write-Host "✗ Git not found" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Step 6: Checking Netlify Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check netlify.toml
if (Test-Path "netlify.toml") {
    Write-Host "✓ netlify.toml found" -ForegroundColor Green
    $netlifyConfig = Get-Content "netlify.toml" -Raw
    Write-Host "Configuration:" -ForegroundColor Yellow
    Write-Host $netlifyConfig
} else {
    Write-Host "⚠ netlify.toml not found" -ForegroundColor Yellow
    Write-Host "This is optional but recommended for custom settings" -ForegroundColor White
}

# Check CNAME
if (Test-Path "CNAME") {
    Write-Host ""
    Write-Host "✓ CNAME file found" -ForegroundColor Green
    $cname = Get-Content "CNAME" -Raw
    Write-Host "Domain: $cname" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "⚠ CNAME file not found" -ForegroundColor Yellow
    Write-Host "This is needed for custom domain setup" -ForegroundColor White
}

# Check _redirects
if (Test-Path "_redirects") {
    Write-Host ""
    Write-Host "✓ _redirects file found" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠ _redirects file not found" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Step 7: Recommendations" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "To fix deployment issues:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Ensure you're logged in to Netlify:" -ForegroundColor White
Write-Host "   - Run: netlify login" -ForegroundColor Cyan
Write-Host "   - Or visit: https://app.netlify.com" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Link your site to Netlify:" -ForegroundColor White
Write-Host "   - Run: netlify link" -ForegroundColor Cyan
Write-Host "   - Or connect via Netlify dashboard" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Ensure GitHub is connected:" -ForegroundColor White
Write-Host "   - Go to: https://app.netlify.com" -ForegroundColor Cyan
Write-Host "   - Site settings → Build & deploy → Continuous Deployment" -ForegroundColor Cyan
Write-Host "   - Verify GitHub repository is linked" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Push changes to GitHub:" -ForegroundColor White
Write-Host "   - Commit all changes" -ForegroundColor Cyan
Write-Host "   - Push to main/master branch" -ForegroundColor Cyan
Write-Host "   - Netlify will auto-deploy" -ForegroundColor Cyan
Write-Host ""
Write-Host "5. Check deployment status:" -ForegroundColor White
Write-Host "   - Visit: https://app.netlify.com" -ForegroundColor Cyan
Write-Host "   - Check Deploys tab" -ForegroundColor Cyan
Write-Host "   - Look for errors in deployment logs" -ForegroundColor Cyan
Write-Host ""

# Open Netlify dashboard
Write-Host "Opening Netlify dashboard..." -ForegroundColor Yellow
Start-Process "https://app.netlify.com"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Diagnostic Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

