USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[DropDependency]    Script Date: 10/3/2022 3:46:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [sync].[DropDependency] (@schemaName nvarchar(150), @TableName nvarchar(150))

AS
BEGIN
Declare @Name nvarchar(max)
Declare @object_id int
Declare @schema_id int
Declare @SQL nvarchar(max)

set @schema_id = (select schema_id from sys.schemas where name = @schemaName)

set @object_id = (select object_id from sys.tables where name = @TableName)

set @Name = (select name from sys.foreign_keys where schema_id = @schema_id and object_id = @object_id )

set @SQL = ('ALTER TABLE' + @schemaName+'.'+@TableName + 'drop constraint'+ @Name )
exec sp_executesql @SQL


END