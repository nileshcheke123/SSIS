USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [dbo].[Delete_Folders]    Script Date: 9/22/2022 6:12:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =====================================================================
-- Author:		Ashish
-- Create date: 03/01/2016
-- Description:	Delete all folders and its documents with associated accounts

--exec [dbo].[Delete_Folders]
-- ======================================================================
ALTER PROCEDURE [dbo].[Delete_Folders]

As BEGIN

BEGIN
	--BEGIN TRY
		--BEGIN TRANSACTION

		DECLARE @startCnt INT
		DECLARE @totalCnt INT
		DECLARE @tempFolderID INT
		DECLARE @FolderID INT
		DECLARE @ConsortiumID INT
		SELECT @FolderID = FolderID From Fldr.Folder

		IF (@FolderID > 0)
		BEGIN
		
			drop table FolderTableIDs
			SET @startCnt = 1
		--Insert into temp FolderTableIDs tbl For all folder IDs
		
		create table FolderTableIDs(
		FolderID int,
		ID  int identity(1,1)
		);
			
			
			INSERT INTO FolderTableIDs (FolderID) 
			SELECT FolderID  FROM Fldr.Folder 
		

	    SELECT  * FROM FolderTableIDs 
		SELECT  @totalCnt=ID FROM FolderTableIDs 

		UPDATE Fldr.Folder SET ParentFolderId = NULL
		PRINT @totalCnt

		WHILE @startCnt <= @totalCnt
		BEGIN
			SELECT @tempFolderID = FolderID FROM FolderTableIDs WHERE ID=@startCnt
----------------------------------------------------------------------------
--DELETE--
---------------------------------------------------------------------------- 
				PRINT 'Start..'
				PRINT @startCnt
				PRINT @tempFolderID
  								--DELETE WorkFlowStateUserMap
					DELETE FROM Fldr.WorkFlowStateUserMap WHERE FolderVersionID IN (
					SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID)					
								
					--DELETE WorkFlowStateFolderVersionMap
					Delete from Fldr.WorkFlowStateFolderVersionMap where FolderID = @tempFolderID										
					
					
					-- DELETE FolderVersionWorkflowState
					DELETE FROM Fldr.FolderVersionWorkflowState WHERE FolderVersionID IN (
						SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID)			
					

					-- DELETE FormInstanceDataMap
					DELETE FROM Fldr.FormInstanceDataMap WHERE FormInstanceID IN (
						SELECT FormInstanceID FROM Fldr.FormInstance WHERE FolderVersionID IN (
							SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID))
							
					-- DELETE FormInstanceActivitylog
					DELETE FROM Fldr.FormInstanceActivityLog WHERE FormInstanceID IN (
						SELECT FormInstanceID FROM Fldr.FormInstance WHERE FolderVersionID IN (
							SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID))

				  --  DELETE FROM rpt.CustomerCareDocument WHERE FormInstanceID IN (
						--SELECT FormInstanceID FROM Fldr.FormInstance WHERE FolderVersionID IN (
						--	SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID))

					DELETE FROM GU.IASFolderMap WHERE FormInstanceID IN (
						SELECT FormInstanceID FROM Fldr.FormInstance WHERE FolderVersionID IN (
							SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID))
					
					--DELETE Journal Entry
					DELETE FROM Fldr.JournalResponse WHERE JournalID IN
					(SELECT JournalID FROM Fldr.Journal WHERE FolderVersionID IN
					(SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID))
								
					DELETE FROM Fldr.Journal WHERE FolderVersionID IN
				    (SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID)
							
					-- DELETE AccountProductMap
					DELETE FROM Accn.AccountProductMap WHERE FolderID = @tempFolderID
					-- DELETE FormInstance
					DELETE FROM Fldr.FormInstance WHERE FolderVersionID IN (
						SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID)
										
					--DELETE EmailLog	
					DELETE FROM Fldr.EmailLog WHERE FolderVersionID IN (
						SELECT FolderVersionID FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID)
					
					
					
					-- DELETE FolderVersion
					DELETE FROM Fldr.FolderVersion WHERE FolderID = @tempFolderID
					-- DELETE AccountFolderMap	

					--Delete from fldr.Consortium where ConsortiumID in (
					--select ConsortiumID from Fldr.FolderVersion  WHERE FolderID = @tempFolderID
					--)
					
					DELETE FROM Accn.AccountFolderMap WHERE FolderID = @tempFolderID		
					DELETE FROM Fldr.EmailLog WHERE FolderID = @tempFolderID	
					
					--DELETE Folder Lock
					DELETE FROM Sec.FolderLock	where FolderID = @tempFolderID			
															
					-- DELETE Folder
					-- DELETE Self-Referencing Foreign Key Data From Folder Table
					
					DELETE FROM Fldr.Folder WHERE FolderID = @tempFolderID
					           
---------------------------------------------------------------------------
			SET @startCnt=@startCnt + 1
			
		END
	
	DELETE FROM Accn.Account
	DELETE FROM [Fldr].[Consortium]
	

END
--COMMIT TRANSACTION
		
--	END TRY
--	BEGIN CATCH
--		ROLLBACK TRANSACTION
--		SELECT 
--			ERROR_NUMBER() AS ErrorNumber,
--			ERROR_SEVERITY() AS ErrorSeverity,
--			ERROR_STATE() as ErrorState,
--			ERROR_PROCEDURE() as ErrorProcedure,
--			ERROR_LINE() as ErrorLine,
--			ERROR_MESSAGE() as ErrorMessage;    
		
--	END CATCH
END

END


  

