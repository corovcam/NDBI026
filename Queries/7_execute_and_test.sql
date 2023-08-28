-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script evaluates the Student Information System by executing and testing the views, functions, triggers, and procedures.

-- Testing Views
SELECT * FROM vw_Student_Enrollment_Details;
SELECT * FROM vw_Teacher_Courses_Details;

-- Testing Functions
SELECT student_id, u45389618.fn_CalculateStudentGPA(student_id) as GPA FROM Student;

-- Testing Triggers
-- Attempt to insert a record that will violate the triggers
INSERT INTO Enrollment (student_id, course_id, enrollment_date, grade)
VALUES 
    (10000030, 1, '2022-09-01', NULL), -- course number 1 has max_capacity 10 people. Currently there are 8.
    (10000031, 1, '2022-09-01', NULL),
    (10000032, 1, '2022-09-01', NULL); -- this should violate the tr_UpdateStudentGPA trigger

-- This should violate the tr_Check_Graduation_Date trigger
INSERT INTO Person (person_id, email, name, surname)
VALUES (10000060, 'amarie@example.com', 'Anna', 'Marie'); -- add a new person for testing purposes
INSERT INTO Student (student_id, program_id, study_year, admission_date, graduation_date, status)
VALUES (10000060, 1, 1, '2022-09-01', '2021-09-01', 'graduated');

-- This should violate the tr_CheckProgramDuration trigger
UPDATE Student
SET study_year = 4
WHERE student_id = 10000052;

-- This should check the tr_UpdateStudentGPA - calculate and update the GPA of student 10000003
UPDATE Enrollment
SET grade = 1
WHERE student_id = 10000003 AND course_id = 1 AND enrollment_date = '2022-09-01';

SELECT student_id, gpa FROM Student WHERE student_id = 10000003; -- GPA should be 1.00

UPDATE Enrollment
SET grade = 3
WHERE student_id = 10000003 AND course_id = 2 AND enrollment_date = '2022-09-01';

SELECT student_id, gpa FROM Student WHERE student_id = 10000003; -- GPA should be 2.00

-- Testing Procedures
EXEC sp_UpdateStudentStatus 10000003; -- You can replace with another student_id
EXEC sp_UpdateCourseSchedule 1, '19:30:00', '21:00:00', 1, 'Room 101'; -- You can replace with another course_id
-- EXEC sp_AssignTeacherToCourse 10000001, 1; -- You can replace with another teacher_id and course_id
-- EXEC sp_TransferStudent 10000003, 2; -- You can replace with another student_id and new_program_id;
-- EXEC sp_UpdateCourseScheduleAndTeacher 1, '10:00:00', '12:00:00', 2, 'Room 102', 10000001; -- You can replace with another course_id, start_time, end_time, day_of_week, location, and teacher_id