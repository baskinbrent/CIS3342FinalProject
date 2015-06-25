CREATE PROCEDURE [dbo].[FindCars]
	@city varchar(50),
	@state varchar(50),
	@gps varchar(50),
	@type varchar(50),
	@carClass varchar(50),
	@electric varchar(50),
	@passengers int,
	@luggage int,
	@doors int,
	@mileage int
AS
	SELECT *
	FROM Cars
	WHERE city = @city
	AND state = @state
	AND gps LIKE '%' + @gps + '%'
	AND type LIKE '%' + @type + '%'
	AND class LIKE '%' + @carClass + '%'
	AND electric LIKE '%' + @electric + '%'
	AND passengers >= @passengers
	AND luggage >= @luggage
	AND doors >= @doors
	AND mileage <= @mileage