USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[ExistDocRuleEventMapIdDesgVer]    Script Date: 10/3/2022 3:30:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [sync].[ExistDocRuleEventMapIdDesgVer] @FDID int , @FDVID int
AS
IF exists(SELECT * FROM Ui.DocumentRuleEventMap WHERE DocumentRuleId in (SELECT DocumentRuleID FROM UI.DocumentRule WHERE FormDesignID = @FDID and FormDesignVersionID = @FDVID))
BEGIN 
 DELETE FROM Ui.DocumentRuleEventMap WHERE DocumentRuleId in (SELECT DocumentRuleID FROM UI.DocumentRule WHERE FormDesignID = @FDID and FormDesignVersionID = @FDVID)
END
