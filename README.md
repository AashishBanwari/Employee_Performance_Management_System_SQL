# Employee Performance Management System

#### An end-to-end SQL Solution for managing Employee Performance Data. This Project Features comprehensive Stored Procedures for seamless Data Handling and Proactive Triggers for instant email notifications, demonstrating my expertise in creating Robust and Efficient SQL-Based Systems.

## Overview

The Employee Performance Management System is designed to streamline the process of managing and analyzing employee performance within an organization. By leveraging advanced SQL techniques, this project offers a robust and scalable solution that can handle various aspects of performance management, from data entry to automated alert.

## Features

- **Comprehensive Database Schema:** Well-structured tables for storing employee, department, performance review, goal data, and notification logs.
  
- **Stored Procedures:** Efficient and Reusable Stored Procedures for common operations such as adding Performance Reviews and updating Goal Status.
  
- **Triggers:** Intelligent Triggers to Automatically handle specific events, such as sending Alerts/Notifications for low performance scores.
  
- **Sample Data:** Includes sample data for departments, employees, performance reviews, and goals to demonstrate the functionality.
  
- **Queries:** Predefined queries to extract meaningful insights from the data, such as average performance scores by department and employees with goals in progress.

##  Table of Contents

- [Database Schema](Database-Schema)
- [Stored Procedures](Stored-Procedures)
- [Triggers](Triggers)
- [Queries](Queries)
- [Sample Data](Sample-Data)

## Database Schema

The database schema is designed to capture all relevant information related to employee performance management. 

#### **Schema Name:**

Employees

#### **Tables inside Employees:**

- **Departments:** Stores department information.
- **Employee Details:** Stores employee details and their association with departments.
- **Performance Reviews:** Stores performance review records for employees.
- **Goals:** Tracks the goals set for employees and their status.
- **Alert:** A log for email notification sent by the trigger.

## Stored Procedures

Stored procedures are used to encapsulate common operations, ensuring efficiency and reusability. It helps in maintaining data integrity and simplify complex operations by grouping multiple SQL statements into a single procedure. 

Key stored procedures in this project include:

### 1.  Add Performance Review:

Adds a new performance review for an employee, capturing essential details such as review date, reviewer, score, and comments. This procedure ensures that performance review records are consistently and accurately inserted into the database.

```sql
CREATE PROCEDURE sp_AddPerformanceReview
	@EmployeeID INT,
	@ReviewDate DATE,
	@Reviewer NVARCHAR(50),
	@Score INT,
	@Comments NVARCHAR(max)
AS
BEGIN 
	INSERT INTO Employees.PerformanceReviews (EmployeeID, ReviewDate, Reviewer, Score, Comments)
    	VALUES (@EmployeeID, @ReviewDate, @Reviewer, @Score, @Comments);
END;
```
```sql
-- test the procedure
EXEC sp_AddPerformanceReview 2,'2024-06-05','Jack',2,'Poor performance.' 
```
```sql
-- verify the data
SELECT TOP (1) * FROM Employees.PerformanceReviews ORDER BY ReviewID DESC 
```
### 2. **Update Goal Status:** 

Updates the status of a goal for an employee. This procedure is crucial for tracking the progress of employee goals and ensuring that the status is updated consistently as goals are completed or modified.

```sql
CREATE PROCEDURE sp_UpdateGoalStatus
	@GoalID INT,
	@Status	NVARCHAR(20)
AS
BEGIN
	UPDATE Employees.Goals
	SET Status = @status
	WHERE GoalID = @GoalID;
END;
```
```sql
-- test the procedure
EXEC sp_UpdateGoalStatus @goalID = 3,@Status = 'Completed'
```
```sql
-- verify the data
SELECT * FROM Employees.Goals WHERE [GoalID] = 3
```

## Triggers

Triggers automate specific actions in response to certain events, ensuring data integrity and proactive management. They help enforce business rules and automate workflows without requiring manual intervention. 

### Low Performance Alert:

Sends an alert if an employee's performance review score is below a certain threshold. This trigger enhances proactive management by immediately notifying relevant stakeholders when an employee's performance is below acceptable levels, allowing for timely interventions.

```sql
CREATE TRIGGER trg_LowPerformanceAlert
ON Employees.PerformanceReviews
AFTER INSERT
AS
BEGIN
    DECLARE @EmployeeID INT, @ReviewID INT, @Score INT, @EmailAddress NVARCHAR(50);

    SELECT @EmployeeID = INSERTED.EmployeeID, @ReviewID = INSERTED.ReviewID, @Score = INSERTED.Score
    FROM INSERTED;

    IF @Score < 3
    BEGIN
        -- Insert alert into Alerts table
        INSERT INTO employees.Alerts (EmployeeID, ReviewID, Score, AlertMessage)
        VALUES (@EmployeeID, @ReviewID, @Score, 'Performance score below threshold. Immediate attention required.');

        -- Get the employee's email address
        SELECT @EmailAddress = ed.Email
        FROM Employees.Employee_details ed
        WHERE ed.EmployeeID = @EmployeeID;

        -- Send email notification
        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'Test_Gmail',
            @recipients = @EmailAddress,
            @subject = 'Low Performance Alert',
            @body = 'Your performance review score is below the acceptable threshold. Please discuss with your manager immediately.';
    END
END;
```
## Queries

Predefined queries help extract valuable insights from the data. These queries are designed to provide actionable information to the management, enabling data-driven decision-making. Examples include calculating the average performance score by department, identifying employees with goals in progress and retrieving performance review for a specific employee.

### 1. **Average Performance Score by Department**

This query calculates the average performance score for each department, providing insights into the overall performance trends within different parts of the organization.

```sql
SELECT
	d.DepartmentName,
	AVG(p.Score) AS AverageScore
FROM Employees.Departments d
JOIN Employees.Employee_details ed ON ed.DepartmentID = d.DepartmentID
JOIN Employees.PerformanceReviews p ON p.EmployeeID = ed.EmployeeID
GROUP BY d.DepartmentName;
```

### 2. **Employees with Goals in Progress**

This query lists employees who have goals currently in progress, helping managers to track ongoing objectives and support employees in achieving their targets.

```sql
SELECT
	concat(ed.FirstName,' ',ed.LastName) AS Employee_Name,
	g.GoalDescription,
	g.status
FROM Employees.Employee_details ed
JOIN Employees.Goals g ON g.EmployeeID = ed.EmployeeID
WHERE g.Status = 'In Progress';
```

### 3. **Retrieving Performance Review for a Specific Employee**

This query retrieves all fields from performance reviews table for a specific employee based on their employee ID.

```sql
SELECT * 
FROM employees.PerformanceReviews 
WHERE EmployeeID = 2;
```

## Sample Data

Sample data is provided to demonstrate the functionality of the system. This includes sample records for departments, employees, performance reviews, and goals.

