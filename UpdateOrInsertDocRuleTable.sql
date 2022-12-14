USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[UpdateOrInsertDocRuleTable]    Script Date: 10/3/2022 3:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [sync].[UpdateOrInsertDocRuleTable] @DRID int
AS
DECLARE @DID int
SET @DID = (SELECT tdr.DocumentRuleID FROM Temp.DocRule tdr join ui.DocumentRule udr ON udr.DocumentRuleID = @DRID)
IF(@DID is null)
BEGIN
	SET @DID = 0
END
SELECT @DID AS DocRuleID
