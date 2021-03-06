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
begin transaction
	insert into sladb.dbo.tbl_ref_sla(sla_id, sla_desc, sla_min_days, sla_max_days)
		values('T', 'Test SLA', null, null),
			  ('D', 'Test adding a D SLA', 1, 1)
commit;

select * from sladb.dbo.tbl_ref_sla
select * from sladb.dbo.tbl_ref_sla_code
select * from sladb.dbo.tbl_ref_sla_translation
select * from sladb.dbo.vw_sla_code_pivot order by sla_code
select distinct in_season_sla, off_season_sla from sladb.dbo.vw_sla_code_pivot order by sla_code