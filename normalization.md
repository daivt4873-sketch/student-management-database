# Chuẩn hóa cơ sở dữ liệu

## 1. Mô hình quan hệ ban đầu

Sau khi chuyển đổi từ ERD sang mô hình quan hệ, hệ thống gồm các lược đồ chính:

```text
STUDENT(Student_ID, Full_Name, Email, Phone, Address, Gender, DOB)
COURSE(Course_ID, Course_Name, Description, Credits)
LECTURER(Lecturer_ID, Full_Name, Major, Email, Phone)
SECTION(Section_ID, Course_ID, Lecturer_ID, Section_Time, Location)
ENROLLS(Student_ID, Section_ID, Score, Grade)
```

Tuy nhiên, do quy tắc nghiệp vụ có quan hệ M:N giữa COURSE và LECTURER, cần bổ sung bảng trung gian:

```text
COURSE_LECTURER(Course_ID, Lecturer_ID)
```

## 2. Mô hình sau chuẩn hóa 3NF

```text
STUDENT(Student_ID, Full_Name, Email, Phone, Address, Gender, DOB)
COURSE(Course_ID, Course_Name, Description, Credits)
LECTURER(Lecturer_ID, Full_Name, Major, Email, Phone)
COURSE_LECTURER(Course_ID, Lecturer_ID)
SECTION(Section_ID, Course_ID, Lecturer_ID, Section_Time, Location)
ENROLLS(Student_ID, Section_ID, Score, Grade)
```

## 3. Kiểm tra 1NF

Các bảng đạt 1NF vì:

- Mỗi ô dữ liệu chỉ chứa một giá trị.
- Không có nhóm thuộc tính lặp.
- Mỗi dòng dữ liệu là duy nhất.

## 4. Kiểm tra 2NF

Các bảng đạt 2NF vì:

- Đã đạt 1NF.
- Các bảng có khóa đơn tự động không có phụ thuộc bộ phận.
- Bảng ENROLLS có khóa ghép `Student_ID, Section_ID`; thuộc tính `Score` phụ thuộc vào toàn bộ khóa ghép.
- Bảng COURSE_LECTURER chỉ gồm khóa ghép, không có thuộc tính không khóa nên đạt 2NF.

## 5. Kiểm tra 3NF

Các bảng đạt 3NF vì:

- Đã đạt 2NF.
- Không có phụ thuộc bắc cầu giữa các thuộc tính không khóa.
- Thông tin sinh viên chỉ nằm trong STUDENT.
- Thông tin môn học chỉ nằm trong COURSE.
- Thông tin giảng viên chỉ nằm trong LECTURER.
- ENROLLS chỉ lưu thông tin đăng ký và điểm của sinh viên trong lớp học phần.

## 6. Giảm dư thừa dữ liệu

Bảng COURSE_LECTURER giúp tránh việc lưu lặp thông tin môn học và giảng viên nhiều lần.

Thuộc tính `Grade` được tạo tự động từ `Score`, giúp tránh trường hợp điểm và xếp loại bị nhập sai lệch nhau.
