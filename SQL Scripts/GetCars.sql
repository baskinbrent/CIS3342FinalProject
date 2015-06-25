CREATE PROCEDURE [dbo].[GetCars]
	@agencyID int,
	@city varchar(50),
	@state varchar(50)
AS
	SELECT *
	FROM Cars
	WHERE agencyID = @agencyID
	AND city = @city
	AND state = @state
