create table EmpInfo (Id int, EmpName varchar(50), salary int)
insert into EmpInfo values(1, 'Shivani', 80000);

EXEC sys.sp_cdc_enable_db
GO


EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'EmpInfo',
@role_name = Null,
@filegroup_name = NULL,  
@supports_net_changes = 0
GO

select * from [cdc].[change_tables]
select * from [cdc].[captured_columns] -- query to check in which column changes are performed. 
select * from [cdc].[dbo_EmpInfo_CT] --- Table that shows the changes that we do in the table thats cdc is enable

insert into dbo.EmpInfo values (2, 'Nilesh', 150000)
insert into dbo.EmpInfo values (3, 'Rohit', 200000)


DELETE FROM dbo.EmpInfo WHERE Id = 2;


