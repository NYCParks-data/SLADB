/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: <Modifier Name>																						   			          
 Created Date:  09/12/2019																							   
 Modified Date: <MM/DD/YYYY>																							   
											       																	   
 Project: <Project Name>	
 																							   
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
--drop view dbo.vw_season_dates_adjusted
create view dbo.vw_season_dates_adjusted as
	select l.ref_date,
		   sladb.dbo.fn_getdate(l.ref_date, 0) as saturday_ref_date,
		   sladb.dbo.fn_getdate(l.ref_date, 1)  as sunday_ref_date,
		   l.month_name_desc,
		   l.day_name_desc,
		   datepart(day, ref_date) as date_ref_day_number,
		   l.day_rank_id,
		   year(ref_date) as ref_year
	from sladb.dbo.tbl_ref_calendar as l
	left join
		 sladb.dbo.tbl_ref_sla_season_day_name as r
	on l.day_name_desc = r.day_name_desc;
