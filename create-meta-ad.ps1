Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$srcPath = (Resolve-Path ".\assets\night-office-engineer.png").Path
$outPath = Join-Path (Resolve-Path ".\assets").Path "meta-ad-career.png"

$src = [System.Drawing.Image]::FromFile($srcPath)
$w = 1080
$h = 1350
$bmp = [System.Drawing.Bitmap]::new($w, $h)
$g = [System.Drawing.Graphics]::FromImage($bmp)

$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$scale = [Math]::Max($w / $src.Width, $h / $src.Height)
$dw = [int]($src.Width * $scale)
$dh = [int]($src.Height * $scale)
$dx = [int](($w - $dw) / 2)
$dy = [int](($h - $dh) / 2 - 145)
$g.DrawImage($src, $dx, $dy, $dw, $dh)

$overlay = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
  [System.Drawing.Rectangle]::new(0, 0, $w, $h),
  [System.Drawing.Color]::FromArgb(18, 5, 8, 13),
  [System.Drawing.Color]::FromArgb(245, 5, 8, 13),
  90
)
$g.FillRectangle($overlay, 0, 0, $w, $h)

$side = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
  [System.Drawing.Rectangle]::new(0, 0, $w, $h),
  [System.Drawing.Color]::FromArgb(185, 9, 13, 18),
  [System.Drawing.Color]::FromArgb(0, 12, 20, 29),
  0
)
$g.FillRectangle($side, 0, 0, $w, $h)

$accentBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(226, 182, 111))
$accentDeepBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(185, 120, 55))
$inkBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(246, 242, 233))
$mutedBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(206, 226, 222, 211))
$linePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(70, 246, 242, 233), 2)

$fontFamily = "Yu Gothic"
$small = [System.Drawing.Font]::new($fontFamily, 28, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$headline = [System.Drawing.Font]::new($fontFamily, 64, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$body = [System.Drawing.Font]::new($fontFamily, 32, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$ctaFont = [System.Drawing.Font]::new($fontFamily, 28, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$badgeFont = [System.Drawing.Font]::new($fontFamily, 30, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)

$sf = [System.Drawing.StringFormat]::new()
$sf.Alignment = [System.Drawing.StringAlignment]::Near
$sf.LineAlignment = [System.Drawing.StringAlignment]::Near
$sf.FormatFlags = [System.Drawing.StringFormatFlags]::LineLimit
$sf.Trimming = [System.Drawing.StringTrimming]::EllipsisWord

$badgeRect = [System.Drawing.Rectangle]::new(72, 84, 560, 66)
$badgePath = [System.Drawing.Drawing2D.GraphicsPath]::new()
$br = 10
$badgePath.AddArc($badgeRect.X, $badgeRect.Y, $br, $br, 180, 90)
$badgePath.AddArc($badgeRect.Right - $br, $badgeRect.Y, $br, $br, 270, 90)
$badgePath.AddArc($badgeRect.Right - $br, $badgeRect.Bottom - $br, $br, $br, 0, 90)
$badgePath.AddArc($badgeRect.X, $badgeRect.Bottom - $br, $br, $br, 90, 90)
$badgePath.CloseFigure()
$g.FillPath($accentBrush, $badgePath)
[System.Windows.Forms.TextRenderer]::DrawText(
  $g,
  "東京・大阪エリア限定",
  $badgeFont,
  [System.Drawing.Rectangle]::new(104, 92, 500, 50),
  [System.Drawing.Color]::FromArgb(18, 15, 11),
  [System.Windows.Forms.TextFormatFlags]::VerticalCenter -bor [System.Windows.Forms.TextFormatFlags]::Left
)

$g.DrawString("PR / 20〜30代エンジニア経験者向け", $small, $mutedBrush, [System.Drawing.RectangleF]::new(72, 184, 840, 48), $sf)
$g.DrawLine($linePen, 72, 250, 360, 250)
$g.DrawString("年収は上がった。`nでも、毎日が`n進んでる感じは`nしなかった。", $headline, $inkBrush, [System.Drawing.RectangleF]::new(72, 292, 930, 420), $sf)
$g.DrawString("1,000万をこえる高年収案件も視野に。`nリモート、出社頻度、技術、チーム。`n条件だけではなく、価値観から選ぶ転職相談。", $body, $mutedBrush, [System.Drawing.RectangleF]::new(76, 740, 880, 210), $sf)

$pillRect = [System.Drawing.Rectangle]::new(72, 996, 780, 82)
$path = [System.Drawing.Drawing2D.GraphicsPath]::new()
$r = 12
$path.AddArc($pillRect.X, $pillRect.Y, $r, $r, 180, 90)
$path.AddArc($pillRect.Right - $r, $pillRect.Y, $r, $r, 270, 90)
$path.AddArc($pillRect.Right - $r, $pillRect.Bottom - $r, $r, $r, 0, 90)
$path.AddArc($pillRect.X, $pillRect.Bottom - $r, $r, $r, 90, 90)
$path.CloseFigure()
$g.FillPath($accentBrush, $path)

[System.Windows.Forms.TextRenderer]::DrawText(
  $g,
  "年収だけでは解決しないキャリアを整理する",
  $ctaFont,
  [System.Drawing.Rectangle]::new(96, 1008, 740, 62),
  [System.Drawing.Color]::FromArgb(19, 16, 13),
  [System.Windows.Forms.TextFormatFlags]::VerticalCenter -bor [System.Windows.Forms.TextFormatFlags]::Left
)

$g.DrawString("大手からスタートアップまで / 職務経歴書・面接対策も伴走", $small, $mutedBrush, [System.Drawing.RectangleF]::new(72, 1234, 920, 48), $sf)

$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()
$src.Dispose()

Get-Item $outPath | Select-Object FullName, Length, LastWriteTime





