-- Author: Martin Čorovčák
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
(10000008, 'mjohnson@example.com', 'Mike', 'Johnson'),
(10000009, 'lsabina@example.com', 'Linda', 'Sabina'),
(10000010,'sed@icloud.com','Adena','Figueroa'),
(10000011,'diam.at@icloud.edu','Orlando','Collins'),
(10000012,'ut@outlook.net','Reese','Robertson'),
(10000013,'ullamcorper.duis@aol.com','Medge','Cabrera'),
(10000014,'a@aol.edu','Dominique','Matthews'),
(10000015,'quis.pede.suspendisse@icloud.net','Hamilton','Daniel'),
(10000016,'massa@google.com','Cadman','Black'),
(10000017,'in.lobortis@aol.ca','Lani','Heath'),
(10000018,'enim@outlook.org','Adena','Barrett'),
(10000019,'morbi@outlook.ca','Medge','Roberts'),
(10000020,'pede.malesuada.vel@outlook.ca','Simone','Huffman'),
(10000021,'ac@protonmail.edu','Rafael','Frederick'),
(10000022,'gravida.praesent@hotmail.couk','Bruce','Prince'),
(10000023,'lacus.etiam@icloud.net','Beau','Burt'),
(10000024,'semper@google.edu','Eleanor','Carrillo'),
(10000025,'lacus.etiam@outlook.org','Wayne','Townsend'),
(10000026,'dolor.donec.fringilla@icloud.edu','Andrew','Wood'),
(10000027,'massa.mauris.vestibulum@google.edu','Violet','Becker'),
(10000028,'nascetur.ridiculus@aol.edu','Octavius','Holland'),
(10000029,'aenean.gravida@google.org','Zeph','Simon'),
(10000030,'non.sapien@hotmail.ca','Adena','Vega'),
(10000031,'mi.felis@hotmail.net','Gabriel','Jenkins'),
(10000032,'sodales.elit@aol.com','Ciaran','Vance'),
(10000033,'ut.lacus@google.com','Hayley','Bradford'),
(10000034,'vestibulum.ante@google.net','Galvin','Hebert'),
(10000035,'tristique.pellentesque@google.couk','Damon','Dillard'),
(10000036,'tellus.imperdiet.non@hotmail.net','Charity','Owens'),
(10000037,'velit@protonmail.couk','Luke','Reyes'),
(10000038,'a.dui@aol.ca','Oliver','Baird'),
(10000039,'torquent.per.conubia@outlook.ca','Bryar','Gutierrez'),
(10000040,'amet.lorem@yahoo.com','Beau','Conner'),
(10000041,'ac.metus@yahoo.couk','Dexter','Ferguson'),
(10000042,'ipsum@google.com','Cooper','Wilkerson'),
(10000043,'est.mauris@aol.org','Melinda','Camacho'),
(10000044,'mauris.molestie@icloud.ca','Molly','Lancaster'),
(10000045,'aptent@aol.edu','Stone','Webster'),
(10000046,'dui.quis.accumsan@aol.com','Hedy','Gallegos'),
(10000047,'ut.pharetra@hotmail.edu','Fletcher','Holmes'),
(10000048,'pede.nunc@icloud.com','Summer','Shepherd'),
(10000049,'donec.at.arcu@hotmail.edu','Piper','Winters'),
(10000050,'accumsan.laoreet.ipsum@outlook.couk','Sebastian','Mcdonald'),
(10000051,'sem.eget@outlook.edu','Kaye','Salas'),
(10000052,'rutrum.fusce@google.ca','Callie','Christian'),
(10000053,'a.malesuada@aol.couk','Janna','Swanson'),
(10000054,'donec.elementum.lorem@icloud.edu','Stephanie','Johns'),
(10000055,'venenatis.a@outlook.edu','Barrett','Foreman'),
(10000056,'vehicula.et.rutrum@hotmail.com','Lev','Myers'),
(10000057,'nibh.vulputate@google.edu','Camden','Olson'),
(10000058,'elit.fermentum.risus@icloud.net','Fritz','Oneal'),
(10000059,'id.ante@protonmail.net','Vance','Mendoza');

-- Teacher
INSERT INTO Teacher (teacher_id, degree, phone_number, website, office)
VALUES
(10000001, 'PhD', '555-123-4567', 'www.example.com/jdoe', 'Room 1A'),
(10000002, 'MSc', '555-123-4568', 'www.example.com/mdoe', 'Room 2B'),
(10000005, 'PhD', '555-123-4569', 'www.example.com/lsmith', 'Room 3C'),
(10000006, 'MSc', '555-123-4570', 'www.example.com/jthompson', 'Room 4D'),
(10000009, 'PhD', '555-123-4573', 'www.example.com/dbrown', 'Room 7G'),
(10000010, 'MSc', '555-123-4574', 'www.example.com/jdavis', 'Room 8H'),
(10000011, 'PhD', '555-123-4575', 'www.example.com/jmiller', 'Room 9I'),
(10000012, 'MSc', '555-123-4576', 'www.example.com/smith', 'Room 10J'),
(10000013, 'PhD', '555-123-4577', 'www.example.com/jones', 'Room 11K'),
(10000014, 'MSc', '555-123-4578', 'www.example.com/williams', 'Room 12L'),
(10000015, 'PhD', '555-123-4579', 'www.example.com/brown', 'Room 13M'),
(10000016, 'MSc', '555-123-4580', 'www.example.com/davis', 'Room 14N'),
(10000017, 'PhD', '555-123-4581', 'www.example.com/miller', 'Room 15O'),
(10000018, 'MSc', '555-123-4582', 'www.example.com/wilson', 'Room 16P'),
(10000019, 'PhD', '555-123-4583', 'www.example.com/moore', 'Room 17Q'),
(10000020, 'MSc', '555-123-4584', 'www.example.com/taylor', 'Room 18R'),
(10000021, 'PhD', '555-123-4585', 'www.example.com/anderson', 'Room 19S'),
(10000022, 'MSc', '555-123-4586', 'www.example.com/thomas', 'Room 20T'),
(10000023, 'PhD', '555-123-4587', 'www.example.com/jackson', 'Room 21U'),
(10000024, 'MSc', '555-123-4588', 'www.example.com/white', 'Room 22V'),
(10000025, 'PhD', '555-123-4589', 'www.example.com/harris', 'Room 23W');

-- Program
INSERT INTO Program (program_id, name, duration_years)
VALUES
(1, 'Medicine', 6),
(2, 'Law', 5),
(3, 'History', 3),
(4, 'Biology', 3),
(5, 'Chemistry', 3),
(6, 'Physics', 3),
(7, 'Mathematics', 3),
(8, 'Informatics', 3),
(9, 'Economics', 3),
(10, 'Pharmacy', 5),
(11, 'Education', 3),
(12, 'Physical Education', 3),
(13, 'Sport', 3),
(14, 'Economics', 3),
(15, 'Business Administration', 3);

-- Student schema
-- create table Student
-- (
--     student_id numeric(8,0)
--         constraint Student_PK
--       primary key
--         constraint Student_FK_Person
--       references Person(person_id)
--       on update no action
--       on delete cascade,
--     program_id numeric(8,0)
--         constraint Student_FK_Program
--       references Program(program_id)
--       on update no action
--       on delete set null,
--     study_year numeric(1,0) not null
--         constraint Student_CHK_StudyYear
--       check (study_year>0),
--     admission_date DATE NOT NULL,
--     graduation_date DATE,
--     gpa decimal(4,2)
--         constraint Student_CHK_GPA
--       check (gpa>=1 and gpa<=3),
--     status VARCHAR(20) not null
--         constraint Student_CHK_Status
--       check (status IN ('active', 'graduated', 'suspended', 'expelled')),
--     honor_status VARCHAR(20)
--         constraint Student_CHK_HonorStatus
--       check (honor_status IN ('Honored', 'Good standing', 'Passing'))
-- );
INSERT INTO Student (student_id, program_id, study_year, admission_date, graduation_date, gpa, status, honor_status)
VALUES
(10000003, 1, 1, '2022-09-01', NULL, NULL, 'active', NULL),
(10000004, 2, 1, '2022-09-01', NULL, NULL, 'active', NULL),
(10000007, 3, 1, '2022-09-01', NULL, NULL, 'active', NULL),
(10000008, 4, 1, '2022-09-01', NULL, NULL, 'active', NULL),
(10000026, 7, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000027, 8, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000028, 9, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000029, 10, 2, '2021-09-01', NULL, NULL, 'expelled', NULL),
(10000030, 11, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000031, 12, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000032, 13, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000033, 14, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000034, 15, 2, '2021-09-01', NULL, NULL, 'active', NULL),
(10000035, 1, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000036, 2, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000037, 3, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000038, 4, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000039, 5, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000040, 6, 3, '2020-09-01', NULL, NULL, 'suspended', NULL),
(10000041, 7, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000042, 8, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000043, 9, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000044, 10, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000045, 11, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000046, 12, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000047, 13, 3, '2020-09-01', NULL, NULL, 'expelled', NULL),
(10000048, 14, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000049, 15, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000050, 1, 4, '2019-09-01', NULL, NULL, 'active', NULL),
(10000051, 2, 4, '2019-09-01', NULL, NULL, 'active', NULL),
(10000052, 3, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000053, 4, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000054, 5, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000055, 6, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000056, 7, 3, '2020-09-01', NULL, NULL, 'active', NULL),
(10000057, 8, 3, '2020-09-01', NULL, NULL, 'active', NULL);

INSERT INTO Course (course_id, name, credits, language, description, semester, garant_id, max_capacity)
VALUES
(1, 'Introduction to Programming', 5, 'English', 'Introduction to programming in C#', 0, 10000001, 10),
(2, 'Introduction to Databases', 5, 'English', 'Introduction to databases in SQL', 0, 10000002, 30),
(3, 'Introduction to Web', 5, 'English', 'Introduction to web development in ASP.NET', 1, 10000005, 30),
(4, 'Introduction to Mobile', 5, 'English', 'Introduction to mobile development in Xamarin', 1, 10000006, 30),
(5, 'Molecular Biology', 6, 'English', 'Introduction to molecular biology', 0, 10000009, 30),
(6, 'Genetics', 6, 'English', 'Introduction to genetics', 0, 10000016, 30),
(7, 'Biochemistry', 6, 'English', 'Introduction to biochemistry', 1, 10000017, 30),
(8, 'Microbiology', 6, 'English', 'Introduction to microbiology', 1, 10000018, 30),
(9, 'Introduction to Law', 6, 'English', 'Introduction to law', 0, 10000019, 30),
(10, 'Introduction to Economics', 5, 'English', 'Introduction to economics', 0, 10000010, 30),
(11, 'Introduction to Management', 5, 'English', 'Introduction to management', 1, 10000011, 30),
(12, 'Introduction to Marketing', 5, 'English', 'Introduction to marketing', 1, 10000012, 30),
(13, 'Introduction to Psychology', 5, 'English', 'Introduction to psychology', 0, 10000013, 30),
(14, 'Introduction to Sociology', 3, 'English', 'Introduction to sociology', 0, 10000014, 30),
(15, 'Introduction to Philosophy', 5, 'English', 'Introduction to philosophy', 1, 10000015, 30);

-- Teaches (many-to-many relationship between Teacher and Course) schema
-- create table Teaches
-- (
--     teacher_id numeric(8,0)
--         constraint Teaches_FK_Teacher
--       references Teacher(teacher_id)
--       on update no action
--       on delete no action, -- keep Teaches even if teacher (with certain ID) is deleted (for historical purposes or if teacher comes back)
--     course_id numeric(8,0)
--         constraint Teaches_FK_Course
--       references Course(course_id)
--       on update no action
--       on delete cascade, -- If a course is deleted, the historical data is irrelevant
--     primary key (teacher_id, course_id) -- Teacher can teach one course multiple times
-- );
INSERT INTO Teaches (teacher_id, course_id)
VALUES
(10000001, 1),
(10000002, 2),
(10000005, 3),
(10000006, 4),
(10000009, 5),
(10000016, 6),
(10000017, 7),
(10000018, 8),
(10000019, 9),
(10000010, 10),
(10000011, 11),
(10000012, 12),
(10000013, 13),
(10000014, 14),
(10000015, 15);

-- Enrollment schema
-- create table Enrollment
-- (
--     student_id numeric(8,0)
--         constraint Enrollment_FK_Student
--       references Student(student_id)
--       on update no action
--       on delete set null, -- keep enrollment even if student is deleted (for historical purposes)
--     course_id numeric(8,0)
--         constraint Enrollment_FK_Course
--       references Course(course_id)
--       on update no action
--       on delete no action,
--     enrollment_date DATE NOT NULL,
--     grade numeric(1,0)
--         constraint Enrollment_CHK_Grade
--       check (grade>=1 and grade<=4), -- 1 is A, 2 is B, 3 is C, 4 is F (failed)
--     primary key (student_id, course_id, enrollment_date) -- Enrollment is unique per student, course and date
-- );
INSERT INTO Enrollment (student_id, course_id, enrollment_date, grade)
VALUES
(10000003, 1, '2022-09-01', NULL),
(10000003, 2, '2022-09-01', NULL),
(10000003, 3, '2022-09-01', NULL),
(10000003, 4, '2022-09-01', NULL),
(10000003, 5, '2022-09-01', NULL),
(10000003, 6, '2022-09-01', NULL),
(10000003, 7, '2022-09-01', NULL),
(10000003, 8, '2022-09-01', NULL),
(10000003, 9, '2022-09-01', NULL),
(10000003, 10, '2022-09-01', NULL),
(10000003, 11, '2022-09-01', NULL),
(10000003, 12, '2022-09-01', NULL),
(10000003, 13, '2022-09-01', NULL),
(10000003, 14, '2022-09-01', NULL),
(10000003, 15, '2022-09-01', NULL),
(10000004, 1, '2022-09-01', NULL),
(10000004, 2, '2022-09-01', NULL),
(10000004, 3, '2022-09-01', NULL),
(10000004, 4, '2022-09-01', NULL),
(10000004, 5, '2022-09-01', NULL),
(10000004, 6, '2022-09-01', NULL),
(10000004, 7, '2022-09-01', NULL),
(10000004, 8, '2022-09-01', NULL),
(10000004, 9, '2022-09-01', NULL),
(10000004, 10, '2022-09-01', NULL),
(10000004, 11, '2022-09-01', NULL),
(10000004, 12, '2022-09-01', NULL),
(10000004, 13, '2022-09-01', NULL),
(10000004, 14, '2022-09-01', NULL),
(10000004, 15, '2022-09-01', NULL),
(10000007, 1, '2022-09-01', NULL),
(10000007, 2, '2022-09-01', NULL),
(10000007, 3, '2022-09-01', NULL),
(10000007, 4, '2022-09-01', NULL),
(10000007, 5, '2022-09-01', NULL),
(10000007, 6, '2022-09-01', NULL),
(10000007, 7, '2022-09-01', NULL),
(10000007, 8, '2022-09-01', NULL),
(10000007, 9, '2022-09-01', NULL),
(10000007, 10, '2022-09-01', NULL),
(10000007, 11, '2022-09-01', NULL),
(10000007, 12, '2022-09-01', NULL),
(10000007, 13, '2022-09-01', NULL),
(10000007, 14, '2022-09-01', NULL),
(10000007, 15, '2022-09-01', NULL),
(10000008, 1, '2022-09-01', NULL),
(10000008, 2, '2022-09-01', NULL),
(10000008, 3, '2022-09-01', NULL),
(10000008, 4, '2022-09-01', NULL),
(10000008, 5, '2022-09-01', NULL),
(10000008, 6, '2022-09-01', NULL),
(10000008, 7, '2022-09-01', NULL),
(10000008, 8, '2022-09-01', NULL),
(10000008, 9, '2022-09-01', NULL),
(10000008, 10, '2022-09-01', NULL),
(10000008, 11, '2022-09-01', NULL),
(10000008, 12, '2022-09-01', NULL),
(10000008, 13, '2022-09-01', NULL),
(10000008, 14, '2022-09-01', NULL),
(10000008, 15, '2022-09-01', NULL),
(10000026, 1, '2022-09-01', NULL),
(10000026, 2, '2022-09-01', NULL),
(10000026, 3, '2022-09-01', NULL),
(10000026, 4, '2022-09-01', NULL),
(10000026, 5, '2022-09-01', NULL),
(10000026, 6, '2022-09-01', NULL),
(10000026, 7, '2022-09-01', NULL),
(10000026, 8, '2022-09-01', NULL),
(10000026, 9, '2022-09-01', NULL),
(10000026, 10, '2022-09-01', NULL),
(10000026, 11, '2022-09-01', NULL),
(10000026, 12, '2022-09-01', NULL),
(10000026, 13, '2022-09-01', NULL),
(10000026, 14, '2022-09-01', NULL),
(10000026, 15, '2022-09-01', NULL),
(10000027, 1, '2022-09-01', NULL),
(10000027, 2, '2022-09-01', NULL),
(10000027, 3, '2022-09-01', NULL),
(10000027, 4, '2022-09-01', NULL),
(10000027, 5, '2022-09-01', NULL),
(10000027, 6, '2022-09-01', NULL),
(10000027, 7, '2022-09-01', NULL),
(10000027, 8, '2022-09-01', NULL),
(10000027, 9, '2022-09-01', NULL),
(10000027, 10, '2022-09-01', NULL),
(10000027, 11, '2022-09-01', NULL),
(10000027, 12, '2022-09-01', NULL),
(10000027, 13, '2022-09-01', NULL),
(10000027, 14, '2022-09-01', NULL),
(10000027, 15, '2022-09-01', NULL),
(10000028, 1, '2022-09-01', NULL),
(10000028, 2, '2022-09-01', NULL),
(10000028, 3, '2022-09-01', NULL),
(10000028, 4, '2022-09-01', NULL),
(10000028, 5, '2022-09-01', NULL),
(10000028, 6, '2022-09-01', NULL),
(10000028, 7, '2022-09-01', NULL),
(10000028, 8, '2022-09-01', NULL),
(10000028, 9, '2022-09-01', NULL),
(10000028, 10, '2022-09-01', NULL),
(10000028, 11, '2022-09-01', NULL),
(10000028, 12, '2022-09-01', NULL),
(10000028, 13, '2022-09-01', NULL),
(10000028, 14, '2022-09-01', NULL),
(10000028, 15, '2022-09-01', NULL),
(10000029, 1, '2022-09-01', NULL),
(10000029, 2, '2022-09-01', NULL),
(10000029, 3, '2022-09-01', NULL),
(10000029, 4, '2022-09-01', NULL),
(10000029, 5, '2022-09-01', NULL);

-- Course_Schedule
-- CREATE TABLE Course_Schedule
-- (
--     course_id numeric(8,0)
--         constraint Course_Schedule_FK_Course
--       references Course(course_id)
--       on update no action
--       on delete cascade,
--     start_time TIME NOT NULL,
--     end_time TIME NOT NULL,
--     day_of_week numeric(1,0) NOT NULL -- 0 is Monday, 1 is Tuesday, ..., 6 is Sunday
--         constraint Course_Schedule_CHK_DayOfWeek
--       check (day_of_week>=0 and day_of_week<=6),
--     location VARCHAR(50), -- Location is optional; room number, building, etc.
--     primary key (course_id, start_time, end_time)
-- );
INSERT INTO Course_Schedule (course_id, start_time, end_time, day_of_week, location)
VALUES
(1, '08:00:00', '09:30:00', 0, 'Room 1A'),
(1, '09:00:00', '10:30:00', 2, 'Room 2A'),
(1, '10:00:00', '11:30:00', 4, 'Room 3C'),
(1, '12:00:00', '12:30:00', 6, 'Room 4D'),
(2, '15:00:00', '15:30:00', 0, 'Room 1A'),
(2, '15:00:00', '15:30:00', 2, 'Room 2A'),
(2, '16:00:00', '16:30:00', 4, 'Room 3C'),
(2, '17:00:00', '17:30:00', 6, 'Room 4D'),
(3, '08:00:00', '09:30:00', 1, 'Room 1A'),
(3, '08:00:00', '09:30:00', 3, 'Room 2A'),
(3, '10:00:00', '11:30:00', 5, 'Room 3C'),
(3, '12:00:00', '12:30:00', 0, 'Room 4D'),
(4, '15:00:00', '15:30:00', 1, 'Room 1A'),
(4, '15:00:00', '15:30:00', 3, 'Room 2A'),
(4, '16:00:00', '16:30:00', 5, 'Room 3C'),
(4, '17:00:00', '17:30:00', 0, 'Room 4D'),
(5, '08:00:00', '09:30:00', 2, 'Room 1A'),
(5, '08:00:00', '09:30:00', 4, 'Room 2A'),
(5, '10:00:00', '11:30:00', 6, 'Room 3C'),
(5, '12:00:00', '12:30:00', 1, 'Room 4D'),
(6, '15:00:00', '15:30:00', 2, 'Room 1A'),
(6, '15:00:00', '15:30:00', 4, 'Room 2A'),
(6, '16:00:00', '16:30:00', 6, 'Room 3C'),
(6, '17:00:00', '17:30:00', 1, 'Room 4D'),
(7, '08:00:00', '09:30:00', 3, 'Room 1A'),
(7, '08:00:00', '09:30:00', 5, 'Room 2A'),
(7, '10:00:00', '11:30:00', 0, 'Room 3C'),
(7, '12:00:00', '12:30:00', 2, 'Room 4D'),
(8, '15:00:00', '15:30:00', 3, 'Room 1A'),
(8, '15:00:00', '15:30:00', 5, 'Room 2A'),
(8, '16:00:00', '16:30:00', 0, 'Room 3C'),
(8, '17:00:00', '17:30:00', 2, 'Room 4D'),
(9, '08:00:00', '09:30:00', 4, 'Room 1A'),
(9, '08:00:00', '09:30:00', 6, 'Room 2A'),
(9, '10:00:00', '11:30:00', 1, 'Room 3C'),
(9, '12:00:00', '12:30:00', 3, 'Room 4D'),
(10, '15:00:00', '15:30:00', 4, 'Room 1A'),
(10, '15:00:00', '15:30:00', 6, 'Room 2A'),
(10, '16:00:00', '16:30:00', 1, 'Room 3C'),
(10, '17:00:00', '17:30:00', 3, 'Room 4D'),
(11, '08:00:00', '09:30:00', 5, 'Room 1A'),
(11, '08:00:00', '09:30:00', 0, 'Room 2A'),
(11, '10:00:00', '11:30:00', 2, 'Room 3C'),
(11, '12:00:00', '12:30:00', 4, 'Room 4D'),
(12, '15:00:00', '15:30:00', 5, 'Room 1A'),
(12, '15:00:00', '15:30:00', 0, 'Room 2A'),
(12, '16:00:00', '16:30:00', 2, 'Room 3C'),
(12, '17:00:00', '17:30:00', 4, 'Room 4D'),
(13, '08:00:00', '09:30:00', 6, 'Room 1A'),
(13, '08:00:00', '09:30:00', 1, 'Room 2A'),
(13, '10:00:00', '11:30:00', 3, 'Room 3C'),
(13, '12:00:00', '12:30:00', 5, 'Room 4D'),
(14, '15:00:00', '15:30:00', 6, 'Room 1A'),
(14, '15:00:00', '15:30:00', 1, 'Room 2A'),
(14, '16:00:00', '16:30:00', 3, 'Room 3C'),
(14, '17:00:00', '17:30:00', 5, 'Room 4D'),
(15, '08:00:00', '09:30:00', 0, 'Room 1A'),
(15, '08:00:00', '09:30:00', 2, 'Room 2A'),
(15, '10:00:00', '11:30:00', 4, 'Room 3C'),
(15, '12:00:00', '12:30:00', 6, 'Room 4D');