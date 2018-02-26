






-- Összes objektum, csak a sys láthatja (aramison a felhasználók is)
select * from dba_objects;
select count(*) from dba_objects;
-- Ez szûkebb, a felhasználó is látja
select * from all_objects;
select count(*) from all_objects;

-- Saját dba objektumaim
select * from dba_objects where owner = 'AQV5AK';
select count(*) from dba_objects where owner = 'AQV5AK';
-- Belépett felhasználó objektumai
select * from user_objects order by object_name;
select count(*) from user_objects;

-- Például táblát létrehozva az objektum megjelenik az elõzõ query értékkészletében. "A" = A = a; "a" != a; "a" != " a" 
drop table a;
drop table "a";
drop table A;
drop table "A";
create table a (data varchar2(40));
create table "a" (data varchar2(40));
create table A (data varchar2(40));
create table "A" (data varchar2(40));

insert into a values (1);

-- a tábla kisbetûvel lett elkészítve de elérem mindkét módon select-el
select * from a;
select * from A;

-- Így létrehozva a táblát az dba_objectsben ez az objektum simán b-ként fog szerepelni
create table "b" ("x" number);

-- Ez a lekérdezést mégsem ad vissza semmit
select * from b;
-- 
select * from "b";

-- Két objektumnak nem lehet ugyanaz a neve. A dba_objects lekérdezésben viszont tûnhet úgy
-- ha pl létrejön egy "A" és egy " A" nevû objektum. A lekérdezésben a szóköz nem fog látszódni.



-- Postgres, MySQL, SQLite stb adatbáziskezelõkben a from záradék nem kötelezõ. Oracle-ben ez
-- kötelezõ, erre van egy mindenki számára elérhetõ egy sorú, egy oszlopú "dual" nevezetû tábla
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

-- Ebbõl kiderül, hogy a from záradékba kerülhet tábla, nézet vagy szinoníma