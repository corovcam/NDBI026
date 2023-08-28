-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates functions for the Student Information System.

DROP FUNCTION IF EXISTS fn_CalculateStudentGPA;
DROP FUNCTION IF EXISTS fn_getWeekDayName;
DROP FUNCTION IF EXISTS fn_getSemesterName;
GO

-- This function calculates the Grade Point Average (GPA) for a student. The GPA is calculated as the average of the grades of all courses the student has enrolled in.
CREATE OR ALTER FUNCTION fn_CalculateStudentGPA (@student_id numeric(8,0))
RETURNS decimal(4, 2)
AS
BEGIN
    DECLARE @gpa decimal(4, 2);

    SELECT @gpa = AVG(grade)
    FROM Enrollment
    WHERE student_id = @student_id AND grade IS NOT NULL;

    RETURN @gpa;
END;
GO

-- Get Week Day Name from index number (0-6)
CREATE OR ALTER FUNCTION fn_getWeekDayName (@week_day_index int)
RETURNS varchar(10)
AS
BEGIN
    DECLARE @week_day_name varchar(10);

    SELECT @week_day_name = CASE @week_day_index
        WHEN 0 THEN 'Monday'
        WHEN 1 THEN 'Tuesday'
        WHEN 2 THEN 'Wednesday'
        WHEN 3 THEN 'Thursday'
        WHEN 4 THEN 'Friday'
        WHEN 5 THEN 'Saturday'
        WHEN 6 THEN 'Sunday'
    END;

    RETURN @week_day_name;
END;
GO

-- Get Semester Name from index number (0-2)
CREATE OR ALTER FUNCTION fn_getSemesterName (@semester_index int)
RETURNS varchar(10)
AS
BEGIN
    DECLARE @semester_name varchar(10);

    SELECT @semester_name = CASE @semester_index
        WHEN 0 THEN 'Winter'
        WHEN 1 THEN 'Summer'
        WHEN 2 THEN 'Both'
    END;

    RETURN @semester_name;
END;
GO