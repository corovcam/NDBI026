-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates views for the Student Information System.

DROP VIEW IF EXISTS vw_Student_Details;
DROP VIEW IF EXISTS vw_Student_Enrollment_Details;
DROP VIEW IF EXISTS vw_Teacher_Courses_Details;
DROP VIEW IF EXISTS vw_Course_Schedule_Details;
DROP VIEW IF EXISTS vw_Teacher_Schedule;
GO

-- This view combines information from the Student and Program tables to provide details about each student, including the program they are enrolled in.
CREATE OR ALTER VIEW vw_Student_Details
AS
    SELECT
        s.student_id,
        CONCAT(p.name, ' ', p.surname) AS student_name,
        pr.name AS program_name,
        pr.duration_years AS program_duration_years,
        s.study_year AS student_study_year,
        s.admission_date,
        s.graduation_date,
        s.gpa,
        s.status,
        s.honor_status
    FROM Student s
        JOIN Person p ON s.student_id = p.person_id
        JOIN Program pr ON s.program_id = pr.program_id;
GO

-- This view returns the detailed information of each student's enrollments, including course name, enrollment date, and grade.
CREATE OR ALTER VIEW vw_Student_Enrollment_Details
AS
    SELECT
        s.student_id,
        CONCAT(p.name, ' ', p.surname) AS student_name,
        c.name AS course_name,
        e.enrollment_date,
        e.grade
    FROM
        Student s
        INNER JOIN
        Person p ON s.student_id = p.person_id
        INNER JOIN
        Enrollment e ON s.student_id = e.student_id
        INNER JOIN
        Course c ON e.course_id = c.course_id;
GO

-- This view returns the detailed information of each teacher's courses, including course name, semester, the number of students enrolled and the average grade.
CREATE OR ALTER VIEW vw_Teacher_Courses_Details
AS
    SELECT
        t.teacher_id,
        CONCAT(p.name, ' ', p.surname) AS teacher_name,
        c.name AS course_name,
        c.semester,
        COUNT(e.student_id) AS number_of_students,
        AVG(e.grade) AS average_grade
    FROM
        Teacher t
        INNER JOIN
        Person p ON t.teacher_id = p.person_id
        INNER JOIN
        Teaches te ON t.teacher_id = te.teacher_id
        INNER JOIN
        Course c ON te.course_id = c.course_id
        INNER JOIN
        Enrollment e ON c.course_id = e.course_id
    GROUP BY
        t.teacher_id,
        p.name,
        p.surname,
        c.name,
        c.semester;
GO

---
-- Timetable Views
---

-- This view returns the detailed information of each Course Schedule entry, including course name, semester, day, start time and end time.
CREATE OR ALTER VIEW vw_Course_Schedule_Details
AS
    SELECT
        c.name AS course_name,
        u45389618.fn_getSemesterName(c.semester) AS semester,
        u45389618.fn_getWeekDayName(cs.day_of_week) AS day_of_week,
        cs.start_time,
        cs.end_time
    FROM
        Course c
        INNER JOIN
        Course_Schedule cs ON c.course_id = cs.course_id;
GO

-- This view returns the detailed information of each teacher's schedule, including course name, day, start time, end time and location.
CREATE OR ALTER VIEW vw_Teacher_Schedule
AS
    SELECT
        t.teacher_id,
        CONCAT(p.name, ' ', p.surname) AS teacher_name,
        c.course_id,
        c.name AS course_name,
        cs.start_time,
        cs.end_time,
        u45389618.fn_getWeekDayName(cs.day_of_week) AS day_of_week,
        cs.location
    FROM Teacher t
        JOIN Person p ON t.teacher_id = p.person_id
        JOIN Teaches tc ON t.teacher_id = tc.teacher_id
        JOIN Course c ON tc.course_id = c.course_id
        JOIN Course_Schedule cs ON c.course_id = cs.course_id;
GO
