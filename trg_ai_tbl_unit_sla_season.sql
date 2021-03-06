/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management																						   			          
 Created Date:  01/29/2020																							   
 Modified Date: 03/03/2020																							   
											       																	   
 Project: SLADB	
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: <Lorem ipsum dolor sit amet, legimus molestiae philosophia ex cum, omnium voluptua evertitur nec ea.     
	       Ut has tota ullamcorper, vis at aeque omnium. Est sint purto at, verear inimicus at has. Ad sed dicat       
	       iudicabit. Has ut eros tation theophrastus, et eam natum vocent detracto, purto impedit appellantur te	   
	       vis. His ad sonet probatus torquatos, ut vim tempor vidisse deleniti.>  									   
																													   												
***********************************************************************************************************************/
use sladb
go

set ansi_nulls on;
go

set quoted_identifier on;
go

create or alter trigger dbo.trg_ai_tbl_unit_sla_season
on sladb.dbo.tbl_unit_sla_season
after insert as
	begin
		/*Since the new record already would have been inserted by the insert on the tbl_change_request status table, find existing 
		  effective record for that unit and set the effective value to 0 and the effective_date to today.*/
		begin transaction;
			;with change_requests as(
			select u.change_request_id,
				   s.effective_start_adj
			/*Join the inserted records with the tbl_unit_sla_season based on the unit_id to get all records associated
			  with the inserted unit(s).*/
			from sladb.dbo.tbl_unit_sla_season as u
			inner join
				  inserted as s
			on u.unit_id = s.unit_id
			/*Join this results set with the view that determines whether or not that unit contains more than one record
			  with a value of effective = 1 based on unit_id and sla_season_id*/
			inner join
				  sladb.dbo.vw_unit_sla_season_last_id as s1
			on u.unit_id = s1.unit_id and
			   u.sla_season_id = s1.sla_season_id
			/*Keep records only if the rank of the row for the unit is equal to the count of the total number of effective = 1 rows for 
			  that unit and the count of the total number of effective = 1 rows is greater than 1. These are the records where the effective
			  value should be changed to equal 0.*/
			where s1.row_rank = s1.n and
				  s1.n > 1)

			update sladb.dbo.tbl_unit_sla_season
			/*Set the value of effective = 0 and the effective_end date equal to the effective_start of the new sla. The effective_start_adj
			- 1 should always be a Saturday and less than today, but add logic to make sure when setting the value of effective.*/
			set effective = case when dateadd(day, -1, s.effective_start_adj) < cast(getdate() as date) then 0 else 1 end,
				effective_end_adj = dateadd(day, -1, s.effective_start_adj)
			from sladb.dbo.tbl_unit_sla_season as u
			inner join
				  change_requests as s
			on u.change_request_id = s.change_request_id
		commit;

	end;