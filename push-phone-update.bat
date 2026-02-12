@echo off
echo ========================================
echo Push Phone Number Update to GitHub
echo ========================================
echo.
echo Changes made:
echo - Updated phone number: 9150150932 -^> 9150830025
echo - Updated WhatsApp links: 919150150932 -^> 919150830025
echo.
echo ========================================
echo Method: Using GitHub Desktop
echo ========================================
echo.
echo Please follow these steps:
echo.
echo 1. Open GitHub Desktop
echo 2. The repository should already be open (jdrfarm-website)
echo 3. You should see index.html in "Changes" (modified)
echo.
echo 4. At the bottom, in "Summary" field, type:
echo    "Update phone number to 9150830025"
echo.
echo 5. Click "Commit to main" button
echo.
echo 6. Click "Push origin" button (top right)
echo.
echo 7. Wait for push to complete
echo.
echo ========================================
echo Your changes will be live on GitHub!
echo ========================================
echo.
echo Opening GitHub Desktop...
start "" "C:\Users\%USERNAME%\AppData\Local\GitHubDesktop\GitHubDesktop.exe"
timeout /t 3
echo.
pause

