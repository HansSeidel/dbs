/*************************************************************
Developer: Lucian-Valentin Caraba
status: Abgeschlossen
************************************************************/
create view show_ranking as
	select vr.name as vereinname, ma.name as mannschaftname, ma.altersgruppe
	from verein vr join mannschaft ma on vr.vereinid = ma.vereinid
	order by lower(vereinname), lower(mannschaftname);
	
select * from show_ranking;

drop view show_ranking;
