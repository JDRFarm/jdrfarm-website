@echo off
echo ========================================
echo Netlify Issue Diagnostic Tool
echo ========================================
echo.
echo This will help you identify the Netlify issue.
echo.
echo Opening Netlify dashboard...
start https://app.netlify.com
timeout /t 2
echo.
echo Opening GitHub repository...
start https://github.com/JDRFarm/jdrfarm-website
timeout /t 2
echo.
echo ========================================
echo DIAGNOSTIC CHECKLIST
echo ========================================
echo.
echo Please check these in Netlify:
echo.
echo 1. SITE EXISTS?
echo    - Do you see your site in the list?
echo    - If NO: Click "Add new site" ^> "Import from GitHub"
echo.
echo 2. DEPLOYMENT STATUS?
echo    - Click on your site
echo    - Go to "Deploys" tab
echo    - What does latest deployment show?
echo    - Green = Success
echo    - Red = Failed (click to see error)
echo    - Yellow = Building
echo.
echo 3. GITHUB CONNECTED?
echo    - Site settings ^> Build ^& deploy ^> Continuous Deployment
echo    - Should show: GitHub connected
echo    - If NO: Click "Link repository"
echo.
echo 4. BUILD SETTINGS?
echo    - Site settings ^> Build ^& deploy ^> Build settings
echo    - Build command: (should be empty)
echo    - Publish directory: / (should be forward slash)
echo    - Branch: main
echo.
echo 5. DOMAIN CONFIGURED?
echo    - Site settings ^> Domain management
echo    - Should see: jdrfarm.com
echo    - Status should be: Active or Provisioning
echo.
echo 6. AUTO-PUBLISH ENABLED?
echo    - Site settings ^> Build ^& deploy
echo    - Auto-publish toggle should be ON
echo.
echo ========================================
echo COMMON ERRORS ^& FIXES
echo ========================================
echo.
echo ERROR: "No publish directory found"
echo FIX: Set publish directory to: /
echo.
echo ERROR: "index.html not found"
echo FIX: Ensure index.html is in root of repository
echo.
echo ERROR: "Build command failed"
echo FIX: Set build command to: (empty)
echo.
echo ERROR: "Site not found"
echo FIX: Create site in Netlify (Import from GitHub)
echo.
echo ========================================
echo For detailed help, see:
echo NETLIFY_DIAGNOSTIC.md
echo ========================================
echo.
pause

