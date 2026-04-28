# Student Management Database

Đây là project Cơ sở dữ liệu quản lý sinh viên, được xây dựng từ ERD sang mô hình quan hệ, chuẩn hóa đến 3NF và cài đặt bằng SQL Server.

## 1. Mục tiêu project

Project thực hiện các công việc:

- Chuyển đổi ERD sang mô hình dữ liệu quan hệ.
- Chuẩn hóa dữ liệu đến dạng chuẩn 3NF.
- Tạo bảng, khóa chính, khóa ngoại và ràng buộc dữ liệu.
- Thêm dữ liệu mẫu để kiểm tra database.
- Viết truy vấn kiểm tra kết quả.

## 2. Các bảng trong hệ thống

Database gồm các bảng:

| Bảng | Chức năng |
|---|---|
| STUDENT | Lưu thông tin sinh viên |
| COURSE | Lưu thông tin môn học |
| LECTURER | Lưu thông tin giảng viên |
| COURSE_LECTURER | Bảng trung gian cho quan hệ M:N giữa COURSE và LECTURER |
| SECTION | Lưu thông tin lớp học phần |
| ENROLLS | Lưu thông tin sinh viên đăng ký lớp học phần |

## 3. Cấu trúc thư mục

```text
student-management-db/
│
├── README.md
├── .gitignore
│
├── docs/
│   └── normalization.md
│
└── sql/
    ├── 00_run_all.sql
    ├── 01_create_database.sql
    ├── 02_create_tables.sql
    ├── 03_insert_sample_data.sql
    └── 04_test_queries.sql
```

## 4. Cách chạy project

### Cách 1: Chạy nhanh bằng một file

Mở SQL Server Management Studio, sau đó chạy file:

```text
sql/00_run_all.sql
```

### Cách 2: Chạy từng bước

Chạy lần lượt các file sau:

```text
01_create_database.sql
02_create_tables.sql
03_insert_sample_data.sql
04_test_queries.sql
```

## 5. Kết quả mong đợi

Sau khi chạy file `04_test_queries.sql`, hệ thống sẽ hiển thị danh sách sinh viên đăng ký lớp học phần, gồm:

- Mã sinh viên
- Tên sinh viên
- Tên môn học
- Thời gian học
- Phòng học
- Giảng viên phụ trách
- Điểm số
- Xếp loại

## 6. Ghi chú chuẩn hóa

Database đạt chuẩn 3NF vì:

- Mỗi thuộc tính là nguyên tử, đạt 1NF.
- Không có phụ thuộc bộ phận vào khóa ghép, đạt 2NF.
- Không có phụ thuộc bắc cầu giữa các thuộc tính không khóa, đạt 3NF.
- Quan hệ M:N được tách thành bảng trung gian để tránh dư thừa dữ liệu.
