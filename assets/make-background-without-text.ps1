# Fills the central logo/text band by stretching a strip from the upper sky/grove area.
# Requires Windows PowerShell and .NET (System.Drawing). Tune $Src* and $Dst* if needed.
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$srcPath = Join-Path $here "palmyra-label-original-with-text.png"
$outPath = Join-Path $here "background-palmyra-scene-no-text.png"

if (-not (Test-Path $srcPath)) {
  Write-Error "Missing: $srcPath"
}

$bmp = [System.Drawing.Bitmap]::FromFile($srcPath)
try {
  $w = $bmp.Width
  $h = $bmp.Height

  $out = New-Object System.Drawing.Bitmap $w, $h
  $g = [System.Drawing.Graphics]::FromImage($out)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

  # Full copy
  $g.DrawImage($bmp, 0, 0, $w, $h)

  # Source band: upper hazy sky / palm tops (no logos)
  $srcY = [int]([math]::Round($h * 0.02))
  $srcH = [int]([math]::Round($h * 0.32))
  $srcRect = New-Object System.Drawing.Rectangle 0, $srcY, $w, $srcH

  # Destination: cover logo + banners + product title lines; end before flour/fruit still-life
  $dstY = [int]([math]::Round($h * 0.06))
  $dstH = [int]([math]::Round($h * 0.48))
  $dstRect = New-Object System.Drawing.Rectangle 0, $dstY, $w, $dstH

  $g.DrawImage($bmp, $dstRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
  $g.Dispose()

  $out.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
  $out.Dispose()
  Write-Host "Wrote: $outPath"
}
finally {
  $bmp.Dispose()
}
