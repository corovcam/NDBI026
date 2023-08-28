-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates views for the Student Information System.

DROP VIEW IF EXISTS vw_Student_Enrollment_Details;
DROP VIEW IF EXISTS vw_Teacher_Courses_Details;

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


-- This view returns the detailed information of each teacher's courses, including course name, semester, and the number of students enrolled.
CREATE OR ALTER VIEW vw_Teacher_Courses_Details AS
SELECT 
    t.teacher_id, 
    CONCAT(p.name, ' ', p.surname) AS teacher_name,
    c.name AS course_name, 
    c.semester, 
    COUNT(e.student_id) AS num_of_students
FROM 
    Teacher t
INNER JOIN 
    Person p ON t.teacher_id = p.person_id
INNER JOIN 
    Course c ON t.teacher_id = c.garant_id
LEFT JOIN 
    Enrollment e ON c.course_id = e.course_id
GROUP BY 
    t.teacher_id, 
    p.name, 
    p.surname,
    c.name, 
    c.semester;

