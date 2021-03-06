/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management 																						   			          
 Created Date:  09/06/2019																							   
 Modified Date: 03/02/2020																						   
											       																	   
 Project: SLADB	
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: <Lorem ipsum dolor sit amet, legimus molestiae philosophia ex cum, omnium voluptua evertitur nec ea.     
	       Ut has tota ullamcorper, vis at aeque omnium. Est sint purto at, verear inimicus at has. Ad sed dicat       
	       iudicabit. Has ut eros tation theophrastus, et eam natum vocent detracto, purto impedit appellantur te	   
	       vis. His ad sonet probatus torquatos, ut vim tempor vidisse deleniti.>  									   
																													   												
***********************************************************************************************************************/
--drop table sladb.dbo.tbl_ref_sla_season_definition
create table sladb.dbo.tbl_ref_sla_season_definition(season_date_ref_id int identity(1,1) primary key,
													 season_id int foreign key references sladb.dbo.tbl_sla_season(season_id) on delete cascade,
													 date_ref_fixed bit not null,
													 month_name_desc nvarchar(9) not null foreign key references sladb.dbo.tbl_ref_sla_season_month_name(month_name_desc),
													 date_ref_day_number int null,
													 day_name_desc nvarchar(9) null foreign key references sladb.dbo.tbl_ref_sla_season_day_name(day_name_desc),
													 day_rank_id nvarchar(5) null foreign key references sladb.dbo.tbl_ref_sla_season_day_rank(day_rank_id),
													 date_type_id int foreign key references sladb.dbo.tbl_ref_sla_season_date_type(date_type_id),
													 constraint ck_month_maxdays check (date_ref_day_number between 1 and dbo.fn_month_maxdays(month_name_desc)));