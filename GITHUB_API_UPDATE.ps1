# GitHub API Update Script
# This will update the file directly via GitHub API

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "GitHub API Update" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Read the updated script.js
if (-not (Test-Path "script.js")) {
    Write-Host "Error: script.js not found" -ForegroundColor Red
    exit 1
}

$fileContent = Get-Content "script.js" -Raw -Encoding UTF8
$base64Content = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($fileContent))

Write-Host "File content prepared" -ForegroundColor Green
Write-Host ""

# GitHub API endpoint
$repo = "JDRFarm/jdrfarm-website"
$filePath = "script.js"
$branch = "main"

# Try to get current file SHA (requires authentication)
Write-Host "To update via GitHub API, you need:" -ForegroundColor Yellow
Write-Host "1. GitHub Personal Access Token" -ForegroundColor White
Write-Host "2. Or use GitHub Desktop/Git" -ForegroundColor White
Write-Host ""

# Alternative: Open GitHub with pre-filled content
Write-Host "Opening GitHub editor with instructions..." -ForegroundColor Cyan
Write-Host ""

# Open GitHub in edit mode
Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"

# Open the code file
if (Test-Path "CODE_TO_PASTE.txt") {
    Start-Process notepad.exe -ArgumentList "$PWD\CODE_TO_PASTE.txt"
    Write-Host "✓ Code file opened in Notepad" -ForegroundColor Green
}

# Also open a helper script
Write-Host ""
Write-Host "Since Git is not available, here's the easiest way:" -ForegroundColor Cyan
Write-Host ""
Write-Host "OPTION 1: GitHub Web Editor (Easiest)" -ForegroundColor Yellow
Write-Host "1. GitHub editor is open in your browser" -ForegroundColor White
Write-Host "2. Copy code from Notepad (CODE_TO_PASTE.txt)" -ForegroundColor White
Write-Host "3. Find: async function confirmPayment()" -ForegroundColor White
Write-Host "4. Replace with code from Notepad" -ForegroundColor White
Write-Host "5. Commit changes" -ForegroundColor White
Write-Host ""
Write-Host "OPTION 2: Install Git for automatic updates" -ForegroundColor Yellow
Write-Host "Download: https://git-scm.com/download/win" -ForegroundColor White
Write-Host ""

Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

