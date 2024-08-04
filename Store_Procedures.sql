-- Stored procedure to add a new performance review

CREATE PROCEDURE sp_AddPerformanceReview
	@EmployeeID	INT,
	@ReviewDate	DATE,
	@Reviewer NVARCHAR(50),
	@Score int,
	@Comments NVARCHAR(50)
AS
BEGIN 
	INSERT INTO Employees.PerformanceReviews (EmployeeID, ReviewDate, Reviewer, Score, Comments)
    VALUES (@EmployeeID, @ReviewDate, @Reviewer, @Score, @Comments);
END;

-- test the procedure
EXEC sp_AddPerformanceReview @EmployeeID=2, @ReviewDate='2024-06-05', @Reviewer='Jack', @Score=2, @Comments='Poor performance.' 

-- verify the data
SELECT * FROM Employees.PerformanceReviews 


-- Stored procedure to update a goal status

CREATE PROCEDURE sp_UpdateGoalStatus
	@GoalID INT,
	@Status	NVARCHAR(20)
AS
BEGIN
	UPDATE Employees.Goals
	SET Status = @status
	WHERE GoalID = @GoalID;
END;

-- test the procedure
EXEC sp_UpdateGoalStatus @goalID = 3,@Status = 'Completed' 

-- verify the data
SELECT * FROM Employees.Goals 
