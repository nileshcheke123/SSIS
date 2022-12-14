USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [sync].[UpdateSchemaUpdateTrackerTable]    Script Date: 10/3/2022 3:45:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Name 
	[Sync].[UpdateSchemaUpdateTrackerTable]

Purpose
	To insert an entry if record not exist, if record exist then update it by replacing Old JsonHash with new JsonHash

Return

Params
	@FDID INT, @FDVID INT

History
	 On 2022-08-02 SP Created By Rohit Agalave

*/

ALTER PROCEDURE [sync].[UpdateSchemaUpdateTrackerTable] @FDID INT, @FDVID INT
AS
BEGIN
	DECLARE @SID AS INT
	Declare @JsonHash NVARCHAR(MAX)
	set  @JsonHash = (select dbo.GZip(FormDesignVersionData) from ui.FormDesignVersion where FormDesignVersionID = @FDVID)
	SET @SID = (SELECT schemaupdatetrackerid FROM mdm.SchemaUpdateTracker WHERE FormdesignID = @FDID and FormdesignVersionID = @FDVID)

	IF(@SID is null)
	BEGIN
		INSERT INTO mdm.SchemaUpdateTracker(FormDesignID,FormDesignVersionID,Status,OldJsonHash,CurrentJsonHash,AddedDate) 
		VALUES(@FDID,@FDVID,1,'',@JsonHash,GETDATE())
	END
	ELSE
	BEGIN
		DECLARE @TempCurrentJsonHash AS NVARCHAR(MAX)
		SET @TempCurrentJsonHash = (SELECT CurrentJsonHash FROM mdm.SchemaUpdateTracker WHERE FormdesignID = @FDID and FormdesignVersionID = @FDVID)
		UPDATE MDM.SchemaUpdateTracker
		SET Status = 3, OldJsonHash = @TempCurrentJsonHash, CurrentJsonHash = @JsonHash,UpdatedDate = GETDATE() WHERE FormdesignID = @FDID and FormdesignVersionID = @FDVID
	END
END