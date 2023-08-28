-- Author: Martin Čorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates the database schema for the Student Information System.

-- Drop tables if they exist

DROP TABLE IF EXISTS Course_Schedule;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Teaches;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Program;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Person;

-- Person
CREATE TABLE Person
(
    person_id numeric(8,0) identity(10000000, 1) 
        constraint Person_PK primary key
        constraint Person_CHK_ID
      CHECK (person_id > 9999999),
    email VARCHAR(50)
        constraint Person_Unique_Email
      unique
        constraint Person_CHK_Email
      check (email LIKE '%@%.%' AND email NOT LIKE '@%'
            AND email NOT LIKE '%@%@%'),
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL
);

-- Teacher
create table Teacher
(
    teacher_id numeric(8,0)
        constraint Teacher_PK
      primary key
        constraint Teacher_FK_Person
      references Person(person_id)
      on update no action
      on delete no action, -- Person entity can never be deleted (a teacher can come back to school after some time)
    degree VARCHAR(10),
    phone_number VARCHAR(20),
    website VARCHAR(255),
    office VARCHAR(20),
);

-- Study Program
CREATE TABLE Program
(
    program_id numeric(4,0)
        constraint Program_PK primary key 
        constraint Program_CHK_ID
      CHECK (program_id >= 100),
    name VARCHAR(50) NOT NULL,
    duration_years numeric(1,0) not null
        constraint Program_CHK_Duration
      check (duration_years>=1)
);

-- Student
create table Student
(
    student_id numeric(8,0)
        constraint Student_PK
      primary key
        constraint Student_FK_Person
      references Person(person_id)
      on update no action
      on delete no action, -- Person entity can never be deleted (a student can come back to school after some time)
    program_id numeric(4,0)
        constraint Student_FK_Program
      references Program(program_id)
      on update no action
      on delete set null,
    study_year numeric(1,0) not null
        constraint Student_CHK_StudyYear
      check (study_year>0),
    admission_date DATE NOT NULL, -- Student is created when he/she is admitted
    graduation_date DATE,
    gpa decimal(4,2)
        constraint Student_CHK_GPA
      check (gpa>=1 and gpa<=3),
    status VARCHAR(20) not null
        constraint Student_CHK_Status
      check (status IN ('active', 'graduated', 'suspended', 'expelled')),
    honor_status VARCHAR(20)
        constraint Student_CHK_HonorStatus
      check (honor_status IN ('Honored', 'Good Standing', 'Passing'))
);

-- Course
create table Course
(
    course_id numeric(8,0)
        constraint Course_PK
      primary key,
    name VARCHAR(50) not null,
    credits numeric(2,0) not null
        constraint Course_CHK_Credits
      check (credits>0), -- Credits are always positive number
    language VARCHAR(20),
    description VARCHAR(255),
    semester numeric(1,0) not null -- 0 is Winter Semester, 1 is Summer Semester, 2 is Both
        constraint Course_CHK_Semester
      check (semester>=0 and semester<=2),
    garant_id numeric(8,0) -- One and only one garant per course (or null for archived courses)
        constraint Course_FK_Garant
      references Teacher(teacher_id)
      on update no action
      on delete set null, -- for historical purposes
    max_capacity numeric(3,0) not null
        constraint Course_CHK_MaxCapacity
      check (max_capacity>0)
);

-- Teaches (many-to-many relationship between Teacher and Course)
create table Teaches
(
    teacher_id numeric(8,0)
        constraint Teaches_FK_Teacher
      references Teacher(teacher_id)
      on update no action
      on delete no action, -- keep Teaches even if teacher (with certain ID) is deleted (for historical purposes or if teacher comes back)
    course_id numeric(8,0)
        constraint Teaches_FK_Course
      references Course(course_id)
      on update no action
      on delete cascade, -- If a course is deleted, the historical data is irrelevant
    primary key (teacher_id, course_id) -- Teacher can teach one course multiple times
);

-- Enrollments (many-to-many relationship between Student and Course)
create table Enrollment
(
    student_id numeric(8,0)
        constraint Enrollment_FK_Student
      references Student(student_id)
      on update no action
      on delete no action, -- keep enrollment (for historical purposes or if student comes back)
    course_id numeric(8,0)
        constraint Enrollment_FK_Course
      references Course(course_id)
      on update no action
      on delete no action, -- keep enrollment (for historical purposes, gpa calculation, etc.)
    enrollment_date DATE NOT NULL,
    grade numeric(1,0)
        constraint Enrollment_CHK_Grade
      check (grade>=1 and grade<=4), -- 1 is A, 2 is B, 3 is C, 4 is F (failed)
    primary key (student_id, course_id, enrollment_date) -- Enrollment is unique per student, course and date
);

-- Course_Schedule
CREATE TABLE Course_Schedule
(
    course_id numeric(8,0)
        constraint Course_Schedule_FK_Course
      references Course(course_id)
      on update no action
      on delete cascade,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    day_of_week numeric(1,0) NOT NULL -- 0 is Monday, 1 is Tuesday, ..., 6 is Sunday
        constraint Course_Schedule_CHK_DayOfWeek
      check (day_of_week>=0 and day_of_week<=6),
    location VARCHAR(50), -- Location is optional; room number, building, etc.
    primary key (course_id, start_time, end_time, day_of_week)
);