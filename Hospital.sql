CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Patiens
(
 Id INT IDENTITY(1,1) PRIMARY KEY,
 FirstName NVARCHAR(20),
 LastName NVARCHAR(25),
 BirthDate DATE,
 CONSTRAINT CheckDate CHECK (BirthDate <= GETDATE()),
 Email NVARCHAR(225) UNIQUE 
);

CREATE TABLE Departments
(
DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
[Name] NVARCHAR(40)
)

CREATE TABLE Doctors
(
    DoctorId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(25),
    ExperienceYears INT DEFAULT(0),
    CONSTRAINT CHK_Doctors_ExperienceNonNegative CHECK (ExperienceYears >= 0)
)



ALTER TABLE Doctors ADD
DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentId);


CREATE TABLE Appointments
(
Id INT IDENTITY PRIMARY KEY ,
PatientId INT FOREIGN KEY REFERENCES Patiens (Id),
DoctorId INT FOREIGN KEY REFERENCES Doctors (DoctorId),
Result NVARCHAR(100),
[Date] DATETIME2
)

INSERT INTO Departments (Name)
VALUES
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('Dermatology');

INSERT INTO Doctors (FirstName, LastName, ExperienceYears)
VALUES
('John', 'Smith', 10),
('Emily', 'Johnson', 7),
('Michael', 'Brown', 15),
('Sarah', 'Williams', 5),
('David', 'Miller', 12);

INSERT INTO Patiens (FirstName, LastName, BirthDate, Email)
VALUES
('Alice', 'Walker', '1990-04-15', 'alice.walker@example.com'),
('Robert', 'Davis', '1985-09-22', 'robert.davis@example.com'),
('Sophia', 'Taylor', '2000-03-05', 'sophia.taylor@example.com'),
('James', 'Anderson', '1978-11-12', 'james.anderson@example.com'),
('Olivia', 'Moore', '1995-07-30', 'olivia.moore@example.com');

SELECT * FROM Appointments;

CREATE PROCEDURE AddAppoinment 
@PatientId INT
AS 
BEGIN
SELECT 8 FROM Patiens WHERE Id = @PatientId
Join Appointments a
ON p.Id = a.PatientId
JOIN Doctors d
ON a.DoctorId = d.Id
WHERE p.Id = @PatientId
END

EXEC AddAppoinment 1;
EXEC AddAppoinment 2;

CREATE TABLE Derman
(

)