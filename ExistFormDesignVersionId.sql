USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[ExistFormDesignVersionId]    Script Date: 10/3/2022 3:44:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [sync].[ExistFormDesignVersionId] @FDID int , @FDVID int
AS
IF exists(SELECT * FROM Ui.FormDesignVersion WHERE FormDesignID = @FDID and FormDesignVersionID = @FDVID)
BEGIN 
 DELETE FROM Ui.FormDesignVersion WHERE FormDesignID = @FDID and FormDesignVersionID = @FDVID
END
