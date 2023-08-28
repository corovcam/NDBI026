-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script defines indices for the Student Information System.

-- Foreign Key Indexes
CREATE INDEX idx_Teacher_TeacherId ON Teacher (teacher_id);

CREATE INDEX idx_Student_StudentId ON Student (student_id);
CREATE INDEX idx_Student_ProgramId ON Student (program_id);

CREATE INDEX idx_Course_GarantId ON Course (garant_id);

CREATE INDEX idx_Teaches_TeacherId ON Teaches (teacher_id);
CREATE INDEX idx_Teaches_CourseId ON Teaches (course_id);

CREATE INDEX idx_Enrollment_StudentId ON Enrollment (student_id);
CREATE INDEX idx_Enrollment_CourseId ON Enrollment (course_id);

CREATE INDEX idx_Course_Schedule_CourseId ON Course_Schedule (course_id);

-- sp_EnrollStudentInCourse:
-- This procedure involves inserting data into the Enrollment table based on student_id and course_id. Indexes on these columns will help speed up the insert and improve query performance.
CREATE INDEX idx_Enrollment_StudentCourse ON Enrollment (student_id, course_id);

-- sp_AddProgram:
-- This procedure inserts data into the Program table. An index on the name column will help with the duplicate check.
CREATE UNIQUE INDEX idx_Program_Name ON Program (name);