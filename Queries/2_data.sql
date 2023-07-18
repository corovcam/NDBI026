-- Author: Martin Ćorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script loads sample data into the Student Information System.

-- Person
INSERT INTO Person (person_id, email, name, surname)
VALUES 
(10000001, 'jdoe@example.com', 'John', 'Doe'),
(10000002, 'mdoe@example.com', 'Mary', 'Doe'),
(10000003, 'jsmith@example.com', 'Jane', 'Smith'),
(10000004, 'rjones@example.com', 'Robert', 'Jones'),
(10000005, 'lsmith@example.com', 'Laura', 'Smith'),
(10000006, 'jthompson@example.com', 'Jack', 'Thompson'),
(10000007, 'awhite@example.com', 'Alice', 'White'),
(10000008, 'mjohnson@example.com', 'Mike', 'Johnson');

-- Teacher
INSERT INTO Teacher (teacher_id, degree, phone_number, website, office)
VALUES
(10000001, 'PhD', '555-123-4567', 'www.example.com/jdoe', 'Room 1A'),
(10000002, 'MSc', '555-123-4568', 'www.example.com/mdoe', 'Room 2B'),
(10000005, 'PhD', '555-123-4569', 'www.example.com/lsmith', 'Room 3C'),
(10000006, 'MSc', '555-123-4570', 'www.example.com/jthompson', 'Room 4D');

-- Department
INSERT INTO Department (department_id, name, head_id)
VALUES
(1, 'Computer Science', 10000001),
(2, 'Mathematics', 10000002),
(3, 'Physics', 10000005),
(4, 'Chemistry', 10000006);

-- Program
INSERT INTO Program (program_id, name, department_id, duration_years)
VALUES
(1, 'Software Engineering', 1, 4),
(2, 'Applied Mathematics', 2, 3),
(3, 'Physics', 3, 4),
(4, 'Chemistry', 4, 3);

-- Student
INSERT INTO Student (student_id, program_id, study_year, admission_date, graduation_date)
VALUES
(10000003, 1, 1, '2022-09-01', NULL),
(10000004, 2, 2, '2021-09-01', NULL),
(10000007, 3, 1, '2022-09-01', NULL),
(10000008, 4, 2, '2021-09-01', NULL);

-- Course
INSERT INTO Course (course_id, name, credits, language, description, semester, year_taught, garant_id)
VALUES
(1, 'Algorithms', 3, 'English', 'Study of algorithms', 0, 2, 10000001),
(2, 'Calculus', 3, 'English', 'Study of calculus', 0, 1, 10000002),
(3, 'Quantum Mechanics', 3, 'English', 'Study of quantum mechanics', 1, 3, 10000005),
(4, 'Organic Chemistry', 3, 'English', 'Study of organic chemistry', 1, 2, 10000006);

-- Enrollment
INSERT INTO Enrollment (student_id, course_id, enrollment_date, grade)
VALUES
(10000003, 1, '2022-09-01', NULL),
(10000004, 2, '2022-09-01', NULL),
(10000007, 3, '2022-09-01', NULL),
(10000008, 4, '2022-09-01', NULL);

-- Course_Schedule
INSERT INTO Course_Schedule (course_id, start_time, end_time, day_of_week, location)
VALUES
(1, '09:00:00', '10:30:00', 1, 'Room 101'),
(2, '11:00:00', '12:30:00', 3, 'Room 202'),
(3, '13:00:00', '14:30:00', 2, 'Room 303'),
(4, '15:00:00', '16:30:00', 4, 'Room 404');