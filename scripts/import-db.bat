@echo off
chcp 65001 >nul
title PetVaccine - Import Database
color 0B

echo ========================================================
echo           PETVACCINE - IMPORT DATABASE
echo ========================================================
echo.

cd /d "%~dp0.."

set /p MYSQL_USER="Nhap MySQL username (mac dinh: root): "
if "%MYSQL_USER%"=="" set MYSQL_USER=root

set /p MYSQL_PASS="Nhap MySQL password: "

echo.
echo [1/2] Import db.sql (schema + du lieu co ban)...
mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 < db.sql
if %errorlevel% neq 0 (
    echo [X] Import db.sql that bai!
    echo     Kiem tra lai username/password MySQL
    echo     Dam bao MySQL dang chay
    goto :end
)
echo [OK] Import db.sql thanh cong!
echo.

set /p IMPORT_SAMPLE="Ban co muon import du lieu mau (sample_data.sql)? (y/n): "
if /i "%IMPORT_SAMPLE%"=="y" (
    echo [2/2] Import sample_data.sql...
    mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 petvaccine < sample_data.sql
    if %errorlevel% neq 0 (
        echo [X] Import sample_data.sql that bai!
    ) else (
        echo [OK] Import sample_data.sql thanh cong!
    )
)

echo.
echo ========================================================
echo   DATABASE DA DUOC IMPORT THANH CONG!
echo.
echo   Tai khoan mac dinh:
echo   - Admin: admin / Admin@123
echo   - User:  user1 / User@123
echo ========================================================

:end
echo.
echo Nhan phim bat ky de dong cua so nay...
pause >nul
