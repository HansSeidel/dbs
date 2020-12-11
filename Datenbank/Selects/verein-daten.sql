/*************************************************************
Developer: Lucian-Valentin Caraba
status: in Arbeit
************************************************************/



select vr.vereinid, vr.name, an.plz, an.strasse, an.hausnummer, /*count(ms.mannschaftid) as mannschaftenanzahl,*/ count(ma.personid) as mitarbeiteranzahl
from verein vr join anschrift an on vr.anschriftid = an.anschriftid
							 --join mannschaft ms on vr.vereinid = ms.vereinid
							 join mitarbeiter ma on vr.vereinid = ma.vereinid						 
group by vr.vereinid, vr.name, an.plz, an.strasse, an.hausnummer;

select mannschaftid, count(personid) as spieleranzahl 
from mannschaft join spieler using(mannschaftid)
group by mannschaftid;
