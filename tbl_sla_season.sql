/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management 																						   			          
 Created Date:  09/06/2019																							   
 Modified Date: 02/25/2020																						   
											       																	   
 Project: SLADB	
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: <Lorem ipsum dolor sit amet, legimus molestiae philosophia ex cum, omnium voluptua evertitur nec ea.     
	       Ut has tota ullamcorper, vis at aeque omnium. Est sint purto at, verear inimicus at has. Ad sed dicat       
	       iudicabit. Has ut eros tation theophrastus, et eam natum vocent detracto, purto impedit appellantur te	   
	       vis. His ad sonet probatus torquatos, ut vim tempor vidisse deleniti.>  									   
																													   												
***********************************************************************************************************************/
create table sladb.dbo.tbl_sla_season(season_id int identity(1,1) primary key,
									  season_desc nvarchar(128),
									  year_round bit not null,
									  effective bit not null default 0,
									  effective_start date not null,
									  effective_start_adj as dbo.fn_getdate(effective_start, 1),
									  effective_end date null,
									  effective_end_adj as dbo.fn_getdate(effective_end, 0),
									  created_date_utc datetime default getutcdate(),
									  updated_date_utc datetime,
									  constraint ck_season_effective_dates check (effective_end > effective_start));

