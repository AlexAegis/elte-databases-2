-- ULLMAN

create database link aramis using 'aramis.inf.elte.hu:1521/eszakigrid97';

select * from nikovits.vilag_orszagai;

select * from nikovits.folyok@aramis;

create or replace synonym rivers for nikovits.folyok@aramis;
create or replace synonym countries for nikovits.vilag_orszagai;

select * from rivers;
select * from countries;
select * from dba_data_files@aramis order by file_id;
select sum(bytes / 1024 / 1024) as megabytes from dba_data_files@aramis order by file_id;
select file_name, bytes / 1024 / 1024 as megabytes from dba_data_files@aramis order by file_id;

select * from dba_temp_files@ullman;
select * from dba_temp_files@aramis;

select * from dba_segments@aramis;
select * from dba_segments@ullman;

select * from user_segments@aramis;
select * from user_segments@ullman;

select * from dba_extents@aramis;
select * from dba_extents@ullman;

select * from user_extents@aramis;
select * from user_extents@ullman;

select * from dba_free_space;

select rowid, rownum, emp.* from sila.emp@aramis;