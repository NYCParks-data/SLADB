/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: <Modifier Name>																						   			          
 Created Date:  10/18/2019																							   
 Modified Date: <MM/DD/YYYY>																							   
											       																	   
 Project: SLADB	
 																							   
 Tables Used: sladb.dbo.tbl_unit_sla_season																							   			
			  																				   
 Description: Create a trigger that allows values to be updated and inserted in bulk if an existing season is replaced
			  by a new season. This will prevent the user to have to update the season records 1 by 1.
																													   												
***********************************************************************************************************************/
use sladb
go 
--create trigger dbo.trg_season_change
alter trigger dbo.trg_season_change
on sladb.dbo.tbl_sla_season_change
after insert as

	begin transaction;
		declare @inserts table(unit_id nvarchar(30), 
							   sla_code int, 
							   old_season_id int,
							   new_season_id int,
							   effective bit,
							   effective_from date);

		declare @updates table(sla_season_id int);

		insert into @inserts(unit_id, sla_code, old_season_id, new_season_id, effective, effective_from)
			select r.unit_id,
				   r.sla_code,
				   l.old_season_id,
				   l.new_season_id,
				   1 as effective,
				   sladb.dbo.fn_getdate(cast(getdate() as date), 1) as effective_from
			from inserted as l
			left join
				 sladb.dbo.tbl_unit_sla_season as r
			on l.old_season_id = r.season_id
			where r.effective = 1 and 
				  r.effective_to is null;
		
		/*Account for existing records for a unit that need to be updated*/
		insert into @updates(sla_season_id)
			select r.sla_season_id
			from @inserts as l
			left join
				 sladb.dbo.tbl_unit_sla_season as r
			on l.old_season_id = r.season_id
			where (r.effective = 1 and r.effective_to is null)

		/*Update if required*/
		update sladb.dbo.tbl_unit_sla_season
			set effective = 0,
				effective_to = sladb.dbo.fn_getdate(cast(getdate() as date), 0)
			from @updates as u
			where sladb.dbo.tbl_unit_sla_season.sla_season_id = u.sla_season_id;
	
		/*Insert new records.*/
		insert into sladb.dbo.tbl_unit_sla_season(unit_id, 
												  sla_code, 
												  season_id,
												  effective,
												  effective_from)
			select unit_id, sla_code, new_season_id, 1 as effective, effective_from
			from @inserts
									
	commit;