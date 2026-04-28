USE StudentManagementDB;
GO

-- 1. Xem danh sách sinh viên đăng ký lớp học phần
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

-- 2. Đếm số sinh viên trong từng lớp học phần
SELECT 
    SE.Section_ID,
    C.Course_Name,
    COUNT(E.Student_ID) AS Total_Students
FROM SECTION SE
JOIN COURSE C ON SE.Course_ID = C.Course_ID
LEFT JOIN ENROLLS E ON SE.Section_ID = E.Section_ID
GROUP BY SE.Section_ID, C.Course_Name;
GO

-- 3. Tính điểm trung bình từng môn học
SELECT 
    C.Course_ID,
    C.Course_Name,
    AVG(E.Score) AS Average_Score
FROM COURSE C
JOIN SECTION SE ON C.Course_ID = SE.Course_ID
JOIN ENROLLS E ON SE.Section_ID = E.Section_ID
GROUP BY C.Course_ID, C.Course_Name;
GO
