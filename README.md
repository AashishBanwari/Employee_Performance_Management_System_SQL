# Employee Performance Management System

#### An end-to-end SQL Solution for managing Employee Performance Data. This Project Features comprehensive Stored Procedures for seamless Data Handling and Proactive Triggers for instant Alerts, demonstrating my expertise in creating robust and efficient SQL-based systems.

## Overview

The Employee Performance Management System is designed to streamline the process of managing and analyzing employee performance within an organization. By leveraging advanced SQL techniques, this project offers a robust and scalable solution that can handle various aspects of performance management, from data entry to automated alerts.

## Features

- **Comprehensive Database Schema:** Well-structured tables for storing employee, department, performance review, and goal data.
  
- **Stored Procedures:** Efficient and reusable stored procedures for common operations such as adding performance reviews and updating goal statuses.
  
- **Triggers:** Intelligent triggers to automatically handle specific events, such as sending alerts for low performance scores.
  
- **Sample Data:** Includes sample data for departments, employees, performance reviews, and goals to demonstrate the functionality.
  
- **Queries:** Predefined queries to extract meaningful insights from the data, such as average performance scores by department and employees with goals in progress.

##  Table of Contents

- [Database Schema](Database-Schema)
- [Stored Procedures](Stored-Procedures)
- [Triggers](Triggers)
- [Sample Data](Sample-Data)
- [Queries](Queries)

## Database Schema

The database schema is designed to capture all relevant information related to employee performance management. 

Key tables include:

- **Departments:** Stores department information.
- **Employees:** Stores employee details and their association with departments.
- **Performance Reviews:** Stores performance review records for employees.
- **Goals:** Tracks the goals set for employees and their status.
- **Alert:** A log for email notification sent by the trigger.

## Stored Procedures

Stored procedures are used to encapsulate common operations, ensuring efficiency and reusability. They help maintain data integrity and simplify complex operations by grouping multiple SQL statements into a single procedure. Key stored procedures in this project include:

### 1.  Add Performance Review:

Adds a new performance review for an employee, capturing essential details such as review date, reviewer, score, and comments. This procedure ensures that performance review records are consistently and accurately inserted into the database.

```sql
create procedure sp_AddPerformanceReview
	@EmployeeID int,
	@ReviewDate date,
	@Reviewer nvarchar(50),
	@Score int,
	@Comments nvarchar(50)
as
begin 
	insert into Employees.PerformanceReviews (EmployeeID, ReviewDate, Reviewer, Score, Comments)
    values (@EmployeeID, @ReviewDate, @Reviewer, @Score, @Comments);
end;
```
```sql
exec sp_AddPerformanceReview 2,'2024-06-05','Jack',2,'Poor performance.' -- test the procedure
```
```sql
select * from Employees.PerformanceReviews -- verify the data
```
### 2. **Update Goal Status:** 

Updates the status of a goal for an employee. This procedure is crucial for tracking the progress of employee goals and ensuring that the status is updated consistently as goals are completed or modified.

```sql
create procedure sp_UpdateGoalStatus
	@GoalID int,
	@Status	nvarchar(20)
as
begin
	update Employees.Goals
	set Status = @status
	where GoalID = @GoalID;
end;
```
```sql
exec sp_UpdateGoalStatus @goalID = 3,@Status = 'Completed' -- test the procedure
```
```sql
select * from Employees.Goals -- verify the data
```

## Triggers

Triggers automate specific actions in response to certain events, ensuring data integrity and proactive management. They help enforce business rules and automate workflows without requiring manual intervention. 

### Low Performance Alert:

Sends an alert if an employee's performance review score is below a certain threshold. This trigger enhances proactive management by immediately notifying relevant stakeholders when an employee's performance is below acceptable levels, allowing for timely interventions.

```sql
create trigger trg_LowPerformanceAlert
on Employees.PerformanceReviews
after insert
as
begin
    declare @EmployeeID int, @ReviewID int, @Score int, @EmailAddress nvarchar(50);

    select @EmployeeID = inserted.EmployeeID, @ReviewID = inserted.ReviewID, @Score = inserted.Score
    from inserted;

    if @Score < 3
    begin
        -- Insert alert into Alerts table
        insert into employees.Alerts (EmployeeID, ReviewID, Score, AlertMessage)
        values (@EmployeeID, @ReviewID, @Score, 'Performance score below threshold. Immediate attention required.');

        -- Get the employee's email address
        select @EmailAddress = ed.Email
        from Employees.Employee_details ed
        where ed.EmployeeID = @EmployeeID;

        -- Send email notification
        exec msdb.dbo.sp_send_dbmail
            @profile_name = 'Aashish_Email',
            @recipients = @EmailAddress,
            @subject = 'Low Performance Alert',
            @body = 'Your performance review score is below the acceptable threshold. Please discuss with your manager immediately.';
    end
end;
```
## Sample Data

Sample data is provided to demonstrate the functionality of the system. his includes sample records for departments, employees, performance reviews, and goals.

## Queries

Predefined queries help extract valuable insights from the data. These queries are designed to provide actionable information to managers and HR personnel, enabling data-driven decision-making. Examples include calculating the average performance score by department and identifying employees with goals in progress.

### 1. **Average Performance Score by Department**

This query calculates the average performance score for each department, providing insights into the overall performance trends within different parts of the organization.

```sql
select 
	d.DepartmentName,
	AVG(p.Score) as AverageScore
from Employees.Departments d
join Employees.Employee_details ed on ed.DepartmentID = d.DepartmentID
join Employees.PerformanceReviews p on p.EmployeeID = ed.EmployeeID
group by d.DepartmentName;
```

### 2. **Employees with Goals in Progress**

This query lists employees who have goals currently in progress, helping managers to track ongoing objectives and support employees in achieving their targets.

```sql
select 
	concat(ed.FirstName,' ',ed.LastName) as Employee_Name, g.GoalDescription, g.status
from Employees.Employee_details ed
join Employees.Goals g on g.EmployeeID = ed.EmployeeID
where g.Status = 'In Progress';
```

### 3. **Retrieving Performance Review for a Specific Employee**

This query retrieves all fields performance reviews for a specific employee based on their employee ID.

```sql
select 
	* 
from employees.PerformanceReviews 
where EmployeeID = 2;
```
