USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [dbo].[SP_ToRemoveKeyConstraint]    Script Date: 9/21/2022 6:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER    proc [dbo].[SP_ToRemoveKeyConstraint]
as
Begin
-- FormID =4464

ALTER TABLE [UI].[DataSource]
DROP CONSTRAINT FK_DataSource_FormDesign

--FormID = 2471
ALTER TABLE [ws].[ServiceDefinition]
DROP CONSTRAINT FK_UIElementID_ServiceDefinition_UIElement

ALTER TABLE [ws].[ServiceDesignVersion]
DROP CONSTRAINT FK_FormDesignVersionID_ServiceVersion_FormDesignVersion

ALTER TABLE [ws].[ServiceDesignVersion]
DROP CONSTRAINT FK_FormDesignID_ServiceVersion_FormDesign


--FormID = 2405
ALTER TABLE [UI].[TargetRepeaterKeyFilter]
DROP CONSTRAINT FK_TargetRepeaterKeyFilter_PropertyRuleMap

ALTER TABLE [Accn].[FormDesignAccountPropertyMap]
DROP CONSTRAINT [FK_FormDesignAccountPropertyMap_FormDesignVersion]


ALTER TABLE UI.TargetRepeaterResultKeyFilter
DROP CONSTRAINT [FK_TargetRepeaterResultKeyFilter_Rule]


ALTER TABLE Accn.FormDesignAccountPropertyMap
DROP CONSTRAINT [FK_FormDesignAccountPropertyMap_FormDesign],[FK_FormDesignAccountPropertyMap_Tenant]

ALTER TABLE [UI].[TargetRepeaterKeyFilter]
DROP CONSTRAINT FK_TargetRepeaterKeyFilter_Rule

alter table [Fldr].[Folder] drop constraint [FK__Folder__FolderMo__6ABE038A] , [FK__Folder__FormDesi__15DA3E5D],[FK__Folder__ParentFo__16CE6296]
,[FK_Folder_Tenant],[FK_Folder_User]

alter table [UI].[FormDesignGroupMapping] drop constraint FK_FormDesignGroupMapping_FormDesignGroup , [FK_FormDesignGroupMapping_FormDesignGroupMapping]

ALTER TABLE [Fldr].[Folder]
DROP CONSTRAINT FK__Folder__FormDesi__15DA3E5D

ALTER TABLE [UI].[FormDesignGroupMapping]
DROP CONSTRAINT FK_FormDesignGroupMapping_FormDesignGroup

End 

