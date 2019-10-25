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
create table sladb.dbo.tbl_ref_sla_season_day_name(day_name_num int not null unique,
												   day_name_desc nvarchar(9) primary key,
												   ndays_sunday int not null,
												   ndays_saturday int not null);

begin transaction
	insert into sladb.dbo.tbl_ref_sla_season_day_name(day_name_num, day_name_desc, ndays_sunday, ndays_saturday)
		values(1, 'Sunday', 0, 6),
			  (2, 'Monday', 6, 5),
			  (3, 'Tuesday', 5, 4),
			  (4, 'Wednesday', 4, 3),
			  (5, 'Thursday', 3, 2),
			  (6, 'Friday', 2, 1),
			  (7, 'Saturday', 1, 0)
commit;