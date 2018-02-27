select * from dba_synonyms;

select * from user_synonyms;

create or replace synonym nvsz for nikovits.szeret;

select * from nvsz;

create view nevek as select * from nvsz;

select * from nevek;

