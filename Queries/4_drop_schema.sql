-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script correctly deletes the database schema and objects for the Student Information System.

DROP VIEW vw_Student_Details;
DROP VIEW vw_Student_Enrollment_Details;
DROP VIEW vw_Teacher_Courses_Details;
DROP VIEW vw_Course_Schedule_Details;
DROP VIEW vw_Teacher_Schedule;

DROP FUNCTION fn_CalculateStudentGPA;
DROP FUNCTION fn_getWeekDayName;
DROP FUNCTION fn_getSemesterName;

DROP PROCEDURE sp_AddNewPerson;
DROP PROCEDURE sp_AddNewStudent;
DROP PROCEDURE sp_AddNewTeacher;
DROP PROCEDURE sp_EnrollStudentInCourse;
DROP PROCEDURE sp_UpdateStudentGrade;
DROP PROCEDURE sp_UpdateStudentGpaAndHonorStatus;
DROP PROCEDURE sp_UpdateStudentGradeGpaAndHonorStatus;
DROP PROCEDURE sp_AssignTeacherToCourse;
DROP PROCEDURE sp_AddCourse;
DROP PROCEDURE sp_AddProgram;
DROP PROCEDURE sp_UpdateCourseSchedule;

DROP TABLE Course_Schedule;
DROP TABLE Enrollment;
DROP TABLE Teaches;
DROP TABLE Course;
DROP TABLE Student;
DROP TABLE Program;
DROP TABLE Teacher;
DROP TABLE Person;
