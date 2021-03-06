/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management    																						   			          
 Created Date:  10/15/2019																							   
 Modified Date: 02/20/2020																							   
											       																	   
 Project: SLADB	
 																							   
 Tables Used: inserted																						   
 			  sladb.dbo.tbl_ref_unit																								   		
			  																				   
 Description: Create a trigger that sets an SLA and Season to inactive if a unit has its status in AMPS (obj_status)
			  move from active (obj_status = I) to decommissioned (obj_status = D).
																													   												
***********************************************************************************************************************/
use sladb
go

set ansi_nulls on;
go

set quoted_identifier on;
go

create or alter trigger dbo.trg_au_tbl_ref_unit
on sladb.dbo.tbl_ref_unit
after update as

	begin transaction;
		/*Create a CTE from the updated records. Note that updates go into both the inserted (new) and deleted (old)tables, but the new 
		  records are the only ones that matter for this trigger.*/
		with updates as(
		select unit_id, unit_status, unit_withdraw
		from inserted
		/*Filter to include only objects with a unit_status of D = Decommissioned. All other statuses are still considered to be active.*/
		where unit_status = 'D')
	
		/*Merge the updated rows and see if there is an effective SLA and Season for the given unit. If so, set the value of effective to 
		  0 and the effective_end date to the current date.*/
		merge sladb.dbo.tbl_unit_sla_season as tgt using updates as src
			on (tgt.unit_id = src.unit_id)
			when matched and effective = 1 and effective_end_adj is null
								/*If the saturday that follows the unit_withdraw date is less than today then set effective = 0*/
				then update set tgt.effective = case when dbo.fn_getdate(src.unit_withdraw, 0) < cast(getdate() as date) then 0 else 1 end,
						        tgt.effective_end_adj = dbo.fn_getdate(src.unit_withdraw, 0); 
	commit;

	begin transaction;
		/*Insert invalid status records for any change requests that have not been approved and for units that have been
		  decommissioned.*/
		update u
			set u.sla_change_status = 4
			/*Inner join with the change requests bsased on the change_request_id*/
			from (select *
				  from sladb.dbo.tbl_change_request
				  /*Include any change requests that have a status of 1 = Submitted or 2 = Approved and have yet
				    to reach their effective_start_adj date*/
				  where sla_change_status in(1,2) and 
					    effective_start_adj >= cast(getdate() as date)) as u
			/*Inner join with the inserted units that were decommissioned in AMPS*/
			inner join	
				(select unit_id
				 from inserted
				 /*Filter to include only objects with a unit_status of D = Decommissioned. All other statuses are still considered to be active.*/
				 where unit_status = 'D') as s
			on u.unit_id = s.unit_id
	commit;