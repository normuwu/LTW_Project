@echo off
chcp 65001 >nul
title PetVaccine - Setup Script
color 0A

echo ╔══════════════════════════════════════════════════════════════╗
echo ║           PETVACCINE - SETUP SCRIPT                          ║
echo ║           Cài đặt tự động cho project                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Kiểm tra Java
echo [1/5] Kiểm tra Java...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Java chưa được cài đặt!
    echo     Vui lòng cài Java JDK 11+ từ: https://adoptium.net/
    pause
    exit /b 1
)
echo [OK] Java đã cài đặt
echo.

:: Kiểm tra Maven
echo [2/5] Kiểm tra Maven...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [X] Maven chưa được cài đặt!
    echo     Vui lòng cài Maven từ: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)
echo [OK] Maven đã cài đặt
echo.

:: Kiểm tra MySQL
echo [3/5] Kiểm tra MySQL...
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] MySQL command không tìm thấy trong PATH
    echo     Nếu bạn dùng XAMPP, hãy đảm bảo MySQL đang chạy
    echo.
)
echo [OK] Tiếp tục...
echo.

:: Build project
echo [4/5] Build project với Maven...
cd /d "%~dp0.."
call mvn clean package -DskipTests -q
if %errorlevel% neq 0 (
    echo [X] Build thất bại!
    pause
    exit /b 1
)
echo [OK] Build thành công - File WAR: target\PetVaccine.war
echo.

:: Hướng dẫn tiếp theo
echo [5/5] Hoàn tất!
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║  CÁC BƯỚC TIẾP THEO:                                         ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  1. Cấu hình database:                                       ║
echo ║     - Mở src/main/java/Context/DBContext.java                ║
echo ║     - Sửa password MySQL của bạn                             ║
echo ║                                                              ║
echo ║  2. Import database:                                         ║
echo ║     - Chạy file db.sql trong MySQL Workbench/phpMyAdmin      ║
echo ║     - Hoặc: mysql -u root -p < db.sql                        ║
echo ║                                                              ║
echo ║  3. Cấu hình Tomcat:                                         ║
echo ║     - Mở start.bat và sửa đường dẫn CATALINA_HOME            ║
echo ║     - Mở scripts/deploy.bat và sửa đường dẫn Tomcat          ║
echo ║                                                              ║
echo ║  4. Deploy và chạy:                                          ║
echo ║     - Chạy scripts/deploy.bat để copy WAR vào Tomcat         ║
echo ║     - Chạy start.bat để khởi động server                     ║
echo ║                                                              ║
echo ║  5. Truy cập: http://localhost:8080/PetVaccine/home          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
pause
