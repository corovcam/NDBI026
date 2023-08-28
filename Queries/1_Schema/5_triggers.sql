-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates triggers for the Student Information System.


DROP TRIGGER IF EXISTS tr_Validate_Course_Capacity;
DROP TRIGGER IF EXISTS tr_Check_Graduation_Date;
DROP TRIGGER IF EXISTS tr_Update_Study_Year;
DROP TRIGGER IF EXISTS tr_Check_Program_Duration;
GO

-- This trigger checks if a course's capacity is exceeded when enrolling a new student. If so, it cancels the enrollment.
CREATE OR ALTER TRIGGER tr_Validate_Course_Capacity
ON Enrollment
AFTER INSERT
AS
BEGIN
    -- Check if the new enrollments exceed course max capacity
    IF EXISTS (
        SELECT e.course_id
        FROM (
            SELECT course_id, SUM(1) AS total_enrollments
            FROM Enrollment
            GROUP BY course_id
        ) AS e
        INNER JOIN inserted AS i ON e.course_id = i.course_id
        INNER JOIN Course AS c ON e.course_id = c.course_id
        WHERE e.total_enrollments > c.max_capacity
    )
    BEGIN
        RAISERROR ('Course capacity exceeded for some enrollments', 16, 1);
        ROLLBACK TRANSACTION; -- Rollback the insert
    END
END;
GO

-- This trigger validates that the graduation date of a student is not earlier than their admission date.
CREATE OR ALTER TRIGGER tr_Check_Graduation_Date
ON Student
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE graduation_date < admission_date)
    BEGIN
        RAISERROR ('The graduation date cannot be earlier than the admission date.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- This trigger updates the study_year of each student after a certain period. For example, it can increase the study_year every academic year.
CREATE OR ALTER TRIGGER tr_Update_Study_Year
ON Student
FOR UPDATE
AS
BEGIN
    UPDATE Student
    SET study_year = study_year + 1
    WHERE YEAR(getdate()) - YEAR(admission_date) > study_year;
END;
GO

-- This trigger ensures a student's study_year does not exceed the program duration when updating the Student table.
CREATE OR ALTER TRIGGER tr_Check_Program_Duration
ON Student
AFTER INSERT, UPDATE
AS
BEGIN
    -- Find students who have a study_year greater than the duration of their program
    IF EXISTS (
        SELECT 1 
        FROM inserted i 
        INNER JOIN Program p ON i.program_id = p.program_id 
        WHERE i.study_year > p.duration_years
    )
    BEGIN
        RAISERROR ('The study year cannot exceed the duration of the program.', 16, 1);
        -- Rollback the transaction and raise an error
        ROLLBACK TRANSACTION;
    END
END;
GO
