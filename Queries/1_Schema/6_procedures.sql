-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates procedures for the Student Information System.

DROP PROCEDURE IF EXISTS sp_AddNewPerson;
DROP PROCEDURE IF EXISTS sp_AddNewStudent;
DROP PROCEDURE IF EXISTS sp_AddNewTeacher;
DROP PROCEDURE IF EXISTS sp_EnrollStudentInCourse;
DROP PROCEDURE IF EXISTS sp_UpdateStudentGrade;
DROP PROCEDURE IF EXISTS sp_UpdateStudentGpaAndHonorStatus;
DROP PROCEDURE IF EXISTS sp_UpdateStudentGradeGpaAndHonorStatus;
DROP PROCEDURE IF EXISTS sp_AssignTeacherToCourse;
DROP PROCEDURE IF EXISTS sp_AddCourse;
DROP PROCEDURE IF EXISTS sp_AddProgram;
DROP PROCEDURE IF EXISTS sp_UpdateCourseSchedule;
GO

-- This procedure is a helper procedure for sp_UpdateStudentStatus and sp_TransferStudent.
CREATE OR ALTER PROCEDURE sp_AddNewPerson
    (@first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @email VARCHAR(50),
    @person_id numeric(8,0) OUTPUT)
AS
BEGIN
    -- Insert the person
    INSERT INTO Person
        (name, surname, email)
    VALUES
        (@first_name, @last_name, @email);

    -- Get the person_id
    SET @person_id = SCOPE_IDENTITY();
END;
GO

-- This procedure adds a new student to the database. It first inserts the person, then inserts the student.
CREATE OR ALTER PROCEDURE sp_AddNewStudent
    (@first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @email VARCHAR(50),
    @program_id numeric(8,0),
    @admission_date DATE)
AS
BEGIN
    -- Insert the person
    DECLARE @person_id numeric(8,0);
    EXEC sp_AddNewPerson @first_name, @last_name, @email, @person_id OUTPUT;

    -- Insert the student
    INSERT INTO Student
        (student_id, program_id, study_year, admission_date, status)
    VALUES
        (@person_id, @program_id, 1, @admission_date, 'active');
END;
GO

-- This procedure adds a new teacher to the database. It first inserts the person, then inserts the teacher.
CREATE OR ALTER PROCEDURE sp_AddNewTeacher
    (@first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @email VARCHAR(50),
    @degree VARCHAR(10) = NULL,
    @phone_number VARCHAR(20) = NULL,
    @website VARCHAR(255) = NULL,
    @office VARCHAR(20) = NULL)
AS
BEGIN
    -- Insert the person
    DECLARE @person_id numeric(8,0);
    EXEC sp_AddNewPerson @first_name, @last_name, @email, @person_id OUTPUT;

    -- Insert the teacher
    INSERT INTO Teacher
        (teacher_id, degree, phone_number, website, office)
    VALUES
        (@person_id, @degree, @phone_number, @website, @office);
END;
GO

-- Enroll a student in a course
CREATE OR ALTER PROCEDURE sp_EnrollStudentInCourse
    (@student_id numeric(8,0),
    @course_id numeric(8,0),
    @enrollment_date DATE)
AS
BEGIN
    -- Insert the enrollment
    INSERT INTO Enrollment
        (student_id, course_id, enrollment_date)
    VALUES
        (@student_id, @course_id, @enrollment_date);
END;
GO

-- Update the grade for a student in a course
CREATE OR ALTER PROCEDURE sp_UpdateStudentGrade
    (@student_id numeric(8,0),
    @course_id numeric(8,0),
    @enrollment_date DATE,
    @grade numeric(1,0))
AS
BEGIN
    -- Update the grade
    UPDATE Enrollment
    SET grade = @grade
    WHERE student_id = @student_id
        AND course_id = @course_id
        AND enrollment_date = @enrollment_date;
END;
GO

-- This procedure updates a student's status based on their GPA. It first retrieves the GPA using the fn_CalculateStudentGPA function, then checks whether the student is eligible to continue in the program.
CREATE OR ALTER PROCEDURE sp_UpdateStudentGpaAndHonorStatus
    (@student_id numeric(8,0))
AS
BEGIN
    DECLARE @gpa decimal(4, 2);
    DECLARE @honor_status varchar(20);

    -- Get the GPA
    SET @gpa = u45389618.fn_CalculateStudentGPA(@student_id);

    -- Determine the status
    SET @honor_status = CASE 
        WHEN @gpa <= 1.0 THEN 'Honored'
        WHEN @gpa <= 2.0 THEN 'Good Standing'
        ELSE 'Passing'
    END;

    -- Update the honor status and GPA
    UPDATE Student
    SET gpa = @gpa, honor_status = @honor_status
    WHERE student_id = @student_id;
END;
GO

-- Update the grade for a student in a course and update the student's honor status based on the new GPA
CREATE OR ALTER PROCEDURE sp_UpdateStudentGradeGpaAndHonorStatus
    (@student_id numeric(8,0),
    @course_id numeric(8,0),
    @enrollment_date DATE,
    @grade numeric(1,0))
AS
BEGIN
    BEGIN TRY
        -- Start transaction for Update, Select and Update
        BEGIN TRANSACTION;
            -- Update the grade
            EXEC sp_UpdateStudentGrade @student_id, @course_id, @enrollment_date, @grade;

            -- Update the student's status
            EXEC sp_UpdateStudentGpaAndHonorStatus @student_id;
        COMMIT;
    END TRY
    BEGIN CATCH
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
            DECLARE @ErrorState INT = ERROR_STATE();

            RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

            ROLLBACK;
    END CATCH;
END;
GO

-- This procedure assigns a teacher to a course. It first checks if the teacher is already assigned to the course. If not, it inserts the assignment.
CREATE OR ALTER PROCEDURE sp_AssignTeacherToCourse
    (@teacher_id numeric(8,0),
    @course_id numeric(8,0))
AS
BEGIN
    DECLARE @assignment_exists bit;

    -- Check if the teacher is already assigned to the course
    SET @assignment_exists = (
        SELECT COUNT(*)
    FROM Teaches
    WHERE teacher_id = @teacher_id
        AND course_id = @course_id
    );

    IF @assignment_exists = 0
    BEGIN
        -- Insert the assignment
        INSERT INTO Teaches
            (teacher_id, course_id)
        VALUES
            (@teacher_id, @course_id);
    END
    ELSE
    BEGIN
        RAISERROR ('Teacher is already assigned to the course', 16, 1);
    END
END;
GO

-- This procedure adds a new Course to the database. It determines the new course ID by incrementing the maximum course ID in the database. It then inserts the new course.
CREATE OR ALTER PROCEDURE sp_AddCourse
    (@name VARCHAR(50),
    @credits numeric(2,0),
    @language VARCHAR(20) = NULL,
    @description VARCHAR(255) = NULL,
    @semester numeric(1,0),
    @garant_id numeric(8,0),
    @max_capacity numeric(3,0))
AS
BEGIN
    BEGIN TRY
        -- Start transaction for Select and Insert
        BEGIN TRANSACTION;
            -- Get the new course ID
            DECLARE @new_course_id numeric(8,0);
            SET @new_course_id = (
                SELECT ISNULL(MAX(course_id), 0) + 1
            FROM Course
            );

            -- Insert the new course
            INSERT INTO Course
                (course_id, name, credits, language, description, semester, garant_id, max_capacity)
            VALUES
                (@new_course_id, @name, @credits, @language, @description, @semester, @garant_id, @max_capacity);
        COMMIT;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

        ROLLBACK;
    END CATCH;
END;
GO

-- This procedure adds a new program to the database. It determines the new program ID by incrementing the maximum program ID in the database. It then inserts the new program.
-- It also checks if Program with the same name already exists. If it does, it raises an error.
CREATE OR ALTER PROCEDURE sp_AddProgram
    (@name VARCHAR(50),
    @duration_years numeric(1,0))
AS
BEGIN
    BEGIN TRY
        -- Start transaction for Select and Insert
        BEGIN TRANSACTION;
            -- Check if program with the same name already exists
            IF EXISTS (
                SELECT *
            FROM Program
            WHERE name = @name
            )
            BEGIN
                RAISERROR ('Program with the same name already exists', 16, 1);
            END
            ELSE
            BEGIN
                -- Get the new program ID
                DECLARE @new_program_id numeric(4,0);
                SET @new_program_id = (
                    SELECT ISNULL(MAX(program_id), 0) + 1
                FROM Program
                );

                -- Insert the new program
                INSERT INTO Program
                    (program_id, name, duration_years)
                VALUES
                    (@new_program_id, @name, @duration_years);
            END
        COMMIT;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

        ROLLBACK;
    END CATCH;
END;
GO


-- This procedure adds a new schedule to a course. It first checks if the new schedule conflicts with any existing schedules for the course. If there is no conflict, it updates the schedule.
CREATE OR ALTER PROCEDURE sp_UpdateCourseSchedule
    (@course_id numeric(8,0),
    @start_time TIME,
    @end_time TIME,
    @day_of_week numeric(1,0),
    @location VARCHAR(50))
AS
BEGIN
    DECLARE @conflict_exists bit;

    -- Check if the new schedule conflicts with any existing schedules for the course
    SET @conflict_exists = (
        SELECT COUNT(*)
    FROM Course_Schedule
    WHERE course_id = @course_id
        AND ((start_time BETWEEN @start_time AND @end_time) OR (end_time BETWEEN @start_time AND @end_time))
        AND day_of_week = @day_of_week
    );

    IF @conflict_exists = 0
    BEGIN
        -- Update the course schedule
        INSERT INTO Course_Schedule
            (course_id, start_time, end_time, day_of_week, location)
        VALUES
            (@course_id, @start_time, @end_time, @day_of_week, @location);
    END
    ELSE
    BEGIN
        RAISERROR('The new schedule conflicts with an existing schedule for the course.', 16, 1);
    END
END;
GO
