USE [eBS4_INT_QA2]
GO
/****** Object:  StoredProcedure [UI].[sp_SyncServices]    Script Date: 7/21/2022 3:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   procedure [UI].[sp_SyncServices]
as
begin
select top 1 * from [UI].[SyncService] DQ
where QueueStatus = 1 OR (QueueStatus = 4 AND IsRequeued = 1) 
AND Not exists (select 1 FRom [UI].[SyncService] DS where DQ.TenantId = DS.TenantId and DS.QueueStatus = 2)
order by QueueId
end

select * from [UI].[SyncService]
