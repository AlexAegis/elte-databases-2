--A rendszerkatalógus maga is egy adatbázisnak tekinthetõ, amit lekérdezve egyre többet
--tudhatunk meg az ORACLE adatbázisban tárolt dolgokról és azok tulajdonságairól.
--Elnevezésük: DBA_..., ALL_..., USER_...

--Adatbázis objektumok
--------------------
--(DBA_OBJECTS)

--Kinek a tulajdonában van a DBA_TABLES nevû nézet (illetve a DUAL nevû tábla)?
select * from dba_objects where object_name='DBA_TABLES' and object_type='VIEW';
select * from dba_objects where object_name='DUAL' and object_type='VIEW';
--Kinek a tulajdonában van a DBA_TABLES nevû szinonima (illetve a DUAL nevû)?
select * from dba_objects where object_name='DBA_TABLES' and object_type='SYNONYM';
select * from dba_objects where object_name='DUAL' and object_type='SYNONYM';
--(Az iménti két lekérdezés megmagyarázza, hogy miért tudjuk elérni õket.)

--Milyen típusú objektumai vannak az orauser nevû felhasználónak az adatbázisban?
select distinct object_type from dba_objects where owner = 'ORAUSER';

--Hány különbözõ típusú objektum van nyilvántartva az adatbázisban?
select count(distinct object_type) from dba_objects;

--Melyek ezek a típusok?
select distinct object_type from dba_objects;

--Kik azok a felhasználók, akiknek több mint 10 féle objektumuk van?
select owner, count(distinct object_type) 
from dba_objects group by owner 
having count(distinct object_type) > 10 
order by owner;

--Kik azok a felhasználók, akiknek van triggere és nézete is?
select owner from dba_objects where object_type = 'VIEW'
union
select owner from dba_objects where object_type = 'TRIGGER';
-- ! Az union alapesetben végrehajt egy distinctet, ha union all-t használunk akkor nem.

--Kik azok a felhasználók, akiknek van nézete, de nincs triggere?
select owner from dba_objects where object_type = 'VIEW'
minus
select owner from dba_objects where object_type = 'TRIGGER';

--Kik azok a felhasználók, akiknek több mint 40 táblájuk, de maximum 37 indexük van?
select owner from dba_objects where object_type = 'TABLE' group by owner having count(*) > 40
minus
select owner from dba_objects where object_type = 'INDEX' group by owner having count(*) > 37;

--Melyek azok az objektum típusok, amelyek tényleges tárolást igényelnek, vagyis
--tartoznak hozzájuk adatblokkok? (A többinek csak a definíciója tárolódik adatszótárban)


--Melyek azok az objektum típusok, amelyek nem igényelnek tényleges tárolást, vagyis nem
--tartoznak hozzájuk adatblokkok? (Ezeknek csak a definíciója tárolódik adatszótárban)
--Az utóbbi két lekérdezés metszete nem üres. Vajon miért? -> lásd majd partícionálás


--Táblák oszlopai
-----------------
--(DBA_TAB_COLUMNS)

select * from sila.emp;
desc sila.emp;
select * from dba_tab_columns;

select * from user_tab_columns;

--Hány oszlopa van a nikovits.emp táblának?
select count(*) from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits';

--Milyen típusú a nikovits.emp tábla 6. oszlopa?
select data_type, data_precision, data_scale  from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits' and column_id = 2;
select data_type from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits' and column_id = 6;
select data_type, data_precision, data_scale from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits' and column_id = 6;
--Adjuk meg azoknak a tábláknak a tulajdonosát és nevét, amelyeknek van 'Z' betûvel 
--kezdõdõ oszlopa.

--Adjuk meg azoknak a tábláknak a nevét, amelyeknek legalább 8 darab dátum tipusú oszlopa van.

--Adjuk meg azoknak a tábláknak a nevét, amelyeknek 1. es 4. oszlopa is
--VARCHAR2 tipusú.

--Írjunk meg egy plsql procedúrát, amelyik a paraméterül kapott karakterlánc alapján 
--kiírja azoknak a tábláknak a nevét és tulajdonosát, amelyek az adott karakterlánccal 
--kezdõdnek. (Ha a paraméter kisbetûs, akkor is mûködjön a procedúra!)
--     PROCEDURE tabla_kiiro(p_kar VARCHAR2) 
--A fenti procedúra segítségével írjuk ki a Z betûvel kezdõdõ táblák nevét és tulajdonosát.


--HÁZI FELADAT
--------------
--Írjunk meg egy plsql procedúrát, amelyik a paraméterül kapott táblára kiírja 
--az õt létrehozó CTREATE TABLE utasítást. 
--   PROCEDURE cr_tab(p_owner VARCHAR2, p_tabla VARCHAR2) 
--Elég ha az oszlopok típusát és DEFAULT értékeit kíírja, és elég ha a következõ típusú 
--oszlopokra mûködik.
-- CHAR, VARCHAR2, NCHAR, NVARCHAR2, BLOB, CLOB, NCLOB, NUMBER, FLOAT, BINARY_FLOAT, DATE, ROWID

--Teszteljétek a procedúrát az alábbi táblával.
--CREATE TABLE tipus_proba(c10 CHAR(10) DEFAULT 'bubu', vc20 VARCHAR2(20), nc10 NCHAR(10), 
--  nvc15 NVARCHAR2(15), blo BLOB, clo CLOB, nclo NCLOB, num NUMBER, num10_2 NUMBER(10,2), 
--  num10 NUMBER(10) DEFAULT 100, flo FLOAT, bin_flo binary_float DEFAULT '2e+38', 
--  bin_doub binary_double DEFAULT 2e+40,
--  dat DATE DEFAULT TO_DATE('2007.01.01', 'yyyy.mm.dd'), rid ROWID);

