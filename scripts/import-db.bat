@echo off
chcp 65001 >nul
title PetVaccine - Import Database
color 0B

echo ========================================================
echo           PETVACCINE - IMPORT DATABASE
echo ========================================================
echo.

cd /d "%~dp0.."

:: Kiểm tra MySQL có trong PATH không
where mysql >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Khong tim thay lenh mysql!
    echo.
    echo     MySQL chua duoc cai dat hoac chua them vao PATH.
    echo     Neu ban dung XAMPP, them duong dan sau vao PATH:
    echo     C:\xampp\mysql\bin
    echo.
    echo     Hoac import thu cong bang phpMyAdmin/MySQL Workbench.
    echo.
    pause
    exit /b 1
)

:input_credentials
echo.
set /p MYSQL_USER="Nhap MySQL username (mac dinh: root): "
if "%MYSQL_USER%"=="" set MYSQL_USER=root

set /p MYSQL_PASS="Nhap MySQL password (Enter neu khong co password): "

echo.
echo Dang kiem tra ket noi MySQL...

:: Kiểm tra kết nối MySQL trước
mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" -e "SELECT 1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ========================================================
    echo   [X] KET NOI THAT BAI!
    echo ========================================================
    echo.
    echo   Nguyen nhan co the:
    echo   - Sai username hoac password
    echo   - MySQL chua duoc khoi dong
    echo.
    echo   Goi y:
    echo   - Neu dung XAMPP: Mo XAMPP Control Panel, bam Start MySQL
    echo   - Neu password rong: Chi can nhan Enter khi nhap password
    echo.
    set /p RETRY="Ban co muon nhap lai? (y/n): "
    if /i "%RETRY%"=="y" goto :input_credentials
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================================
echo   [OK] KET NOI MYSQL THANH CONG!
echo ========================================================
echo   Username: %MYSQL_USER%
echo.

:: Import db.sql
echo [1/2] Dang import db.sql...
echo       (Tao database va cau truc bang)
mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 < db.sql
if %errorlevel% neq 0 (
    echo.
    echo [X] Import db.sql that bai!
    echo.
    pause
    exit /b 1
)
echo       [OK] Import db.sql thanh cong!
echo.

:: Hỏi import sample data
set /p IMPORT_SAMPLE="Ban co muon import du lieu mau de test (sample_data.sql)? (y/n): "
if /i "%IMPORT_SAMPLE%"=="y" (
    echo.
    echo [2/2] Dang import sample_data.sql...
    mysql -u %MYSQL_USER% -p"%MYSQL_PASS%" --default-character-set=utf8mb4 petvaccine < sample_data.sql
    if %errorlevel% neq 0 (
        echo       [X] Import sample_data.sql that bai!
    ) else (
        echo       [OK] Import sample_data.sql thanh cong!
    )
)

echo.
echo ========================================================
echo   HOAN TAT! DATABASE DA DUOC IMPORT THANH CONG!
echo ========================================================
echo.
echo   Thong tin ket noi (de cau hinh DBContext.java):
echo   ------------------------------------------------
echo   Server:   localhost
echo   Port:     3306
echo   Database: petvaccine
echo   Username: %MYSQL_USER%
echo   Password: [password ban vua nhap]
echo.
echo   Tai khoan dang nhap website:
echo   ----------------------------
echo   Admin: admin / Admin@123
echo   User:  user1 / User@123
echo.
echo   BUOC TIEP THEO:
echo   ---------------
echo   Chay: scripts\config-tomcat.bat
echo.
echo ========================================================
echo.
pause
