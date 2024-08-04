--calculating the average performance score by department

SELECT 
	d.DepartmentName,
	AVG(p.Score) AS AverageScore
FROM Employees.Departments d
JOIN Employees.Employee_details ed
ON ed.DepartmentID = d.DepartmentID
JOIN Employees.PerformanceReviews p
ON p.EmployeeID = ed.EmployeeID
GROUP BY d.DepartmentName;

--identifying employees with goals in progress

SELECT 
	CONCAT(ed.FirstName,' ',ed.LastName) AS Employee_Name, 	g.GoalDescription, 
	g.status
FROM Employees.Employee_details ed
JOIN Employees.Goals g
ON g.EmployeeID = ed.EmployeeID
WHERE g.Status = 'In Progress';

--retrieving performance reviews for a specific employee

SELECT  * 
FROM employees.PerformanceReviews 
WHERE EmployeeID = 2;

