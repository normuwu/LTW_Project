@echo off
REM ============================================
REM Switch to Maven Dependencies
REM ============================================
REM Script này xóa JAR thủ công trong WEB-INF/lib
REM để chuyển hoàn toàn sang Maven dependencies
REM ============================================
REM CHỈ CHẠY KHI ĐÃ SẴN SÀNG DÙNG WAR DEPLOY!
REM ============================================

setlocal

set LIB_DIR=src\main\webapp\WEB-INF\lib

echo ============================================
echo Switch to Maven Dependencies
echo ============================================
echo.
echo CANH BAO: Script nay se xoa cac JAR thu cong:
echo   - %LIB_DIR%\jstl-1.2.jar
echo   - %LIB_DIR%\mysql-connector-j-8.0.33.jar
echo.
echo Sau khi xoa, ban PHAI deploy bang WAR (scripts\deploy-war.bat)
echo Deploy script cu se KHONG hoat dong!
echo.
echo Nhan Ctrl+C de huy, hoac...
pause

echo.
echo Dang xoa JAR thu cong...

if exist "%LIB_DIR%\jstl-1.2.jar" (
    del /q "%LIB_DIR%\jstl-1.2.jar"
    echo   Deleted: jstl-1.2.jar
) else (
    echo   Not found: jstl-1.2.jar (already removed?)
)

if exist "%LIB_DIR%\mysql-connector-j-8.0.33.jar" (
    del /q "%LIB_DIR%\mysql-connector-j-8.0.33.jar"
    echo   Deleted: mysql-connector-j-8.0.33.jar
) else (
    echo   Not found: mysql-connector-j-8.0.33.jar (already removed?)
)

echo.
echo ============================================
echo Hoan tat! Cac buoc tiep theo:
echo ============================================
echo 1. Chay: scripts\deploy-war.bat
echo 2. Start Tomcat
echo 3. Truy cap: http://localhost:8080/PetVaccine
echo.
echo De rollback (neu gap loi):
echo   git checkout -- src\main\webapp\WEB-INF\lib\
echo ============================================

endlocal
