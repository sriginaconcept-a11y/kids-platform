$ErrorActionPreference = "Stop"

Write-Host "== Kids Platform verification =="

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw "Flutter غير مثبت أو غير موجود في PATH."
}

flutter --version
flutter pub get
flutter analyze
flutter build web

Write-Host "Verification completed successfully."
