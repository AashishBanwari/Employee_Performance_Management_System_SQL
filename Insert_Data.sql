 --Insert data into Departments

INSERT INTO Employees.Departments (DepartmentID, DepartmentName)
VALUES 
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales');

 --Insert data into Employees

INSERT INTO Employees.Employee_details (EmployeeID, FirstName, LastName, DepartmentID, HireDate, JobTitle, Email)
VALUES 
(1, 'John', 'Doe', 1, '2020-01-15', 'HR Manager','John.Doe@abccompany.com'),
(2, 'Jane', 'Smith', 2, '2019-03-22', 'Financial Analyst','Jane.Smith@abccompany.com'),
(3, 'Bob', 'Brown', 3, '2018-07-30', 'Software Engineer','Bob.Brown@abccompany.com'),
(4, 'Alice', 'Johnson', 4, '2021-11-01', 'Sales Executive','Alice.Johnson@abccompany.com');

 --Insert data into PerformanceReviews

INSERT INTO Employees.PerformanceReviews (EmployeeID, ReviewDate, Reviewer, Score, Comments)
VALUES 
(1, '2023-06-15', 'CEO', 4, 'Good performance, needs to improve leadership skills.'),
(2, '2023-06-15', 'CFO', 5, 'Outstanding performance, excellent analytical skills.'),
(3, '2023-06-15', 'CTO', 3, 'Average performance, needs to work on meeting deadlines.'),
(4, '2023-06-15', 'CMO', 4, 'Good performance, great sales skills.');

 --Insert data into Goals

INSERT INTO Employees.Goals (GoalID, EmployeeID, GoalDescription, StartDate, EndDate, Status)
VALUES 
(1, 1, 'Improve team leadership skills', '2023-01-01', '2023-12-31', 'In Progress'),
(2, 2, 'Complete advanced financial analysis training', '2023-01-01', '2023-06-30', 'Completed'),
(3, 3, 'Deliver the new software module', '2023-01-01', '2023-09-30', 'In Progress'),
(4, 4, 'Achieve quarterly sales targets', '2023-01-01', '2023-12-31', 'In Progress');
