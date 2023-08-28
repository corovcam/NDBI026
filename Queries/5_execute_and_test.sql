-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script evaluates the Student Information System by executing and testing the views, functions, triggers, and procedures.

---
-- Testing Views
---

SELECT * FROM vw_Student_Details;
SELECT * FROM vw_Student_Enrollment_Details;
SELECT * FROM vw_Teacher_Courses_Details;
SELECT * FROM vw_Course_Schedule_Details;
SELECT * FROM vw_Teacher_Schedule;
GO

---
-- Testing Functions
---
SELECT student_id, u45389618.fn_CalculateStudentGPA(student_id) as GPA FROM Student;

SELECT u45389618.fn_getWeekDayName(0) AS WeekDayName; -- 0 is Monday
SELECT u45389618.fn_getWeekDayName(1) AS WeekDayName; -- 1 is Tuesday
SELECT u45389618.fn_getWeekDayName(2) AS WeekDayName; -- 2 is Wednesday

SELECT u45389618.fn_getSemesterName(0) AS SemesterName; -- 0 is the Winter semester
SELECT u45389618.fn_getSemesterName(1) AS SemesterName; -- 1 is the Summer semester
GO

---
-- Testing Triggers
---

-- Attempt to insert a record that will violate the triggers

-- tr_Validate_Course_Capacity
INSERT INTO Enrollment (student_id, course_id, enrollment_date, grade)
VALUES 
    (10000030, 1, '2022-09-01', NULL), -- course number 1 has max_capacity 10 people. Currently there are 8.
    (10000031, 1, '2022-09-01', NULL),
    (10000032, 1, '2022-09-01', NULL); -- this should violate the tr_Validate_Course_Capacity trigger
GO

-- tr_Check_Graduation_Date
INSERT INTO Person (email, name, surname)
VALUES ('amarie@examplee.com', 'Anna', 'Marie'); -- add a new person for testing purposes

DECLARE @person_id numeric(8,0) = SCOPE_IDENTITY(); -- get the new person_id

INSERT INTO Student (student_id, program_id, study_year, admission_date, graduation_date, status)
VALUES (@person_id, 101, 1, '2022-09-01', '2021-09-01', 'graduated'); -- This should violate the tr_Check_Graduation_Date trigger
GO

-- tr_Check_Program_Duration trigger
UPDATE Student
SET study_year = 4
WHERE student_id = 10000052;
GO

---
-- Testing Procedures
---

-- sp_AddNewPerson @name, @surname, @email, @person_id OUTPUT - is just a auxillary procedure - won't be tested publically

-- Add a new student
EXEC sp_AddNewStudent 'Martin', 'Corovcak', 'martin1@example.com', 101, '2022-09-01';

-- Add a new teacher
EXEC sp_AddNewTeacher 'John', 'Doe', 'johndoe1234@example.com', 'PhD', '00420123456789', 'https://example.com', 'Room 101'; 

-- Enroll a student to a course
-- sp_EnrollStudentInCourse @student_id, @course_id, @enrollment_date
-- enrollment_date must be specified - can be handled by the application layer or system administrator
EXEC sp_EnrollStudentInCourse 10000030, 1, '2022-09-01';

-- Update student grade
-- sp_UpdateStudentGrade @student_id, @course_id, @enrollment_date, @grade
EXEC sp_UpdateStudentGrade 10000003, 1, '2022-09-01', 1;

-- Calculate and update the GPA and honor status of specific student
EXEC sp_UpdateStudentGpaAndHonorStatus 10000003;

SELECT student_id, gpa, honor_status FROM Student WHERE student_id = 10000003; -- GPA should be 1.00, honor_status should be 'Honored'

-- Update student grade, GPA and honor status
-- Since this will be usually executed together, there is a procedure that does all of this at once
-- sp_UpdateStudentGradeGpaAndHonorStatus @student_id, @course_id, @enrollment_date, @grade
EXEC sp_UpdateStudentGradeGpaAndHonorStatus 10000003, 2, '2022-09-01', 3;

SELECT student_id, gpa, honor_status FROM Student WHERE student_id = 10000003; -- GPA should be 2.00, honor_status should be 'Good Standing'

-- Assign teacher to a course
-- sp_AssignTeacherToCourse @teacher_id, @course_id
EXEC sp_AssignTeacherToCourse 10000001, 2;

-- Add a new Course
-- sp_AddCourse @name, @credits, @language, @description, @semester, @garant_id, @max_capacity
EXEC sp_AddCourse 'Database Application Development', 4, 'Czech', 'This course is about developing database applications.', 1, 10000001, 50;

-- Add a new Program
-- sp_AddProgram @name, @duration_years
EXEC sp_AddProgram 'Software Engineering', 3;

EXEC sp_AddProgram 'Software Engineering', 3; -- Duplicate program name - should throw an error

-- Add a new Course_Schedule
-- sp_AddCourseSchedule @course_id, @start_time, @end_time, @day_of_week, @location
EXEC sp_UpdateCourseSchedule 1, '19:30:00', '21:00:00', 1, 'Room 101';
