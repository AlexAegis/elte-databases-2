






-- �sszes objektum, csak a sys l�thatja (aramison a felhaszn�l�k is)
select * from dba_objects;
select count(*) from dba_objects;
-- Ez sz�kebb, a felhaszn�l� is l�tja
select * from all_objects;
select count(*) from all_objects;

-- Saj�t dba objektumaim
select * from dba_objects where owner = 'AQV5AK';
select count(*) from dba_objects where owner = 'AQV5AK';
-- Bel�pett felhaszn�l� objektumai
select * from user_objects order by object_name;
select count(*) from user_objects;

-- P�ld�ul t�bl�t l�trehozva az objektum megjelenik az el�z� query �rt�kk�szlet�ben. "A" = A = a; "a" != a; "a" != " a" 
drop table a;
drop table "a";
drop table A;
drop table "A";
create table a (data varchar2(40));
create table "a" (data varchar2(40));
create table A (data varchar2(40));
create table "A" (data varchar2(40));

insert into a values (1);

-- a t�bla kisbet�vel lett elk�sz�tve de el�rem mindk�t m�don select-el
select * from a;
select * from A;

-- �gy l�trehozva a t�bl�t az dba_objectsben ez az objektum sim�n b-k�nt fog szerepelni
create table "b" ("x" number);

-- Ez a lek�rdez�st m�gsem ad vissza semmit
select * from b;
-- 
select * from "b";

-- K�t objektumnak nem lehet ugyanaz a neve. A dba_objects lek�rdez�sben viszont t�nhet �gy
-- ha pl l�trej�n egy "A" �s egy " A" nev� objektum. A lek�rdez�sben a sz�k�z nem fog l�tsz�dni.



-- Postgres, MySQL, SQLite stb adatb�ziskezel�kben a from z�rad�k nem k�telez�. Oracle-ben ez
-- k�telez�, erre van egy mindenki sz�m�ra el�rhet� egy sor�, egy oszlop� "dual" nevezet� t�bla
select * from dual;
drop table dual;
select 2 + 2 from dual;
create table dual (x number);
select 2 + 2 from dual;
select * from sys.dual;
drop table dual;
create view dual as select * from szeret;
select * from dual;
drop view dual;

-- Ebb�l kider�l, hogy a from z�rad�kba ker�lhet t�bla, n�zet vagy szinon�ma