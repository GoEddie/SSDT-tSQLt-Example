CREATE PROCEDURE [HumanResourcesTests].[test uspUpdateEmployeeHireInfo_currentflag_is_set_to_true_when_hired]
AS
	
	declare @BusinessEntityID [int] = 1980; 
    declare @JobTitle [nvarchar](50) = 'employee numero uno';
    declare @HireDate [datetime] = '2014-01-01 10:10:59.59'
    declare @RateChangeDate [datetime] = '2014-07-01'
    declare @Rate [money] = 24.87
    declare @PayFrequency [tinyint] = 7
    declare @CurrentFlag [tinyint] = 1
	 
	exec tSQLt.FakeTable 'Employee', 'HumanResources'
	insert into [$(AdventureWorksExample)].[HumanResources].[Employee]([BusinessEntityID], [CurrentFlag])
	select @BusinessEntityID, 0



	exec [$(AdventureWorksExample)].[HumanResources].[uspUpdateEmployeeHireInfo] @BusinessEntityID, @JobTitle, @HireDate, @RateChangeDate, @Rate, @PayFrequency, @CurrentFlag

	declare @actual_CurrentFlag tinyint
	select @actual_CurrentFlag = CurrentFlag from [$(AdventureWorksExample)].HumanResources.Employee

	if @actual_CurrentFlag <> @CurrentFlag
	begin
		
		declare @error_message varchar(max) = 'Expected CurrentFlag: ' + cast(@CurrentFlag as varchar(4)) + ' but got: ' + cast(@actual_CurrentFlag as varchar(4))

		exec tSQLt.Fail @error_message
	end



	