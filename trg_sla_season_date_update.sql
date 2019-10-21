/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management    																						   			          
 Created Date:  10/11/2019																							   
 Modified Date: 10/21/2019																							   
											       																	   
 Project: SLADB 	
 																							   
 Tables Used: inserted																						   
 			  sladb.dbo.tbl_change_request																								   		
			  																				   
 Description: Create a trigger to update the ending date of a season if it has its effective value set to 0  									   
																													   												
***********************************************************************************************************************/
use sladb
go
--drop trigger dbo.trg_sla_season_upsert
create trigger dbo.trg_sla_season_date_update
on sladb.dbo.tbl_sla_season
after update as

	begin transaction;
		/*Create a table to hold the updates.*/
		declare @updates table(season_id int,
							   season_date_id int);
		
		/*Insert values into the updates table.*/
		insert into @updates(season_id,
							 season_date_id)
			select l.season_id,
				   r.season_date_id
			from inserted as l
			left join
				 (select season_id,
						 season_date_id,
						 /*Calculate the maximum ending date in the season dates table*/
						 max(date_end) over(partition by season_id order by season_id) as max_date_end,
						 date_end
				  from sladb.dbo.tbl_sla_season_date) as r
			on l.season_id = r.season_id
			/*Filter to include only the rows where the date is equal to the maximum date, since this
			  is the only row that should be updated.*/
			where r.date_end = r.max_date_end;

		update sladb.dbo.tbl_sla_season_date
				/*Set the ending equal to today and the adjusted ending date equal to the next closest Saturday.*/
			set date_end = cast(getdate() as date),
				date_end_adj = sladb.dbo.fn_getdate(cast(getdate() as date), 0)
			from @updates as u
			where sladb.dbo.tbl_sla_season_date.season_date_id = u.season_date_id;

	commit;