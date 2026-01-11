# Maven Migration Guide - PetVaccine

## Tình trạng hiện tại

Project đã được thêm Maven (`pom.xml`) nhưng vẫn giữ nguyên cách deploy cũ (script copy).

### Dependencies trong pom.xml:
- `javax.servlet-api:4.0.1` (scope: **provided** - không bundle vào WAR)
- `jstl:1.2`
- `mysql-connector-j:8.0.33`

### JAR thủ công trong `src/main/webapp/WEB-INF/lib/`:
- `jstl-1.2.jar`
- `mysql-connector-j-8.0.33.jar`

## ⚠️ QUAN TRỌNG: Duplicate JARs

Hiện tại có **2 bản** của mỗi dependency:
1. JAR thủ công trong `WEB-INF/lib/` (dùng cho deploy script cũ)
2. Maven dependencies (sẽ được bundle vào WAR khi `mvn package`)

**Khi deploy bằng WAR**, cả 2 bản sẽ nằm trong `WEB-INF/lib/` → **DUPLICATE** → có thể gây lỗi ClassLoader.

## Hướng dẫn chuyển sang WAR Deploy

### Bước 1: Xóa JAR thủ công
```bash
# Xóa 2 file này:
del src\main\webapp\WEB-INF\lib\jstl-1.2.jar
del src\main\webapp\WEB-INF\lib\mysql-connector-j-8.0.33.jar
```

### Bước 2: Build WAR
```bash
mvn clean package
```

### Bước 3: Deploy WAR
Sử dụng script `scripts/deploy-war.bat` hoặc copy thủ công:
```bash
copy target\PetVaccine.war E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113\webapps\
```

### Bước 4: Restart Tomcat
Xóa folder exploded cũ (nếu có) và restart Tomcat.

## Lưu ý về servlet-api

`javax.servlet-api` có scope `provided` trong pom.xml:
```xml
<scope>provided</scope>
```

Điều này đảm bảo servlet-api **KHÔNG** được bundle vào WAR vì Tomcat đã cung cấp sẵn.
Nếu bundle vào sẽ gây conflict ClassLoader.

## Workflow khuyến nghị

| Giai đoạn | Deploy method | JAR thủ công | Ghi chú |
|-----------|---------------|--------------|---------|
| Hiện tại | Script copy | GIỮ NGUYÊN | An toàn, không đổi gì |
| Chuyển đổi | WAR deploy | XÓA | Dùng `scripts/deploy-war.bat` |

## Rollback

Nếu WAR deploy gặp lỗi, có thể quay lại deploy script cũ:
1. Restore JAR từ git: `git checkout -- src/main/webapp/WEB-INF/lib/`
2. Dùng lại `run_tomcat.bat` hoặc script copy cũ
