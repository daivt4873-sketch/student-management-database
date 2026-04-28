IF DB_ID('StudentManagementDB') IS NOT NULL
BEGIN
    ALTER DATABASE StudentManagementDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE StudentManagementDB;
END
GO

CREATE DATABASE StudentManagementDB;
GO

USE StudentManagementDB;
GO

CREATE TABLE STUDENT (
    Student_ID VARCHAR(10) PRIMARY KEY,
    Full_Name NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Address NVARCHAR(200),
    Gender NVARCHAR(10) CHECK (Gender IN (N'Nam', N'Nữ', N'Khác')),
    DOB DATE,

    CONSTRAINT CK_Student_Email CHECK (Email LIKE '%_@_%._%'),
    CONSTRAINT CK_Student_Phone CHECK (
        Phone NOT LIKE '%[^0-9]%' 
        AND LEN(Phone) BETWEEN 9 AND 15
    )
);
GO

CREATE TABLE COURSE (
    Course_ID VARCHAR(10) PRIMARY KEY,
    Course_Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Credits INT NOT NULL,

    CONSTRAINT CK_Course_Credits CHECK (Credits > 0)
);
GO

CREATE TABLE LECTURER (
    Lecturer_ID VARCHAR(10) PRIMARY KEY,
    Full_Name NVARCHAR(100) NOT NULL,
    Major NVARCHAR(100),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL UNIQUE,

    CONSTRAINT CK_Lecturer_Email CHECK (Email LIKE '%_@_%._%'),
    CONSTRAINT CK_Lecturer_Phone CHECK (
        Phone NOT LIKE '%[^0-9]%' 
        AND LEN(Phone) BETWEEN 9 AND 15
    )
);
GO

CREATE TABLE COURSE_LECTURER (
    Course_ID VARCHAR(10) NOT NULL,
    Lecturer_ID VARCHAR(10) NOT NULL,

    CONSTRAINT PK_Course_Lecturer 
        PRIMARY KEY (Course_ID, Lecturer_ID),

    CONSTRAINT FK_CL_Course 
        FOREIGN KEY (Course_ID) 
        REFERENCES COURSE(Course_ID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,

    CONSTRAINT FK_CL_Lecturer 
        FOREIGN KEY (Lecturer_ID) 
        REFERENCES LECTURER(Lecturer_ID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
GO

CREATE TABLE SECTION (
    Section_ID VARCHAR(10) PRIMARY KEY,
    Course_ID VARCHAR(10) NOT NULL,
    Lecturer_ID VARCHAR(10) NOT NULL,
    Section_Time NVARCHAR(50) NOT NULL,
    Location NVARCHAR(100) NOT NULL,

    CONSTRAINT FK_Section_CourseLecturer
        FOREIGN KEY (Course_ID, Lecturer_ID)
        REFERENCES COURSE_LECTURER(Course_ID, Lecturer_ID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
GO

CREATE TABLE ENROLLS (
    Student_ID VARCHAR(10) NOT NULL,
    Section_ID VARCHAR(10) NOT NULL,
    Score DECIMAL(5,2),

    Grade AS (
        CASE
            WHEN Score IS NULL THEN NULL
            WHEN Score >= 85 THEN 'A'
            WHEN Score >= 70 THEN 'B'
            WHEN Score >= 55 THEN 'C'
            WHEN Score >= 40 THEN 'D'
            ELSE 'F'
        END
    ) PERSISTED,

    CONSTRAINT PK_Enrolls 
        PRIMARY KEY (Student_ID, Section_ID),

    CONSTRAINT FK_Enrolls_Student 
        FOREIGN KEY (Student_ID) 
        REFERENCES STUDENT(Student_ID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,

    CONSTRAINT FK_Enrolls_Section 
        FOREIGN KEY (Section_ID) 
        REFERENCES SECTION(Section_ID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,

    CONSTRAINT CK_Enrolls_Score 
        CHECK (Score BETWEEN 0 AND 100 OR Score IS NULL)
);
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

SELECT 
    S.Student_ID,
    S.Full_Name AS Student_Name,
    C.Course_Name,
    SE.Section_Time,
    SE.Location,
    L.Full_Name AS Lecturer_Name,
    E.Score,
    E.Grade
FROM ENROLLS E
JOIN STUDENT S ON E.Student_ID = S.Student_ID
JOIN SECTION SE ON E.Section_ID = SE.Section_ID
JOIN COURSE C ON SE.Course_ID = C.Course_ID
JOIN LECTURER L ON SE.Lecturer_ID = L.Lecturer_ID;
GO

SELECT 
    SE.Section_ID,
    C.Course_Name,
    COUNT(E.Student_ID) AS Total_Students
FROM SECTION SE
JOIN COURSE C ON SE.Course_ID = C.Course_ID
LEFT JOIN ENROLLS E ON SE.Section_ID = E.Section_ID
GROUP BY SE.Section_ID, C.Course_Name;
GO

SELECT 
    C.Course_ID,
    C.Course_Name,
    AVG(E.Score) AS Average_Score
FROM COURSE C
JOIN SECTION SE ON C.Course_ID = SE.Course_ID
JOIN ENROLLS E ON SE.Section_ID = E.Section_ID
GROUP BY C.Course_ID, C.Course_Name;
GO
