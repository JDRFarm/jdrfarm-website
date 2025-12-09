# Deploy to GitHub via API
# Requires GitHub Personal Access Token

param(
    [string]$GitHubToken = $env:GITHUB_TOKEN
)

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Deploy to GitHub via API" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

if (-not $GitHubToken) {
    Write-Host "GitHub Token not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "To use automatic deployment, you need a GitHub Personal Access Token:" -ForegroundColor Yellow
    Write-Host "1. Go to: https://github.com/settings/tokens" -ForegroundColor White
    Write-Host "2. Click 'Generate new token (classic)'" -ForegroundColor White
    Write-Host "3. Select scope: 'repo' (full control of private repositories)" -ForegroundColor White
    Write-Host "4. Copy the token" -ForegroundColor White
    Write-Host "5. Set environment variable: `$env:GITHUB_TOKEN = 'your-token'" -ForegroundColor White
    Write-Host ""
    Write-Host "Or run: deploy-via-api.ps1 -GitHubToken 'your-token-here'" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Opening GitHub web interface as fallback..." -ForegroundColor Yellow
    Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/index.html"
    Start-Sleep -Seconds 2
    Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"
    exit 1
}

$repo = "JDRFarm/jdrfarm-website"
$branch = "main"

# Read files
$indexContent = Get-Content "index.html" -Raw -Encoding UTF8
$scriptContent = Get-Content "script.js" -Raw -Encoding UTF8

# Function to get file SHA
function Get-FileSHA {
    param($filePath)
    $uri = "https://api.github.com/repos/$repo/contents/$filePath?ref=$branch"
    $headers = @{
        "Authorization" = "token $GitHubToken"
        "Accept" = "application/vnd.github.v3+json"
    }
    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        return $response.sha
    } catch {
        return $null
    }
}

# Function to update file
function Update-File {
    param($filePath, $content, $message)
    $sha = Get-FileSHA -filePath $filePath
    $base64Content = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($content))
    
    $body = @{
        message = $message
        content = $base64Content
        branch = $branch
    }
    
    if ($sha) {
        $body.sha = $sha
    }
    
    $uri = "https://api.github.com/repos/$repo/contents/$filePath"
    $headers = @{
        "Authorization" = "token $GitHubToken"
        "Accept" = "application/vnd.github.v3+json"
    }
    
    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Put -Body ($body | ConvertTo-Json)
        return $true
    } catch {
        Write-Host "Error updating $filePath : $_" -ForegroundColor Red
        return $false
    }
}

Write-Host "Updating index.html..." -ForegroundColor Yellow
$result1 = Update-File -filePath "index.html" -content $indexContent -message "Update branding from JDR Farm to JDR"

Write-Host "Updating script.js..." -ForegroundColor Yellow
$result2 = Update-File -filePath "script.js" -content $scriptContent -message "Update branding from JDR Farm to JDR"

if ($result1 -and $result2) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "SUCCESS! Deployed to GitHub" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Repository: https://github.com/$repo" -ForegroundColor Cyan
    Write-Host "Live site: https://jdrfarm.com" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Changes will auto-deploy via Netlify/GitHub Pages" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Some files failed to update. Check errors above." -ForegroundColor Red
    Write-Host ""
}

