

CREATE DATABASE Emp_Performance_sys

USE Emp_Performance_sys

CREATE SCHEMA Employees

CREATE TABLE Employees.Departments
(
	DepartmentID INT PRIMARY KEY,
	DepartmentName NVARCHAR(100) NOT NULL
)

CREATE TABLE Employees.Employee_details
(
	EmployeeID INT PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DepartmentID INT,
	HireDate DATE,
	JobTitle NVARCHAR(100),
  	Email NVARCHAR(50),
	FOREIGN KEY (DepartmentID) REFERENCES Employees.Departments(DepartmentID)
)

CREATE TABLE Employees.PerformanceReviews 
(
	ReviewID INT PRIMARY KEY IDENTITY(1,1),
	EmployeeID INT FOREIGN KEY REFERENCES Employees.Employee_details(EmployeeID) ,
	ReviewDate DATE,
	Reviewer NVARCHAR(50),
	Score INT CHECK (Score BETWEEN 1 AND 5),
	Comments NVARCHAR(MAX)
)

CREATE TABLE Employees.Goals
(
	GoalID INT PRIMARY KEY,
	EmployeeID INT FOREIGN KEY REFERENCES Employees.Employee_details(EmployeeID),
	GoalDescription NVARCHAR(MAX),
	StartDate DATE,
	EndDate DATE,
	Status NVARCHAR(20)
)
	
CREATE TABLE Employees.Alerts (
    AlertID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employees.Employee_details(EmployeeID),
    ReviewID INT FOREIGN KEY REFERENCES Employees.PerformanceReviews(ReviewID),
    Score INT,
    AlertDate DATETIME DEFAULT GETDATE(),
    AlertMessage NVARCHAR(MAX)  
);

