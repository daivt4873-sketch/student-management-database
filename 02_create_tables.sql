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
