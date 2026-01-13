-- Thêm cột description vào bảng products
ALTER TABLE products ADD COLUMN description TEXT AFTER discount;

-- Cập nhật mô tả cho các sản phẩm hiện có
UPDATE products SET description = 'Thức ăn hạt cao cấp dành cho mèo trưởng thành nuôi trong nhà, giúp kiểm soát cân nặng và giảm mùi phân.' WHERE id = 1;
UPDATE products SET description = 'Thức ăn hạt dinh dưỡng cho mèo con từ 4-12 tháng tuổi, hỗ trợ phát triển hệ miễn dịch và tiêu hóa.' WHERE id = 2;
UPDATE products SET description = 'Thức ăn hạt đặc biệt cho mèo có vấn đề về đường tiết niệu, giúp hòa tan sỏi struvite.' WHERE id = 3;
UPDATE products SET description = 'Pate mềm mịn cho mèo trưởng thành, kích thích vị giác và cung cấp đầy đủ dinh dưỡng.' WHERE id = 4;
UPDATE products SET description = 'Pate dinh dưỡng cho mèo con, dễ tiêu hóa và hỗ trợ phát triển toàn diện.' WHERE id = 5;
