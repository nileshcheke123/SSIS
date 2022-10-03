USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[ExistDocRuleEventMapIdExpRule]    Script Date: 10/3/2022 3:42:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [sync].[ExistDocRuleEventMapIdExpRule] @DRID int 
AS
IF exists(SELECT * FROM Ui.DocumentRuleEventMap WHERE DocumentRuleId = @DRID )
BEGIN 
 DELETE FROM UI.DocumentRuleEventMap  WHERE   DocumentRuleId = @DRID
END
