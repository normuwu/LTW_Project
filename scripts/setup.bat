@echo off
chcp 65001 >nul
title PetVaccine - Setup Script
color 0A

echo ========================================================
echo           PETVACCINE - SETUP SCRIPT
echo           Kiem tra moi truong va build project
echo ========================================================
echo.

:: Kiểm tra Java
echo [1/5] Kiem tra Java...
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Java chua duoc cai dat!
    echo     Vui long cai Java JDK 11+ tu: https://adoptium.net/
    echo.
    goto :end
)
java -version 2>&1 | findstr /i "version"
echo [OK] Java da cai dat
echo.

:: Kiểm tra Maven
echo [2/5] Kiem tra Maven...
where mvn >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Maven chua duoc cai dat!
    echo     Vui long cai Maven tu: https://maven.apache.org/download.cgi
    echo.
    goto :end
)
mvn -version 2>&1 | findstr /i "Apache Maven"
echo [OK] Maven da cai dat
echo.

:: Kiểm tra MySQL
echo [3/5] Kiem tra MySQL...
where mysql >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] MySQL command khong tim thay trong PATH
    echo     Neu ban dung XAMPP, hay dam bao MySQL dang chay
) else (
    echo [OK] MySQL da cai dat
)
echo.

:: Build project
echo [4/5] Build project voi Maven...
echo     Dang build, vui long doi...
cd /d "%~dp0.."
call mvn clean package -DskipTests
if %errorlevel% neq 0 (
    echo.
    echo [X] Build that bai! Xem log phia tren de biet chi tiet.
    echo.
    goto :end
)
echo.
echo [OK] Build thanh cong - File WAR: target\PetVaccine.war
echo.

:: Hướng dẫn tiếp theo
echo [5/5] Hoan tat!
echo.
echo ========================================================
echo   CAC BUOC TIEP THEO:
echo ========================================================
echo.
echo   1. Cau hinh database:
echo      - Mo src/main/java/Context/DBContext.java
echo      - Sua dong: private final String password = "your_password";
echo.
echo   2. Import database:
echo      - Chay: scripts\import-db.bat
echo      - Nhap username (mac dinh: root) va password MySQL
echo.
echo   3. Cau hinh Tomcat (TU DONG):
echo      - Chay: scripts\config-tomcat.bat
echo      - Nhap duong dan thu muc Tomcat (VD: C:\tomcat9)
echo.
echo   4. Deploy va chay:
echo      - Chay: scripts\deploy.bat (build + copy WAR)
echo      - Chay: start.bat (khoi dong Tomcat + mo browser)
echo.
echo   5. Truy cap: http://localhost:8080/PetVaccine/home
echo      - Admin: admin / Admin@123
echo      - User:  user1 / User@123
echo.
echo ========================================================

:end
echo.
echo Nhan phim bat ky de dong cua so nay...
pause >nul
