/***********************************************************************************************************************
																													   	
 Created By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management         											   
 Modified By: Dan Gallagher, daniel.gallagher@parks.nyc.gov, Innovation & Performance Management																						   			          
 Created Date:  10/01/2019																							   
 Modified Date: 01/24/2020																							   
											       																	   
 Project: SLADB	
 																							   
 Tables Used: <Database>.<Schema>.<Table Name1>																							   
 			  <Database>.<Schema>.<Table Name2>																								   
 			  <Database>.<Schema>.<Table Name3>				
			  																				   
 Description: Create a table to track the changes in status of a SLA change request.							   
																													   												
***********************************************************************************************************************/
create table sladb.dbo.tbl_change_request_status(change_request_status_id int identity(1,1) primary key,
												 change_request_id int foreign key references sladb.dbo.tbl_change_request(change_request_id) on delete cascade,
												 sla_change_status int foreign key references sladb.dbo.tbl_ref_sla_change_status(sla_change_status),
												 created_date_utc datetime default getutcdate(),
												 created_user nvarchar(7) not null,
												 constraint unq_change_request_status unique(change_request_id, sla_change_status));
