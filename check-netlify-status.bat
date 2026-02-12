@echo off
echo ========================================
echo Netlify Deployment Status Check
echo ========================================
echo.
echo This will help you check why your repo is not deploying to the domain.
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
echo CHECKLIST - Follow these steps:
echo ========================================
echo.
echo 1. In Netlify Dashboard:
echo    - Check if your site exists
echo    - If not, click "Add new site" ^> "Import from GitHub"
echo    - Select repository: jdrfarm-website
echo.
echo 2. Check GitHub Connection:
echo    - Site settings ^> Build ^& deploy ^> Continuous Deployment
echo    - Should show: GitHub connected
echo    - If not, click "Link repository"
echo.
echo 3. Check Domain:
echo    - Site settings ^> Domain management
echo    - Should see: jdrfarm.com
echo    - If not, click "Add custom domain"
echo.
echo 4. Check Deployment Status:
echo    - Go to "Deploys" tab
echo    - Latest deployment should show: Published
echo    - If failed, click on it to see error
echo.
echo 5. Check DNS (in GoDaddy):
echo    - A record: @ ^> 75.2.60.5
echo    - CNAME: www ^> your-site-name.netlify.app
echo.
echo ========================================
echo For detailed instructions, see:
echo FIX_DEPLOYMENT_ISSUE.md
echo ========================================
echo.
pause

