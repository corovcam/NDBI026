-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script generates statistics for the database.

UPDATE STATISTICS Person;
UPDATE STATISTICS Teacher;
UPDATE STATISTICS Program;
UPDATE STATISTICS Student;
UPDATE STATISTICS Course;
UPDATE STATISTICS Teaches;
UPDATE STATISTICS Enrollment;
UPDATE STATISTICS Course_Schedule;