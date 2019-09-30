/****** Script for SelectTopNRows command from SSMS  ******/
begin transaction;

with hist as(
select r.unit_id, 
	   isnull(replace(l.obj_udfchar02, 'NULL', 'N'), 'N') as sla_in,
	   isnull(replace(l.obj_udfchar02, 'NULL', 'N'), 'N') as sla_off,
	   0 as effective,
	   case when unit_commiss >= '2015-07-01' then cast(unit_commiss as date)
		    else '2015-07-01'
	   end as effective_from,
	   cast(coalesce(unit_withdraw, null) as date) as effective_to
from sladb.dbo.sla_export as l
right join
	  sladb.dbo.tbl_ref_unit as r
on l.obj_code = r.unit_id
where r.unit_withdraw >= '2015-07-01' or
	  r.unit_withdraw is null)

insert into sladb.dbo.tbl_unit_sla_season(unit_id, sla_code, season_id, effective, effective_from, effective_to)
	select l.unit_id,
		   r.sla_code,
		   2 as season_id,
		   l.effective,
		   l.effective_from,
		   l.effective_to
	from hist as l
	left join
		 sladb.dbo.tbl_ref_sla_translation as r
	on l.sla_in = r.sla_in and
	   l.sla_off = r.sla_off;
commit