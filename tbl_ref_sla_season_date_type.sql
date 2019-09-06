/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: <Modifier Name>																						   			          
 Created Date:  <MM/DD/YYYY>																							   
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
--drop table sladb.dbo.tbl_ref_sla_season_date_type
create table sladb.dbo.tbl_ref_sla_season_date_type(season_date_type_id int identity(1,1) primary key,
													season_date_category_id int foreign key references sladb.dbo.tbl_ref_sla_season_category(season_category_id),
												    season_date_type_desc nvarchar(30));

insert into sladb.dbo.tbl_ref_sla_season_date_type(season_date_category_id, season_date_type_desc)
	values(1, 'Season Start'),
		  (1, 'Season End'),
		  (2, 'Preseason Start'),
		  (2, 'Preseason End'),
		  (2, 'Postseason Start'),
		  (2, 'Postseason End')


