-- Author: Martin Ćorovčák
-- Academic year: 2022/2023
-- License: MIT
-- Topic: Student Information System

-- Description
-- This script creates the database schema for the Student Information System.

-- Drop tables if they exist

DROP TABLE IF EXISTS Course_Schedule;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Program;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Person;

-- Person
CREATE TABLE Person
(
    person_id numeric(8,0) constraint Person_PK primary key
        constraint Person_CHK_ID
      CHECK (person_id > 9999999),
    email VARCHAR(50)
        constraint Person_Email_unique
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
      on delete cascade,
    degree VARCHAR(10),
    phone_number VARCHAR(20),
    website VARCHAR(255),
    office VARCHAR(20),
);

-- Department
CREATE TABLE Department
(
    department_id numeric(8,0)
        constraint Department_PK primary key,
    name VARCHAR(50) NOT NULL,
    head_id numeric(8,0) -- Head Teacher (Dean) of the Department
        constraint Department_FK_Head
      references Teacher(teacher_id)
      on update no action
      on delete set null
);

-- Program
CREATE TABLE Program
(
    program_id numeric(8,0)
        constraint Program_PK primary key,
    name VARCHAR(50) NOT NULL,
    department_id numeric(8,0)
        constraint Program_FK_Department
      references Department(department_id)
      on update no action
      on delete set null,
    duration_years numeric(1,0) not null
        constraint Program_CHK_Duration
      check (duration_years>=1 and duration_years<=5)
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
      on delete cascade,
    program_id numeric(8,0)
        constraint Student_FK_Program
      references Program(program_id)
      on update no action
      on delete set null,
    study_year numeric(1,0) not null
        constraint Student_CHK_StudyYear
      check (study_year>0),
    admission_date DATE NOT NULL,
    graduation_date DATE,
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
      check (credits>0),
    language VARCHAR(20),
    description VARCHAR(255),
    semester numeric(1,0) not null -- 0 is Winter Semester, 1 is Summer Semester
        constraint Course_CHK_Semester
      check (semester>=0 and semester<=1),
    year_taught numeric(1,0) not null
        constraint Course_CHK_YearTaught
      check (year_taught>0),
    garant_id numeric(8,0) -- Only one garant per course
        constraint Course_FK_Garant
      references Teacher(teacher_id)
      on update no action
      on delete cascade,
);

-- Enrollments (many-to-many relationship between Student and Course)
create table Enrollment
(
    student_id numeric(8,0)
        constraint Enrollment_FK_Student
      references Student(student_id)
      on update no action
      on delete cascade,
    course_id numeric(8,0)
        constraint Enrollment_FK_Course
      references Course(course_id)
      on update no action
      on delete no action,
    enrollment_date DATE NOT NULL,
    grade numeric(1,0)
        constraint Enrollment_CHK_Grade
      check (grade>=1 and grade<=3),
    primary key (student_id, course_id)
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
    location VARCHAR(50),
    primary key (course_id, start_time, end_time)
);