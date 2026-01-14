@echo off
chcp 65001 >nul
title PetVaccine - Import Database
color 0B

echo ========================================================
echo           PETVACCINE - IMPORT DATABASE
echo ========================================================
echo.

cd /d "%~dp0.."

:input_credentials
set /p MYSQL_USER="Nhap MySQL username (mac dinh: root): "
if "%MYSQL_USER%"=="" set MYSQL_USER=root

set /p MYSQL_PASS="Nhap MySQL password: "

echo.
echo Dang kiem tra ket noi MySQL...

:: Kiểm tra kết nối MySQL trước
mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" -e "SELECT 1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [X] KET NOI THAT BAI!
    echo     Nguyen nhan co the:
    echo     - Sai username hoac password
    echo     - MySQL chua duoc khoi dong
    echo     - MySQL khong cai dat hoac khong co trong PATH
    echo.
    set /p RETRY="Ban co muon nhap lai? (y/n): "
    if /i "%RETRY%"=="y" (
        echo.
        goto :input_credentials
    )
    goto :end
)

echo [OK] Ket noi MySQL thanh cong!
echo     User: %MYSQL_USER%
echo.

:: Import db.sql
echo [1/2] Import db.sql (schema + du lieu co ban)...
mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 < db.sql
if %errorlevel% neq 0 (
    echo [X] Import db.sql that bai!
    goto :end
)
echo [OK] Import db.sql thanh cong!
echo.

:: Hỏi import sample data
set /p IMPORT_SAMPLE="Ban co muon import du lieu mau de test (sample_data.sql)? (y/n): "
if /i "%IMPORT_SAMPLE%"=="y" (
    echo.
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
echo ========================================================
echo.
echo   Thong tin ket noi (luu lai de cau hinh DBContext.java):
echo   - Server: localhost
echo   - Port: 3306
echo   - Database: petvaccine
echo   - Username: %MYSQL_USER%
echo   - Password: [da nhap]
echo.
echo   Tai khoan dang nhap website:
echo   - Admin: admin / Admin@123
echo   - User:  user1 / User@123
echo.
echo   Buoc tiep theo:
echo   - Chay scripts\config-tomcat.bat de cau hinh Tomcat
echo ========================================================

:end
echo.
echo Nhan phim bat ky de dong...
pause >nul
