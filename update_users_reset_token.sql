-- Thêm cột reset_token và reset_token_expiry vào bảng Users
-- Chạy script này trong SQL Server Management Studio

ALTER TABLE Users ADD reset_token NVARCHAR(255) NULL;
ALTER TABLE Users ADD reset_token_expiry DATETIME NULL;
ALTER TABLE Users ADD phone NVARCHAR(20) NULL;

-- Tạo index cho reset_token để tìm kiếm nhanh hơn
CREATE INDEX IX_Users_ResetToken ON Users(reset_token);
