@echo off
chcp 65001 >nul
title PetVaccine - Import Database
color 0B

echo ╔══════════════════════════════════════════════════════════════╗
echo ║           PETVACCINE - IMPORT DATABASE                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

cd /d "%~dp0.."

set /p MYSQL_USER="Nhập MySQL username (mặc định: root): "
if "%MYSQL_USER%"=="" set MYSQL_USER=root

set /p MYSQL_PASS="Nhập MySQL password: "

echo.
echo [1/2] Import db.sql (schema + dữ liệu cơ bản)...
mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 < db.sql
if %errorlevel% neq 0 (
    echo [X] Import db.sql thất bại!
    echo     Kiểm tra lại username/password MySQL
    pause
    exit /b 1
)
echo [OK] Import db.sql thành công!
echo.

set /p IMPORT_SAMPLE="Bạn có muốn import dữ liệu mẫu (sample_data.sql)? (y/n): "
if /i "%IMPORT_SAMPLE%"=="y" (
    echo [2/2] Import sample_data.sql...
    mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 petvaccine < sample_data.sql
    if %errorlevel% neq 0 (
        echo [X] Import sample_data.sql thất bại!
    ) else (
        echo [OK] Import sample_data.sql thành công!
    )
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║  DATABASE ĐÃ ĐƯỢC IMPORT THÀNH CÔNG!                         ║
echo ║                                                              ║
echo ║  Tài khoản mặc định:                                         ║
echo ║  - Admin: admin / Admin@123                                  ║
echo ║  - User:  user1 / User@123                                   ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
pause
