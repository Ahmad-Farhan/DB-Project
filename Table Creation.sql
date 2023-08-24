--CREATE DATABASE FLEX

--DROP DATABASE FLEX


USE Flex;

CREATE TABLE FLEX.DBO.USERS (
	User_Id			INT				IDENTITY NOT NULL,
	First_name		VARCHAR(15),
	Last_name		VARCHAR(15),
	CNIC			VARCHAR(15)		UNIQUE,
	DoB				DATE,
	Gender			VARCHAR,
	Address			VARCHAR(20),
	City			VARCHAR(15),
	Phone			VARCHAR(12)
);

CREATE TABLE FLEX.DBO.USERACCOUNT (
	User_Id			INT				NOT NULL,
	Username		VARCHAR(20),
	RegNo			VARCHAR(8),
	Email			VARCHAR(30)		NOT NULL,
	Password		VARCHAR(16)		NOT NULL,
	Type			VARCHAR
);

CREATE TABLE FLEX.DBO.ADMIN (
	User_Id			INT				NOT NULL,
	Campus_Id		TINYINT,
	JobTitle		VARCHAR(25),
	Salary			NUMERIC(8,0)
);

CREATE TABLE FLEX.DBO.FACULTY (
	User_Id			INT				NOT NULL,
	Dept_Id			TINYINT,
	JobTitle		VARCHAR(25),
	Salary			NUMERIC(8,0)
);

CREATE TABLE FLEX.DBO.STUDENT (
	User_Id			INT				NOT NULL,
	Dept_Id			TINYINT			NOT NULL,
	PSection		VARCHAR(8),
	BatchNo			VARCHAR(12),
	Degree			VARCHAR(7),
	Status			VARCHAR
);

CREATE TABLE FLEX.DBO.CAMPUS ( --
	Campus_Id		TINYINT			IDENTITY NOT NULL,
	Location		VARCHAR(15)		UNIQUE,
	Address			VARCHAR(20),
	Phone			VARCHAR(12)
);

CREATE TABLE FLEX.DBO.DEPARTMENT ( --
	Dept_Id			TINYINT			IDENTITY NOT NULL,
	Campus_Id		TINYINT			NOT NULL,
	Hod				INT,
	Name			VARCHAR(3),
	Phone			VARCHAR(12)
);

CREATE TABLE FLEX.DBO.SEMESTERRECORD (
    Semester	       VARCHAR(12)		NOT NULL,
    Start_Date         DATE,
)

CREATE TABLE FLEX.DBO.COURSE (
	Course_Id		SMALLINT		IDENTITY NOT NULL,
	Course_Code		VARCHAR(6)		UNIQUE,
	Name			VARCHAR(50),
	CrdHrs			TINYINT
);

CREATE TABLE FLEX.DBO.SECTION (
	Section_Id		INT				IDENTITY NOT NULL,
	Course_Id		INT				NOT NULL,
	Instructor_Id	INT,
	Name			VARCHAR(8),
);

CREATE TABLE FLEX.DBO.OFFEREDCOURSE (
	OfferCourse_Id	INT				IDENTITY NOT NULL,
	Dept_Id			TINYINT			NOT NULL,
	Course_Id		SMALLINT		NOT NULL,
	Coordinator_Id 	INT,
	OfferedIn		VARCHAR(12)
);

CREATE TABLE FLEX.DBO.EVALUATION (
	Eval_Id			INT				IDENTITY NOT NULL,
	Course_Id		INT,
	Name			VARCHAR(15),
	Weightage		TINYINT,
	Range			TINYINT
);

CREATE TABLE FLEX.DBO.MARKS (
	Marks_Id			INT				IDENTITY NOT NULL,
	Student_Id			INT				NOT NULL,
	Eval_Id				INT,
	Obtained			DECIMAL(5,2),
	AbsoluteScored		DECIMAL(4,2)
)

CREATE TABLE FLEX.DBO.CLASS (
	Class_Id		INT				IDENTITY NOT NULL,
	Section_Id		INT				NOT NULL,
	LectureNo		TINYINT,
	Duration		TINYINT,
	Date			DATE
);

CREATE TABLE FLEX.DBO.AUDITTRAIL (
	Audit_Id		INT				IDENTITY NOT NULL,
	User_Id			INT				NOT NULL,
	Activity		VARCHAR(50),
	Instance		TIMESTAMP
);

CREATE TABLE FLEX.DBO.ATTENDENCE (
	Attend_Id		INT				IDENTITY NOT NULL,
	Class_Id		INT,
	Student_Id		INT,
	Status			CHAR
);

CREATE TABLE FLEX.DBO.TRANSCRIPT (
	Transcript_Id	INT				IDENTITY NOT NULL,
	Student_Id		INT,
	Section_Id		INT,
	Grade			VARCHAR(2)		DEFAULT 'I',
	Percentage		Float
);

CREATE TABLE FLEX.DBO.PREREQ (
	CoursePreReq_Id	SMALLINT		IDENTITY NOT NULL,
	Course_Id		SMALLINT,
	PreReq_Id		SMALLINT
);

CREATE TABLE FLEX.DBO.REGISTERATION (
	Reg_Id			INT				IDENTITY NOT NULL,
	Student_Id		INT,
	Course_Id		INT,
	Semester		VARCHAR(12)
);

CREATE TABLE FLEX.DBO.FEEDBACK (
	Feedback_Id		INT				IDENTITY NOT NULL,
	Instructor_Id	INT,
	Student_Id		INT,
	Section_Id		INT,
	Semester		VARCHAR(12),
	FDate			DATE,
	RoomNo			VARCHAR(4),
	Schedule		VARCHAR(10),
	Eval1			TINYINT,
	Eval2			TINYINT,
	Eval3			TINYINT,
	Eval4			TINYINT,
	Eval5			TINYINT,
	Comment			VARCHAR(50)
);

CREATE TABLE AUDITLOG (
	Audit_Id		INT			IDENTITY NOT NULL,
	Event			VARCHAR(30),
	ETime			DATE		GetDate()
);


CREATE TRIGGER UserAdded
ON USERS
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('User Created', GETDATE());
END

CREATE TRIGGER AdminAdded
ON ADMIN
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Admin Added', GETDATE());
END

CREATE TRIGGER FacultyAdded
ON FACULTY
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Faculty Added', GETDATE());
END

CREATE TRIGGER StudentAdded
ON STUDENT
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Student Added', GETDATE());
END

CREATE TRIGGER RegisteredAdded
ON REGISTERATION
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Registeration Added', GETDATE());
END

CREATE TRIGGER RegisteredRemoved
ON REGISTERATION
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Registeration Removed', GETDATE());
END

CREATE TRIGGER SectionAdded
ON SECTION
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Section Added', GETDATE());
END

CREATE TRIGGER ClassAdded
ON CLASS
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Class Added', GETDATE());
END

CREATE TRIGGER CourseOffered
ON OFFEREDCOURSE
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Course Offered', GETDATE());
END

CREATE TRIGGER EvaluationAdded
ON EVALUATION
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Evaluation Added', GETDATE());
END

CREATE TRIGGER MarksUploaded
ON MARKS
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Marks Uploaded', GETDATE());
END

CREATE TRIGGER AttendenceMarked
ON ATTENDENCE
AFTER INSERT AS 
BEGIN
	INSERT INTO AUDITLOG VALUES ('Attendence Marked', GETDATE());
END


BULK INSERT FLEX.DBO.COURSE
FROM 'C:\Users\devil\Documents\SQL Server Management Studio\Project\Course.csv'
WITH ( FIRSTROW = 2, FORMAT = 'csv')

BULK INSERT FLEX.DBO.CAMPUS
FROM 'C:\Users\devil\Documents\SQL Server Management Studio\Project\Campus.csv'
WITH ( FIRSTROW = 2, FORMAT = 'csv')

BULK INSERT FLEX.DBO.PREREQ
FROM 'C:\Users\devil\Documents\SQL Server Management Studio\Project\PreReq.csv'
WITH ( FIRSTROW = 2, FORMAT = 'csv')

INSERT INTO FLEX.DBO.USERS VALUES
('John', 'Doe', '52345-78901-3', '1990-01-01', 'M', '123 Main St', 'New York', '123-456-7890'),
('Jane', 'Doe', '52345-78901-4', '1991-02-02', 'F', '456 Oak St', 'San Francisco', '987-654-3210'),
('David', 'Smith', '52345-78901-5', '1980-03-03', 'M', '789 Elm St', 'Los Angeles', '555-555-1212'),
('Sarah', 'Johnson', '52345-78901-6', '1985-04-04', 'F', '111 Maple St', 'Chicago', '222-222-2323'),
('Michael', 'Brown', '52345-78901-7', '1975-05-05', 'M', '222 Pine St', 'Houston', '333-333-3434'),
('Emily', 'Davis', '52345-78901-8', '1988-06-06', 'F', '333 Cedar St', 'Seattle', '444-444-4545'),
('Daniel', 'Martin', '52345-78901-9', '1982-07-07', 'M', '444 Cherry St', 'Miami', '777-777-7878'),
('Rachel', 'Garcia', '12345-78901-0', '1992-08-08', 'F', '555 Walnut St', 'Dallas', '666-666-6767'),
('Matthew', 'Wilson', '12345-78901-1', '1978-09-09', 'M', '666 Oak Ave', 'Boston', '999-999-9090'),
('Olivia', 'Anderson', '12345-78901-2', '1987-10-10', 'F', '777 Elm Ave', 'Philadelphia', '888-888-8989'),
('Joshua', 'Taylor', '12345-78901-3', '1981-11-11', 'M', '888 Maple Ave', 'Washington DC', '555-555-5656'),
('Isabella', 'Hernandez', '12345-78901-4', '1993-12-12', 'F', '999 Pine Ave', 'San Diego', '444-444-4343'),
('Christopher', 'Moore', '12345-78901-5', '1977-01-13', 'M', '1010 Oak Rd', 'San Francisco', '333-333-3232'),
('Sophia', 'Jackson', '12345-78901-6', '1986-02-14', 'F', '1212 Elm Rd', 'Los Angeles', '222-222-2121'),
('Andrew', 'Lee', '12345-78901-7', '1984-03-15', 'M', '1313 Cedar Rd', 'Chicago', '111-111-1010'),
('Ava', 'Lewis', '12345-78901-8', '1976-04-16', 'F', '1414 Maple Rd', 'Houston', '777-777-7676'),
('Nicholas', 'Walker', '12345-78901-9', '1989-05-17', 'M', '1515 Pine Ln', 'Seattle', '666-666-6565'),
('Bob','Smith','24567-90123-5','1982-03-03','M','789 Oak St.','Chicago','345-678-9012'),
('Sara','Johnson','25678-01234-6','1983-04-04','F','321 Pine St.','Houston','456-789-0123'),
('David','Lee','56789-12345-7','1984-05-05','M','654 Maple St.','Phoenix','567-890-1234'),
('Lisa','Wang','27890-23456-8','1985-06-06','F','987 Cedar St.','Philadelphia','678-901-2345'),
('Mike','Nguyen','28901-34567-9','1986-07-07','M','246 5th St.','San Antonio','789-012-3456'),
('Emily','Kim','29012-45678-0','1987-08-08','F','135 6th St.','San Diego','890-123-4567'),
('Alex','Garcia','20123-56789-1','1988-09-09','M','864 7th St.','Dallas','901-234-5678'),
('Christina','Singh','01234-57890-2','1989-10-10','F','753 8th St.','San Jose','012-345-6789'),
('Joshua','Chen','72345-78901-3','1990-11-11','M','642 9th St.','Austin','123-456-7890'),
('Michelle','Patel','23456-89012-4','1991-12-12','F','531 10th St.','Jacksonville','234-567-8901'),
('Kevin','Lopez','34567-90123-5','1992-01-13','M','420 11th St.','Fort Worth','345-678-9012'),
('Maria','Zhang','45678-01234-6','1993-02-14','F','357 12th St.','Columbus','456-789-0123'),
('Daniel','Ali','56789-02345-7','1994-03-15','M','246 13th St.','San Francisco','567-890-1234'),
('Rachel','Gonzalez','67890-23456-8','1995-04-16','F','135 14th St.','Charlotte','678-901-2345'),
('Jason','Wong','78901-34567-9','1996-05-17','M','864 15th St.','Detroit','789-012-3456'),
('Karen','Kumar','89012-45678-0','1997-06-18','F','753 16th St.','El Paso','890-123-4567'),
('Brian','Ng','90123-56789-1','1998-07-19','M','642 17th St.','Seattle','901-234-5678'),
('Bob', 'Smith', '32345-67890-3', '1995-03-03', 'M', '789 Elm St', 'Chicago', '555-3456'),
('Alice', 'Smith', '42345-67890-4', '1997-04-04', 'F', '012 Maple Ave', 'Houston', '555-4567'),
('Mike', 'Johnson', '52345-67890-5', '2000-05-05', 'M', '345 Cedar St', 'Phoenix', '555-5678'),
('Emily', 'Johnson', '62345-67890-6', '2002-06-06', 'F', '678 Pine Ave', 'Philadelphia', '555-6789'),
('David', 'Williams', '72345-67890-7', '1989-07-07', 'M', '901 Birch Blvd', 'San Antonio', '555-7890'),
('Sarah', 'Williams', '82345-67890-8', '1991-08-08', 'F', '234 Oak St', 'San Diego', '555-8901'),
('James', 'Brown', '92345-67890-9', '1994-09-09', 'M', '567 Maple Dr', 'Dallas', '555-9012'),
('Karen', 'Brown', '02345-67890-0', '1996-10-10', 'F', '890 Cedar Ln', 'San Jose', '555-0123'),
('Tom', 'Garcia', '12346-67891-1', '1988-11-11', 'M', '234 Pine St', 'Austin', '555-1234'),
('Samantha', 'Garcia', '22346-67891-2', '1990-12-12', 'F', '567 Birch Ave', 'Jacksonville', '555-2345'),
('Chris', 'Martinez', '32346-67891-3', '1993-01-13', 'M', '890 Maple Blvd', 'San Francisco', '555-3456'),
('Maria', 'Martinez', '42346-67891-4', '1995-02-14', 'F', '123 Cedar St', 'Columbus', '555-4567'),
('Adam', 'Lee', '52346-67891-5', '1998-03-15', 'M', '456 Oak Ave', 'Indianapolis', '555-5678'),
('Kim', 'Lee', '62346-67891-6', '2000-04-16', 'F', '789 Elm St', 'Seattle', '555-6789'),
('Paul', 'Allen', '72346-67891-7', '1987-05-17', 'M', '012 Maple Ave', 'Denver', '555-7890'),
('Alice', 'Johnson', '32345-6789015-6', '1986-04-04', 'F', '321 Pine St', 'Houston', '456-789-0123'),
('Mike', 'Williams', '32345-6789016-7', '1987-05-05', 'M', '654 Cedar St', 'Phoenix', '567-890-1234'),
('Emily', 'Davis', '32345-6789017-8', '1988-06-06', 'F', '987 Maple St', 'Philadelphia', '678-901-2345'),
('David', 'Wilson', '32345-6789018-9', '1989-07-07', 'M', '654 Birch St', 'San Antonio', '789-012-3456'),
('Sarah', 'Brown', '32345-6789019-0', '1992-08-08', 'F', '321 Walnut St', 'San Diego', '890-123-4567'),
('Chris', 'Miller', '32345-6789020-1', '1993-09-09', 'M', '456 Pine St', 'Dallas', '901-234-5678'),
('Julia', 'Anderson', '32345-6789021-2', '1994-10-10', 'F', '789 Cedar St', 'San Jose', '012-345-6789'),
('Jason', 'Wilson', '32345-6789022-3', '1985-11-11', 'M', '987 Oak St', 'Austin', '123-456-7890'),
('Maria', 'Garcia', '32345-6789023-4', '1986-12-12', 'F', '654 Maple St', 'Fort Worth', '234-567-8901'),
('Robert', 'Lee', '32345-6789024-5', '1987-01-13', 'M', '321 Elm St', 'Columbus', '345-678-9012'),
('Katherine', 'Chen', '32345-6789025-6', '1988-02-14', 'F', '456 Pine St', 'Charlotte', '456-789-0123'),
('Steven', 'Wang', '32345-6789026-7', '1989-03-15', 'M', '789 Cedar St', 'San Francisco', '567-890-1234'),
('Linda', 'Hernandez', '12345-6789027-8', '1990-04-16', 'F', '987 Oak St', 'Seattle', '678-901-2345'),
('Michael', 'Johnson', '12345-6789012-3', '1990-01-01', 'M', '123 Main St', 'New York', '123-456-7890'),
('Jennifer', 'Smith', '12345-6789013-4', '1991-02-02', 'F', '456 Elm St', 'Los Angeles', '234-567-8901'),
('Christopher', 'Davis', '12345-6789014-5', '1985-03-03', 'M', '789 Oak St', 'Chicago', '345-678-9012'),
('Jessica', 'Brown', '12345-6789015-6', '1986-04-04', 'F', '321 Pine St', 'Houston', '456-789-0123'),
('Matthew', 'Wilson', '12345-6789016-7', '1987-05-05', 'M', '654 Cedar St', 'Phoenix', '567-890-1234'),
('Amanda', 'Lee', '12345-6789017-8', '1988-06-06', 'F', '987 Maple St', 'Philadelphia', '678-901-2345'),
('William', 'Garcia', '12345-6789018-9', '1989-07-07', 'M', '654 Birch St', 'San Antonio', '789-012-3456'),
('Emily', 'Taylor', '12345-6789019-0', '1992-08-08', 'F', '321 Walnut St', 'San Diego', '890-123-4567'),
('Daniel', 'Martinez', '12345-6789020-1', '1993-09-09', 'M', '456 Pine St', 'Dallas', '901-234-5678'),
('Melissa', 'Anderson', '12345-6789021-2', '1994-10-10', 'F', '789 Cedar St', 'San Jose', '012-345-6789'),
('Anthony', 'Wilson', '12345-6789022-3', '1985-11-11', 'M', '987 Oak St', 'Austin', '123-456-7890'),
('Stephanie', 'Hernandez', '12345-6789023-4', '1986-12-12', 'F', '654 Maple St', 'Fort Worth', '234-567-8901'),
('David', 'Jackson', '12345-6789024-5', '1987-01-13', 'M', '321 Elm St', 'Columbus', '345-678-9012'),
('Ashley', 'Lee', '12345-6789025-6', '1988-02-14', 'F', '456 Pine St', 'Charlotte', '456-789-0123'),
('Christopher', 'Perez', '12345-6789026-7', '1989-03-15', 'M', '789 Cedar St', 'San Francisco', '567-890-1234'),
('A', 'B', '1111111111111', '2000-01-30', 'M', 'Address', 'Islamabad', '555 11122444'),
('C', 'D', '2222222222222', '2000-01-30', 'F', 'Address', 'Islamabad', '555 11122444'),
('E', 'F', '3333333333333', '2000-01-30', 'M', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '4444444444444', '2000-01-30', 'F', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '5555555555555', '2000-01-30', 'M', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '6666666666666', '2000-01-30', 'F', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '7777777777777', '2000-01-30', 'M', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '8888888888888', '2000-01-30', 'F', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '9999999999999', '2000-01-30', 'M', 'Address', 'Islamabad', '555 11122444'),
('G', 'H', '0000000000000', '2000-01-30', 'F', 'Address', 'Islamabad', '555 11122444');

INSERT INTO FLEX.DBO.USERACCOUNT VALUES
(1, 'john.doe', NULL,'121@nu.edu', '1234', 'A'),
(2, 'jane.doe', NULL,'123@nu.edu', '1234', 'F'),
(3, 'david.smith', NULL,'132@nu.edu', '1234', 'F'),
(4, 'sarah.johnson', NULL,'321@nu.edu', '1234', 'F'),
(5, 'michael.brown', NULL,'121@nu.edu', '1234', 'F'),
(6, 'emily.davis', NULL,'121@nu.edu', '1234', 'F'),
(7, 'daniel.martin', NULL,'121@nu.edu', '1234', 'F'),
(8, 'rachel.garcia', NULL,'121@nu.edu', '1234', 'F'),
(9, NULL, '21I-1111','121@nu.edu', '1234', 'S'),
(10, NULL, '21I-0000','121@nu.edu', '1234', 'S'),
(11, NULL, '21I-0001','121@nu.edu', '1234', 'S'),
(12, NULL, '21I-0002','121@nu.edu', '1234', 'S'),
(13, NULL, '21I-0003','121@nu.edu', '1234', 'S'),
(14, NULL, '21I-0004','121@nu.edu', '1234', 'S'),
(15, NULL, '21I-0005','121@nu.edu', '1234', 'S'),
(16, NULL, '21I-0006','121@nu.edu', '1234', 'S'),
(17, NULL, '21I-0007','121@nu.edu', '1234', 'S'),
(18, NULL, '21I-0008','121@nu.edu', '1234', 'S'),
(19, NULL, '21I-0009','121@nu.edu', '1234', 'S'),
(20, NULL, '21I-0010','121@nu.edu', '1234', 'S'),
(21, NULL, '21I-0011','121@nu.edu', '1234', 'S'),
(22, NULL, '21I-0012','121@nu.edu', '1234', 'S'),
(23, NULL, '21I-0013','121@nu.edu', '1234', 'S'),
(24, NULL, '21I-0014','121@nu.edu', '1234', 'S'),
(25, NULL, '21I-0015','121@nu.edu', '1234', 'S'),
(26, NULL, '21I-0016','121@nu.edu', '1234', 'S'),
(27, NULL, '21I-0017','121@nu.edu', '1234', 'S'),
(28, NULL, '21I-0018','121@nu.edu', '1234', 'S'),
(29, NULL, '21I-0019','121@nu.edu', '1234', 'S'),
(30, NULL, '21I-0020','121@nu.edu', '1234', 'S'),
(31, NULL, '21I-0021','121@nu.edu', '1234', 'S'),
(32, NULL, '21I-0022','121@nu.edu', '1234', 'S'),
(33, NULL, '21I-0023','121@nu.edu', '1234', 'S'),
(34, NULL, '21I-0024','121@nu.edu', '1234', 'S'),
(35, NULL, '21I-0025','121@nu.edu', '1234', 'S'),
(36, NULL, '21I-0026','121@nu.edu', '1234', 'S'),
(37, NULL, '21I-0027','121@nu.edu', '1234', 'S'),
(38, NULL, '21I-0028','121@nu.edu', '1234', 'S'),
(39, NULL, '21I-0029','121@nu.edu', '1234', 'S'),
(40, NULL, '21I-0030','121@nu.edu', '1234', 'S'),
(41, NULL, '21I-0031','121@nu.edu', '1234', 'S'),
(42, NULL, '21I-0032','121@nu.edu', '1234', 'S'),
(43, NULL, '21I-0033','121@nu.edu', '1234', 'S'),
(44, NULL, '21I-0034','121@nu.edu', '1234', 'S'),
(45, NULL, '21I-0035','121@nu.edu', '1234', 'S'),
(46, NULL, '21I-0036','121@nu.edu', '1234', 'S'),
(47, NULL, '21I-0037','121@nu.edu', '1234', 'S'),
(48, NULL, '21I-0038','121@nu.edu', '1234', 'S'),
(49, NULL, '21I-0039','121@nu.edu', '1234', 'S'),
(50, NULL, '21I-0040','121@nu.edu', '1234', 'S'),
(51, NULL, '21I-0041','121@nu.edu', '1234', 'S'),
(52, NULL, '21I-0042','121@nu.edu', '1234', 'S'),
(53, NULL, '21I-0043','121@nu.edu', '1234', 'S'),
(54, NULL, '21I-0044','121@nu.edu', '1234', 'S'),
(55, NULL, '21I-0045','121@nu.edu', '1234', 'S'),
(56, NULL, '21I-0046','121@nu.edu', '1234', 'S'),
(57, NULL, '21I-0047','121@nu.edu', '1234', 'S'),
(58, NULL, '21I-0048','121@nu.edu', '1234', 'S'),
(59, NULL, '21I-0049','121@nu.edu', '1234', 'S'),
(60, NULL, '21I-0050','121@nu.edu', '1234', 'S'),
(61, NULL, '21I-0051','121@nu.edu', '1234', 'S');


INSERT INTO FLEX.DBO.DEPARTMENT
(Campus_Id, HoD, Name, Phone) VALUES
(1, 2, 'CS', '0331 2532238'),
(1, 3, 'AI', '0333 2085187'),
(1, 4, 'DS', '0364 5842318'),
(1, 5, 'CY', '0364 9980923'),
(1, 6, 'SE', '0332 8039767'),
(1, 7, 'EE', '0364 6151868'),
(1, 8, 'BA', '0334 2947488');

INSERT INTO FLEX.DBO.FACULTY VALUES
(2, 1, 'Assitant Professor', 1234),
(3, 1, 'Associate Professor', 1234),
(4, 1, 'Instructor', 1234),
(5, 1, 'Lecturer', 1234),
(6, 1, 'Professor', 1234),
(7, 1, 'Associate Professor', 1234),
(8, 2, 'Professor', 1234);


INSERT INTO FLEX.DBO.STUDENT VALUES
(9, 1, 'BCS-A', 'Fall 2021', 'BSCS', 'A'),
(10, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(11, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(12, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(13, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(14, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(15, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(16, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(17, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(18, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(19, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(20, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(21, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(22, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(23, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(24, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(25, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(26, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(27, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(28, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(29, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(30, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(31, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(32, 1, 'BCS-B','Fall 2021', 'BSCS', 'A'),
(33, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(34, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(35, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(36, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(37, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(38, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(39, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(40, 1, 'BCS-C','Fall 2021', 'BSCS', 'A'),
(41, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(42, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(43, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(44, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(45, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(46, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(47, 1, 'BCS-D','Fall 2021', 'BSCS', 'A'),
(48, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(49, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(50, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(51, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(52, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(53, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(54, 1, 'BCS-E','Fall 2021', 'BSCS', 'A'),
(55, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(56, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(57, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(58, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(59, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(60, 1, 'BCS-A','Fall 2021', 'BSCS', 'A'),
(61, 1, 'BCS-A','Fall 2021', 'BSCS', 'A');

INSERT INTO FLEX.DBO.ADMIN VALUES
(1, 1, 'Academic Officer', 1234);

INSERT INTO SEMESTERRECORD VALUES
('Fall 2022', '2022-6-12'),
('Spring 2023', '2022-12-15');

INSERT INTO OFFEREDCOURSE VALUES
(1, 2, NULL, 'Spring 2023'),
(1, 3, NULL, 'Spring 2023'),
(1, 10, NULL, 'Spring 2023'),
(1, 15, NULL, 'Spring 2023'),
(1, 14, NULL, 'Spring 2023'),
(1, 19, NULL, 'Spring 2023'),
(1, 20, NULL, 'Spring 2023'),
(1, 6, NULL, 'Spring 2023'),
(1, 7, NULL, 'Spring 2023');

INSERT INTO REGISTERATION VALUES
(9, 1, 'Spring 2023'),
(10, 1, 'Spring 2023'),
(11, 1, 'Spring 2023'),
(12, 1, 'Spring 2023'),
(13, 1, 'Spring 2023'),
(14, 1, 'Spring 2023'),
(15, 1, 'Spring 2023'),
(16, 1, 'Spring 2023'),
(17, 1, 'Spring 2023'),
(18, 1, 'Spring 2023'),
(19, 1, 'Spring 2023'),
(20, 1, 'Spring 2023'),
(21, 1, 'Spring 2023'),
(22, 1, 'Spring 2023'),
(23, 1, 'Spring 2023'),
(24, 1, 'Spring 2023'),
(25, 1, 'Spring 2023'),
(26, 1, 'Spring 2023'),
(27, 1, 'Spring 2023'),
(28, 1, 'Spring 2023'),
(29, 1, 'Spring 2023'),
(30, 1, 'Spring 2023'),
(31, 1, 'Spring 2023'),
(32, 1, 'Spring 2023'),
(33, 1, 'Spring 2023'),
(34, 1, 'Spring 2023'),
(35, 1, 'Spring 2023'),
(36, 1, 'Spring 2023'),
(37, 1, 'Spring 2023'),
(38, 1, 'Spring 2023'),
(39, 1, 'Spring 2023'),
(40, 1, 'Spring 2023'),
(41, 1, 'Spring 2023'),
(42, 1, 'Spring 2023'),
(43, 1, 'Spring 2023'),
(44, 1, 'Spring 2023'),
(45, 1, 'Spring 2023'),
(46, 1, 'Spring 2023'),
(47, 1, 'Spring 2023'),
(48, 1, 'Spring 2023'),
(49, 1, 'Spring 2023'),
(50, 1, 'Spring 2023'),
(51, 1, 'Spring 2023'),
(52, 1, 'Spring 2023'),
(53, 1, 'Spring 2023'),
(54, 1, 'Spring 2023'),
(55, 1, 'Spring 2023'),
(56, 1, 'Spring 2023'),
(57, 1, 'Spring 2023'),
(58, 1, 'Spring 2023'),
(59, 1, 'Spring 2023'),
(60, 1, 'Spring 2023'),
(61, 1, 'Spring 2023'),
(9, 2, 'Spring 2023'),
(9, 3, 'Spring 2023'),
(9, 4, 'Spring 2023'),
(9, 5, 'Spring 2023');

/*
INSERT INTO SECTION VALUES
(1, NULL, 'A'),
(2, NULL, 'A'),
(1, NULL, 'B'),
(3, NULL, 'A'),
(4, NULL, 'A'),
(5, NULL, 'A'),
(6, NULL, 'A');

INSERT INTO TRANSCRIPT (Student_Id, Section_Id) VALUES
(9, 1),
(9, 2),
(9, 3),
(9, 4);

INSERT INTO FLEX.DBO.FEEDBACK (Instructor_Id, Student_Id, Section_Id, Semester, FDate, RoomNo, Schedule, Eval1, Eval2, Eval3, Eval4, Eval5, Comment)
VALUES
	(2, 9, 1, 'Spring 2023', '2023-05-11', 'A101', 'Morning', 5, 4, 3, 5, 2, 'Great instructor!'),
	(2, 10, 1, 'Spring 2023', '2023-05-11', 'B203', 'Afternoon', 3, 2, 4, 3, 5, 'Needs improvement in explaining concepts.'),
	(2, 9, 1, 'Spring 2023', '2023-05-11', 'C305', 'Evening', 4, 3, 2, 4, 4, 'Very knowledgeable.'),
	(2, 10, 1, 'Spring 2023', '2023-05-11', 'D409', 'Morning', 5, 5, 5, 5, 5, 'Best instructor ever!'),
	(2, 9, 1, 'Spring 2023', '2023-05-11', 'E511', 'Afternoon', 2, 3, 2, 3, 2, 'Not satisfied with the teaching method.'),
	(2, 9, 1, 'Spring 2023', '2023-05-11', 'A101', 'Morning', 4, 4, 5, 3, 4, 'Engaging and knowledgeable instructor.'),
	(2, 10, 1, 'Spring 2023', '2023-05-11', 'C305', 'Afternoon', 3, 3, 4, 2, 3, 'Needs to provide more examples.'),
	(2, 9, 1, 'Spring 2023', '2023-05-11', 'B203', 'Evening', 5, 5, 5, 5, 5, 'Excellent teaching skills.'),
	(2, 10, 1, 'Spring 2023', '2023-05-11', 'A101', 'Morning', 4, 3, 4, 3, 4, 'Very approachable and helpful instructor.'),
	(2, 9, 1, 'Spring 2023', '2023-05-11', 'D409', 'Afternoon', 2, 2, 3, 2, 2, 'Lacks clarity in explanations.');
*/
ALTER TABLE FLEX.DBO.USERS ADD
	CONSTRAINT U_ID PRIMARY KEY (User_Id);

ALTER TABLE FLEX.DBO.COURSE ADD
	CONSTRAINT CR_ID PRIMARY KEY (Course_Id);

ALTER TABLE FLEX.DBO.CAMPUS ADD
	CONSTRAINT CMP_ID PRIMARY KEY (Campus_Id);

ALTER TABLE FLEX.DBO.USERACCOUNT ADD
	CONSTRAINT UAC_ID PRIMARY KEY (User_Id),
	CONSTRAINT UAC_UID FOREIGN KEY (User_Id) REFERENCES FLEX.DBO.USERS (User_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Chk_RN CHECK (RegNo IS NULL OR RegNo LIKE '__[ILKFP]-____');

ALTER TABLE FLEX.DBO.SEMESTERRECORD ADD
    CONSTRAINT SM_ID PRIMARY KEY (Semester),
    CONSTRAINT SM_UD CHECK (Semester LIKE 'Spring ____' OR 
    Semester LIKE 'Summer ____' OR Semester LIKE 'Fall ____' )

ALTER TABLE FLEX.DBO.ADMIN ADD
	CONSTRAINT UA_ID PRIMARY KEY (User_Id),
	CONSTRAINT UA_UID FOREIGN KEY (User_Id) REFERENCES FLEX.DBO.USERS (User_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UA_C FOREIGN KEY (Campus_Id) REFERENCES FLEX.DBO.CAMPUS (Campus_Id);

ALTER TABLE FLEX.DBO.FACULTY ADD
	CONSTRAINT UF_ID PRIMARY KEY (User_Id),
	CONSTRAINT UF_UID FOREIGN KEY (User_Id) REFERENCES FLEX.DBO.USERS (User_Id)
		ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FLEX.DBO.DEPARTMENT ADD
	CONSTRAINT D_ID PRIMARY KEY (Dept_Id),
	CONSTRAINT D_C FOREIGN KEY (Campus_Id) REFERENCES FLEX.DBO.CAMPUS (Campus_Id) 
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT D_H FOREIGN KEY (HoD) REFERENCES FLEX.DBO.FACULTY (User_Id)
		ON DELETE SET DEFAULT ON UPDATE CASCADE,
	CONSTRAINT D_UQ UNIQUE (Campus_Id, Name);

ALTER TABLE FLEX.DBO.STUDENT ADD
	CONSTRAINT US_ID PRIMARY KEY (User_Id),
	CONSTRAINT US_UID FOREIGN KEY (User_Id) REFERENCES FLEX.DBO.USERS (User_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT US_DID FOREIGN KEY (Dept_Id) REFERENCES FLEX.DBO.DEPARTMENT(Dept_Id)
		ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE FLEX.DBO.OFFEREDCOURSE ADD 
	CONSTRAINT OC_ID PRIMARY KEY (OfferCourse_Id),
	CONSTRAINT OC_DP FOREIGN KEY (Dept_Id) REFERENCES DEPARTMENT (Dept_Id)
		ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT OC_CS FOREIGN KEY (Course_Id) REFERENCES COURSE (Course_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT OC_CO FOREIGN KEY (Coordinator_Id) REFERENCES FACULTY (User_Id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT RG_Sem FOREIGN KEY (OfferedIn) REFERENCES SEMESTERRECORD (Semester),
	CONSTRAINT OC_UQ UNIQUE (Dept_Id, Course_Id, OfferedIn);

ALTER TABLE FLEX.DBO.SECTION ADD
	CONSTRAINT S_ID PRIMARY KEY (Section_Id),
	CONSTRAINT S_CID FOREIGN KEY (Course_Id) REFERENCES FLEX.DBO.OFFEREDCOURSE (OfferCourse_Id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT S_INS FOREIGN KEY (Instructor_Id) REFERENCES FLEX.DBO.FACULTY (User_Id)
		ON DELETE SET DEFAULT ON UPDATE CASCADE,
	CONSTRAINT S_UQ UNIQUE (Course_Id, Name);

ALTER TABLE FLEX.DBO.CLASS ADD
	CONSTRAINT CL_ID PRIMARY KEY (Class_Id),
	CONSTRAINT CL_SC FOREIGN KEY (Section_Id) REFERENCES FLEX.DBO.SECTION (Section_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CL_UQ UNIQUE (Section_Id, LectureNo, Date);

ALTER TABLE FLEX.DBO.EVALUATION ADD
	CONSTRAINT EV_ID PRIMARY KEY (Eval_Id),
	CONSTRAINT EV_SC FOREIGN KEY (Course_Id) REFERENCES FLEX.DBO.OFFEREDCOURSE (OfferCourse_Id)
		ON DELETE SET DEFAULT ON UPDATE NO ACTION,
	CONSTRAINT EV_UQ UNIQUE (Course_Id, Name);

ALTER TABLE FLEX.DBO.MARKS ADD
	CONSTRAINT MK_ID PRIMARY KEY (Marks_Id), 
	CONSTRAINT MK_STD FOREIGN KEY (Student_Id) REFERENCES FLEX.DBO.STUDENT (User_Id),
	CONSTRAINT MK_EV FOREIGN KEY (Eval_Id) REFERENCES FLEX.DBO.EVALUATION (Eval_Id);

ALTER TABLE FLEX.DBO.ATTENDENCE ADD
	CONSTRAINT A_ID PRIMARY KEY (Attend_Id),
	CONSTRAINT A_SID FOREIGN KEY (Student_Id) REFERENCES FLEX.DBO.STUDENT (User_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT A_CID FOREIGN KEY (Class_Id) REFERENCES FLEX.DBO.CLASS (Class_Id)
		ON DELETE SET DEFAULT ON UPDATE NO ACTION,
	CONSTRAINT A_UQ UNIQUE(Class_Id, Student_Id);

ALTER TABLE FLEX.DBO.TRANSCRIPT ADD
	CONSTRAINT PO_ID PRIMARY KEY (Transcript_Id),
	CONSTRAINT PO_SEC FOREIGN KEY (Section_Id) REFERENCES SECTION (Section_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PO_STD FOREIGN KEY (Student_Id) REFERENCES STUDENT (User_Id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT PO_UQ UNIQUE (Section_Id, Student_Id);

ALTER TABLE FLEX.DBO.REGISTERATION ADD
	CONSTRAINT RG_ID PRIMARY KEY (Reg_Id),
	CONSTRAINT RG_STD FOREIGN KEY (Student_Id) REFERENCES STUDENT (User_Id)
		ON DELETE SET DEFAULT ON UPDATE CASCADE,
	CONSTRAINT RG_CRS FOREIGN KEY (Course_Id) REFERENCES OFFEREDCOURSE (OfferCourse_Id)
		ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT RGS_Sem FOREIGN KEY (Semester) REFERENCES SEMESTERRECORD (Semester),
	CONSTRAINT RG_UQ UNIQUE (Student_Id, Course_Id, Semester);

ALTER TABLE FLEX.DBO.PREREQ ADD
	CONSTRAINT PR_ID PRIMARY KEY (CoursePreReq_Id),
	CONSTRAINT PR_CRS FOREIGN KEY (Course_Id) REFERENCES COURSE (Course_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PR_PRQ FOREIGN KEY (PreReq_Id) REFERENCES COURSE (Course_Id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT PR_UQ UNIQUE (Course_Id, PreReq_Id);

ALTER TABLE FLEX.DBO.AUDITTRAIL ADD
	CONSTRAINT AT_ID PRIMARY KEY (Audit_Id),
	CONSTRAINT AT_UR FOREIGN KEY (User_Id) REFERENCES USERACCOUNT (User_Id)
		ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FLEX.DBO.AUDITLOG ADD
	CONSTRAINT AL_ID PRIMARY KEY (Audit_Id);

ALTER TABLE FLEX.DBO.FEEDBACK ADD
	CONSTRAINT FB_ID PRIMARY KEY (Feedback_Id),
	CONSTRAINT FB_INS FOREIGN KEY (Instructor_Id) REFERENCES FACULTY (User_Id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FB_SEC FOREIGN KEY (Section_Id) REFERENCES SECTION(Section_Id)
		ON DELETE SET DEFAULT ON UPDATE NO ACTION,
	CONSTRAINT FB_STD FOREIGN KEY (Student_Id) REFERENCES STUDENT (User_Id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT FB_Sem FOREIGN KEY (Semester) REFERENCES SEMESTERRECORD(Semester),
	CONSTRAINT Chk_EV1 CHECK (Eval1 BETWEEN 1 AND 5),
	CONSTRAINT Chk_EV2 CHECK (Eval2 BETWEEN 1 AND 5),
	CONSTRAINT Chk_EV3 CHECK (Eval3 BETWEEN 1 AND 5),
	CONSTRAINT Chk_EV4 CHECK (Eval4 BETWEEN 1 AND 5),
	CONSTRAINT Chk_EV5 CHECK (Eval5 BETWEEN 1 AND 5);