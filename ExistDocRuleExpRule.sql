USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[ExistDoctRuleIdExpRule]    Script Date: 10/3/2022 3:43:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [sync].[ExistDoctRuleIdExpRule] @DRID int ,@FDID int
AS
IF exists(SELECT * FROM Ui.DocumentRule WHERE DocumentRuleID = @DRID and FormDesignID  = @FDID)
BEGIN 
 DELETE FROM Ui.DocumentRule WHERE DocumentRuleID = @DRID and FormDesignID  = @FDID
END

