--Create trigger to send alert for low performance scores

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

