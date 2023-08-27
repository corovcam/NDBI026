-- Author: Martin Čorovčák
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
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Person;

-- Person
CREATE TABLE Person
(
    person_id numeric(8,0) constraint Person_PK primary key
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
      on delete cascade,
    degree VARCHAR(10),
    phone_number VARCHAR(20),
    website VARCHAR(255),
    office VARCHAR(20),
);

-- Faculty
CREATE TABLE Faculty
(
    faculty_id numeric(8,0)
        constraint Faculty_PK primary key,
    name VARCHAR(50) NOT NULL,
    head_id numeric(8,0) -- Head Teacher (Dean) of the Faculty
        constraint Faculty_FK_Head
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
    faculty_id numeric(8,0)
        constraint Program_FK_Faculty
      references Faculty(faculty_id)
      on update no action
      on delete set null,
    duration_years numeric(1,0) not null
        constraint Program_CHK_Duration
      check (duration_years>=1 and duration_years<=6)
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
    faculty_id numeric(8,0)
        constraint Course_FK_Faculty
      references Faculty(faculty_id)
      on update no action
      on delete cascade, -- If faculty is deleted, all courses are deleted
    semester numeric(1,0) not null -- 0 is Winter Semester, 1 is Summer Semester
        constraint Course_CHK_Semester
      check (semester>=0 and semester<=1),
    garant_id numeric(8,0) -- One and only one garant per course
        constraint Course_FK_Garant
      references Teacher(teacher_id)
      on update no action
      on delete cascade, -- If teacher is deleted, all courses are deleted
    max_capacity numeric(3,0) not null
        constraint Course_CHK_MaxCapacity
      check (max_capacity>0)
);

-- Enrollments (many-to-many relationship between Student and Course)
create table Enrollment
(
    student_id numeric(8,0)
        constraint Enrollment_FK_Student
      references Student(student_id)
      on update no action
      on delete no action, -- keep enrollment even if student is deleted (for historical purposes)
    course_id numeric(8,0)
        constraint Enrollment_FK_Course
      references Course(course_id)
      on update no action
      on delete no action,
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