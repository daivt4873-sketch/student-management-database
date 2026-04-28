USE StudentManagementDB;
GO

INSERT INTO STUDENT 
(Student_ID, Full_Name, Email, Phone, Address, Gender, DOB)
VALUES
('S001', N'Nguyễn Văn Minh', 'minh@example.com', '0901234567', N'Lâm Đồng', N'Nam', '2004-05-12'),
('S002', N'Trần Thị Hoa', 'hoa@example.com', '0912345678', N'TP.HCM', N'Nữ', '2004-09-20'),
('S003', N'Lê Quốc Anh', 'anh@example.com', '0923456789', N'Đồng Nai', N'Nam', '2003-12-01'),
('S004', N'Phạm Thu Hà', 'ha@example.com', '0934567890', N'Đà Lạt', N'Nữ', '2005-02-18');
GO

INSERT INTO COURSE
(Course_ID, Course_Name, Description, Credits)
VALUES
('C001', N'Cơ sở dữ liệu', N'Môn học về thiết kế và quản trị cơ sở dữ liệu', 3),
('C002', N'Lập trình hướng đối tượng', N'Môn học về OOP', 3),
('C003', N'An toàn thông tin', N'Môn học về bảo mật và mã hóa', 3),
('C004', N'Lập trình Web', N'Môn học về phát triển website', 4);
GO

INSERT INTO LECTURER
(Lecturer_ID, Full_Name, Major, Email, Phone)
VALUES
('L001', N'Nguyễn Văn An', N'Cơ sở dữ liệu', 'an@example.com', '0981111111'),
('L002', N'Trần Minh Tuấn', N'Công nghệ phần mềm', 'tuan@example.com', '0982222222'),
('L003', N'Lê Thị Mai', N'An toàn thông tin', 'mai@example.com', '0983333333');
GO

INSERT INTO COURSE_LECTURER
(Course_ID, Lecturer_ID)
VALUES
('C001', 'L001'),
('C001', 'L002'),
('C002', 'L002'),
('C003', 'L003'),
('C004', 'L001');
GO

INSERT INTO SECTION
(Section_ID, Course_ID, Lecturer_ID, Section_Time, Location)
VALUES
('SEC001', 'C001', 'L001', N'Thứ 2, 07:00 - 09:30', N'Phòng A101'),
('SEC002', 'C001', 'L002', N'Thứ 4, 09:30 - 12:00', N'Phòng B202'),
('SEC003', 'C002', 'L002', N'Thứ 3, 13:00 - 15:30', N'Phòng C303'),
('SEC004', 'C003', 'L003', N'Thứ 5, 07:00 - 09:30', N'Phòng D404');
GO

INSERT INTO ENROLLS
(Student_ID, Section_ID, Score)
VALUES
('S001', 'SEC001', 88),
('S001', 'SEC003', 76),
('S002', 'SEC001', 92),
('S002', 'SEC004', 69),
('S003', 'SEC002', 54),
('S003', 'SEC003', 81),
('S004', 'SEC004', 35);
GO
