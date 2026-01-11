# ============================================
# PetVaccine WAR Deployment Script (PowerShell)
# ============================================
# Script này deploy WAR file từ Maven build
# KHÔNG ảnh hưởng đến deploy script cũ
# ============================================

$ErrorActionPreference = "Stop"

$TOMCAT_HOME = "E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113"
$WEBAPPS = "$TOMCAT_HOME\webapps"
$WAR_NAME = "PetVaccine.war"
$APP_NAME = "PetVaccine"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "PetVaccine WAR Deployment" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Build WAR with Maven
Write-Host "[1/4] Building WAR with Maven..." -ForegroundColor Yellow
try {
    & mvn clean package -q
    if ($LASTEXITCODE -ne 0) { throw "Maven build failed" }
    Write-Host "      Build successful: target\$WAR_NAME" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Maven build failed!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Stop Tomcat if running
Write-Host "[2/4] Checking Tomcat status..." -ForegroundColor Yellow
$javaProcesses = Get-Process -Name "java" -ErrorAction SilentlyContinue
if ($javaProcesses) {
    Write-Host "      Stopping Tomcat..." -ForegroundColor Yellow
    & "$TOMCAT_HOME\bin\shutdown.bat" 2>$null
    Start-Sleep -Seconds 5
}
Write-Host "      Tomcat stopped." -ForegroundColor Green
Write-Host ""

# Step 3: Remove old deployment
Write-Host "[3/4] Removing old deployment..." -ForegroundColor Yellow
$explodedPath = Join-Path $WEBAPPS $APP_NAME
$warPath = Join-Path $WEBAPPS $WAR_NAME

if (Test-Path $explodedPath) {
    Remove-Item -Path $explodedPath -Recurse -Force
    Write-Host "      Removed exploded folder: $APP_NAME" -ForegroundColor Green
}
if (Test-Path $warPath) {
    Remove-Item -Path $warPath -Force
    Write-Host "      Removed old WAR file" -ForegroundColor Green
}
Write-Host ""

# Step 4: Copy new WAR
Write-Host "[4/4] Deploying new WAR..." -ForegroundColor Yellow
try {
    Copy-Item -Path "target\$WAR_NAME" -Destination $WEBAPPS -Force
    Write-Host "      Deployed: $WEBAPPS\$WAR_NAME" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to copy WAR file!" -ForegroundColor Red
    exit 1
}
Write-Host ""

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To start Tomcat, run:"
Write-Host "  $TOMCAT_HOME\bin\startup.bat" -ForegroundColor White
Write-Host ""
Write-Host "Or use: scripts\start-tomcat-war.bat"
Write-Host ""
Write-Host "Application URL: http://localhost:8080/$APP_NAME" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
