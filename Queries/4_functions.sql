-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates functions for the Student Information System.

DROP FUNCTION IF EXISTS fn_CalculateStudentGPA;

-- This function calculates the Grade Point Average (GPA) for a student. The GPA is calculated as the average of the grades of all courses the student has enrolled in.
CREATE FUNCTION fn_CalculateStudentGPA (@student_id numeric(8,0))
RETURNS decimal(4, 2)
AS
BEGIN
    DECLARE @gpa decimal(4, 2);

    SELECT @gpa = AVG(grade)
    FROM Enrollment
    WHERE student_id = @student_id AND grade IS NOT NULL;

    RETURN @gpa;
END;

