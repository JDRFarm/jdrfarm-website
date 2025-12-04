# Direct GitHub Update Script
# Attempts to update GitHub directly using available methods

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Green
Write-Host "Direct GitHub Update" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Check if script.js is updated
if (-not (Test-Path "script.js")) {
    Write-Host "Error: script.js not found" -ForegroundColor Red
    exit 1
}

$content = Get-Content "script.js" -Raw
if ($content -notmatch "9150150932" -or $content -notmatch "sendWhatsAppMessage") {
    Write-Host "Error: script.js not updated correctly" -ForegroundColor Red
    exit 1
}

Write-Host "✓ script.js is ready with updates" -ForegroundColor Green
Write-Host ""

# Method 1: Try GitHub CLI
$ghPath = Get-Command gh -ErrorAction SilentlyContinue
if ($ghPath) {
    Write-Host "Found GitHub CLI! Using it to update..." -ForegroundColor Green
    Write-Host ""
    
    try {
        # Check if authenticated
        $authCheck = & gh auth status 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "GitHub CLI authenticated" -ForegroundColor Green
            
            # Create a temporary file with the updated function
            $updatedCode = @"
// Function to send WhatsApp message
function sendWhatsAppMessage(orderData) {
    const whatsappNumber = '9150150932';
    const orderSummary = orderData.orderDetails.split('\n').join('%0A');
    const message = `New Order Received%0A%0ACustomer: ` + encodeURIComponent(orderData.name) + `%0AEmail: ` + encodeURIComponent(orderData.email) + `%0APhone: ` + encodeURIComponent(orderData.phone) + `%0A%0ADelivery Address:%0A` + encodeURIComponent(orderData.address) + `%0A%0AOrder Details:%0A` + orderSummary + `%0A%0ATotal: ₹` + orderData.totalAmount.toFixed(2) + `%0A%0A` + (orderData.message ? 'Special Instructions: ' + encodeURIComponent(orderData.message) + '%0A' : '') + `Please process this order.`;
    
    const whatsappUrl = `https://wa.me/` + whatsappNumber + `?text=` + message;
    window.open(whatsappUrl, '_blank');
}

async function confirmPayment() {
    if (!currentOrderData) return;
    
    const processingMsg = translations[currentLang]?.payment?.processing || 'Processing your order...';
    const errorMsg = translations[currentLang]?.payment?.errorMsg || 'Order received! If email fails, please contact us at info@jdrfarm.com';
    
    // Show processing message
    const successBtn = document.getElementById('paymentSuccessBtn');
    const originalText = successBtn.textContent;
    successBtn.textContent = processingMsg;
    successBtn.disabled = true;
    
    // Send email
    try {
        const emailSent = await sendOrderEmail(currentOrderData);
        
        // Prepare order confirmation message with correct contact info
        const orderDetails = currentOrderData.orderDetails;
        const totalAmount = currentOrderData.totalAmount.toFixed(2);
        const contactPhone = '9150150932';
        const contactEmail = 'info@jdrfarm.com';
        
        const successMsg = `Thank you, ` + currentOrderData.name + `!\n\nYour order has been received:\n\n` + orderDetails + `\n\nTotal: ₹` + totalAmount + `\n\nWe'll contact you at ` + contactEmail + ` or ` + contactPhone + ` to confirm your order and delivery details.`;
        
        // Show success message
        setTimeout(() => {
            alert(successMsg);
            
            // Send WhatsApp message
            sendWhatsAppMessage(currentOrderData);
            
            // Reset form and cart
            const contactForm = document.getElementById('contactForm');
            if (contactForm) {
                contactForm.reset();
            }
            cart = [];
            updateCart();
            
            // Close modal
            closePaymentModal();
            
            // Scroll to top
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }, 1500);
    } catch (error) {
        console.error('Error sending email:', error);
        // Still show success as order is recorded
        alert('Order received! ' + errorMsg);
        successBtn.textContent = originalText;
        successBtn.disabled = false;
    }
}
"@
            
            # Use gh to create a commit
            Write-Host "Creating commit via GitHub CLI..." -ForegroundColor Yellow
            & gh repo view JDRFarm/jdrfarm-website 2>&1 | Out-Null
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Repository accessible via GitHub CLI" -ForegroundColor Green
                # Note: GitHub CLI doesn't directly edit files, need to use git
            }
        } else {
            Write-Host "GitHub CLI not authenticated. Run: gh auth login" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "GitHub CLI error: $_" -ForegroundColor Yellow
    }
}

# Method 2: Try Git directly
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
    Write-Host "Attempting direct push..." -ForegroundColor Yellow
    Write-Host ""
    
    try {
        # Stage file
        Write-Host "Staging script.js..." -ForegroundColor Cyan
        & $gitPath add script.js 2>&1 | Out-Host
        
        # Commit
        Write-Host "Committing..." -ForegroundColor Cyan
        $commitResult = & $gitPath commit -m "Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification" 2>&1
        $commitResult | Out-Host
        
        if ($commitResult -match "nothing to commit") {
            Write-Host "No changes to commit. Checking if already pushed..." -ForegroundColor Yellow
        } else {
            Write-Host "✓ Committed successfully" -ForegroundColor Green
        }
        
        # Push
        Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
        $pushResult = & $gitPath push origin main 2>&1
        if ($LASTEXITCODE -ne 0) {
            $pushResult = & $gitPath push origin master 2>&1
        }
        $pushResult | Out-Host
        
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
            Start-Sleep -Seconds 2
            Start-Process "https://app.netlify.com"
            exit 0
        } else {
            Write-Host ""
            Write-Host "Push may require authentication." -ForegroundColor Yellow
            Write-Host "Error: $pushResult" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# If all methods fail, provide final instructions
Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Manual Update Required" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Could not automatically push to GitHub." -ForegroundColor Cyan
Write-Host "Opening GitHub editor for manual update..." -ForegroundColor Cyan
Write-Host ""

Start-Process "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"
Start-Sleep -Seconds 2
Start-Process notepad.exe -ArgumentList "$PSScriptRoot\CODE_TO_PASTE.txt"

Write-Host "GitHub editor and code file opened!" -ForegroundColor Green
Write-Host ""
Write-Host "Quick steps:" -ForegroundColor Cyan
Write-Host "1. Find: async function confirmPayment()" -ForegroundColor White
Write-Host "2. Replace with code from Notepad" -ForegroundColor White
Write-Host "3. Commit changes" -ForegroundColor White
Write-Host "4. Netlify auto-deploys!" -ForegroundColor Green
Write-Host ""

