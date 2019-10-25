/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management   																						   			          
 Created Date:  09/06/2019																							   
 Modified Date: 10/24/2019																							   
											       																	   
 Project: SLADB
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: <Lorem ipsum dolor sit amet, legimus molestiae philosophia ex cum, omnium voluptua evertitur nec ea.     
	       Ut has tota ullamcorper, vis at aeque omnium. Est sint purto at, verear inimicus at has. Ad sed dicat       
	       iudicabit. Has ut eros tation theophrastus, et eam natum vocent detracto, purto impedit appellantur te	   
	       vis. His ad sonet probatus torquatos, ut vim tempor vidisse deleniti.>  									   
																													   												
***********************************************************************************************************************/
--drop table sladb.dbo.tbl_sla_season_date;

create table sladb.dbo.tbl_sla_season_date(season_date_id int identity(1,1) primary key,
										   season_id int foreign key references sladb.dbo.tbl_sla_season(season_id) on delete cascade,
										   effective_from date not null,
										   effective_from_adj date not null,
										   effective_to date not null,
										   effective_to_adj date not null,
										   date_category_id int foreign key references sladb.dbo.tbl_ref_sla_season_category(date_category_id));