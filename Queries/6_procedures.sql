-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates procedures for the Student Information System.

DROP PROCEDURE IF EXISTS sp_UpdateStudentStatus;
DROP PROCEDURE IF EXISTS sp_UpdateCourseSchedule;
DROP PROCEDURE IF EXISTS sp_AssignTeacherToCourse;
DROP PROCEDURE IF EXISTS sp_TransferStudent;
DROP PROCEDURE IF EXISTS sp_UpdateCourseScheduleAndTeacher;

-- This procedure updates a student's status based on their GPA. It first retrieves the GPA using the fn_CalculateStudentGPA function, then checks whether the student is eligible to continue in the program.
CREATE OR ALTER PROCEDURE sp_UpdateStudentStatus
    (@student_id numeric(8,0))
AS
BEGIN
    DECLARE @gpa decimal(4, 2);
    DECLARE @status varchar(20);

    -- Get the GPA
    SET @gpa = u45389618.fn_CalculateStudentGPA(@student_id);

    -- Determine the status
    SET @status = CASE 
        WHEN @gpa <= 1.0 THEN 'Honored'
        WHEN @gpa <= 2.0 THEN 'Good Standing'
        ELSE 'Passing'
    END;

    -- Update the status
    UPDATE Student
    SET honor_status = @status
    WHERE student_id = @student_id;
END;

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
        INSERT INTO Course_Schedule (course_id, start_time, end_time, day_of_week, location)
        VALUES (@course_id, @start_time, @end_time, @day_of_week, @location);
    END
    ELSE
    BEGIN
        RAISERROR('The new schedule conflicts with an existing schedule for the course.', 16, 1);
    END
END;

-- -- This procedure assigns a teacher to a course. It first checks if the teacher is already assigned to another course at the same time. If there is no conflict, it assigns the teacher to the course.
-- CREATE OR ALTER PROCEDURE sp_AssignTeacherToCourse
--     (@teacher_id numeric(8,0),
--     @course_id numeric(8,0))
-- AS
-- BEGIN
--     DECLARE @conflict_exists bit;

--     -- Check if the teacher is already assigned to another course at the same time
--     SET @conflict_exists = (
--         SELECT COUNT(*)
--     FROM Course_Schedule cs
--         INNER JOIN Course c ON cs.course_id = c.course_id
--     WHERE c.garant_id = @teacher_id
--         AND cs.course_id != @course_id
--         AND EXISTS (
--                 SELECT *
--         FROM Course_Schedule
--         WHERE course_id = @course_id
--             AND ((start_time BETWEEN cs.start_time AND cs.end_time) OR (end_time BETWEEN cs.start_time AND cs.end_time))
--             AND day_of_week = cs.day_of_week
--             )
--     );

--     IF @conflict_exists = 0
--     BEGIN
--         -- Assign the teacher to the course
--         UPDATE Course
--         SET garant_id = @teacher_id
--         WHERE course_id = @course_id;
--     END
--     ELSE
--     BEGIN
--         RAISERROR('The teacher is already assigned to another course at the same time.', 16, 1);
--     END
-- END;

-- -- This procedure transfers a student from one program to another. It's a complex operation that involves multiple updates, so a transaction is used to ensure that all updates are successful.
-- CREATE OR ALTER PROCEDURE sp_TransferStudent
--     (@student_id numeric(8,0),
--     @new_program_id numeric(8,0))
-- AS
-- BEGIN
--     -- Start the transaction
--     BEGIN TRANSACTION;

--     BEGIN TRY
--         -- Update the student's program
--         UPDATE Student
--         SET program_id = @new_program_id
--         WHERE student_id = @student_id;

--         -- Update the student's enrollments
--         DELETE FROM Enrollment
--         WHERE student_id = @student_id;

--         -- If there is no error, commit the transaction
--         COMMIT TRANSACTION;
--     END TRY
--     BEGIN CATCH
--         -- If there is an error, rollback the transaction
--         ROLLBACK TRANSACTION;

--         -- Raise an error
--         RAISERROR('An error occurred while transferring the student.', 16, 1);
--     END CATCH;
-- END;

-- This procedure updates the schedule of a course and assigns a new teacher to the course. A transaction is used to ensure that both updates are successful.
-- CREATE PROCEDURE OR ALTER sp_UpdateCourseScheduleAndTeacher
--     (@course_id numeric(8,0),
--     @start_time TIME,
--     @end_time TIME,
--     @day_of_week numeric(1,0),
--     @location VARCHAR(50),
--     @teacher_id numeric(8,0))
-- AS
-- BEGIN
--     -- Start the transaction
--     BEGIN TRANSACTION;

--     BEGIN TRY
--         -- Update the course schedule
--         EXEC sp_UpdateCourseSchedule @course_id, @start_time, @end_time, @day_of_week, @location;

--         -- Assign the teacher to the course
--         EXEC sp_AssignTeacherToCourse @teacher_id, @course_id;

--         -- If there is no error, commit the transaction
--         COMMIT TRANSACTION;
--     END TRY
--     BEGIN CATCH
--         -- If there is an error, rollback the transaction
--         ROLLBACK TRANSACTION;

--         -- Raise an error
--         RAISERROR('An error occurred while updating the course schedule and teacher.', 16, 1);
--     END CATCH;
-- END;

-- -- This procedure enrolls a student in multiple courses. It uses a transaction to ensure that all enrollments are successful. If the enrollment in any course fails, all enrollments are rolled back.
-- CREATE OR ALTER PROCEDURE sp_EnrollStudentInMultipleCourses (@student_id numeric(8,0), @course_ids VARCHAR(max))
-- AS
-- BEGIN
--     -- Start the transaction
--     BEGIN TRANSACTION;

--     BEGIN TRY
--         -- Loop through the course_ids table
--         DECLARE @course_id numeric(8,0);
--         DECLARE course_cursor CURSOR FOR 
--         SELECT course_id FROM STRING_SPLIT(@course_ids, ',');
--         OPEN course_cursor;

--         FETCH NEXT FROM course_cursor INTO @course_id;
--         WHILE @@FETCH_STATUS = 0
--         BEGIN
--             -- Enroll the student in the course
--             EXEC sp_EnrollStudentInCourse @student_id, @course_id;

--             FETCH NEXT FROM course_cursor INTO @course_id;
--         END;

--         CLOSE course_cursor;
--         DEALLOCATE course_cursor;

--         -- If there is no error, commit the transaction
--         COMMIT TRANSACTION;
--     END TRY
--     BEGIN CATCH
--         -- If there is an error, rollback the transaction
--         ROLLBACK TRANSACTION;

--         -- Raise an error
--         RAISERROR('An error occurred while enrolling the student in multiple courses.', 16, 1);
--     END CATCH;
-- END;

-- This procedure updates the grades of a student. It uses a transaction to ensure that all updates are successful. If the update of any grade fails, all updates are rolled back.
-- CREATE OR ALTER PROCEDURE sp_UpdateStudentGrades (@student_id numeric(8,0), @grades TABLE (course_id numeric(8,0), grade numeric(1,0)))
-- AS
-- BEGIN
--     -- Start the transaction
--     BEGIN TRANSACTION;

--     BEGIN TRY
--         -- Loop through the grades table
--         DECLARE @course_id numeric(8,0), @grade numeric(1,0);
--         DECLARE grades_cursor CURSOR FOR 
--         SELECT course_id, grade FROM @grades;
--         OPEN grades_cursor;

--         FETCH NEXT FROM grades_cursor INTO @course_id, @grade;
--         WHILE @@FETCH_STATUS = 0
--         BEGIN
--             -- Update the grade
--             UPDATE Enrollment
--             SET grade = @grade
--             WHERE student_id = @student_id AND course_id = @course_id;

--             FETCH NEXT FROM grades_cursor INTO @course_id, @grade;
--         END;

--         CLOSE grades_cursor;
--         DEALLOCATE grades_cursor;

--         -- If there is no error, commit the transaction
--         COMMIT TRANSACTION;
--     END TRY
--     BEGIN CATCH
--         -- If there is an error, rollback the transaction
--         ROLLBACK TRANSACTION;

--         -- Raise an error
--         RAISERROR('An error occurred while updating the student grades.', 16, 1);
--     END CATCH;
-- END;