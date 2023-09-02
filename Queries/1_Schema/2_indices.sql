-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script defines indices for the Student Information System.

-- Foreign Key Indexes
-- CREATE INDEX idx_Teacher_TeacherId ON Teacher (teacher_id); -- No need for this cause we have PK on Teacher(teacher_id)

-- CREATE INDEX idx_Student_StudentId ON Student (student_id);
CREATE INDEX idx_Student_ProgramId ON Student (program_id);

CREATE INDEX idx_Course_GarantId ON Course (garant_id);

-- CREATE INDEX idx_Teaches_TeacherId ON Teaches (teacher_id); -- No need for this cause we have composite PK on Teaches(teacher_id, course_id)
CREATE INDEX idx_Teaches_CourseId ON Teaches (course_id);

-- CREATE INDEX idx_Enrollment_StudentId ON Enrollment (student_id);
CREATE INDEX idx_Enrollment_CourseId ON Enrollment (course_id);

--CREATE INDEX idx_Course_Schedule_CourseId ON Course_Schedule (course_id);
