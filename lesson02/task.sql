--A rendszerkatal�gus maga is egy adatb�zisnak tekinthet�, amit lek�rdezve egyre t�bbet
--tudhatunk meg az ORACLE adatb�zisban t�rolt dolgokr�l �s azok tulajdons�gair�l.
--Elnevez�s�k: DBA_..., ALL_..., USER_...

--Adatb�zis objektumok
--------------------
--(DBA_OBJECTS)

--Kinek a tulajdon�ban van a DBA_TABLES nev� n�zet (illetve a DUAL nev� t�bla)?
select * from dba_objects where object_name='DBA_TABLES' and object_type='VIEW';
select * from dba_objects where object_name='DUAL' and object_type='VIEW';
--Kinek a tulajdon�ban van a DBA_TABLES nev� szinonima (illetve a DUAL nev�)?
select * from dba_objects where object_name='DBA_TABLES' and object_type='SYNONYM';
select * from dba_objects where object_name='DUAL' and object_type='SYNONYM';
--(Az im�nti k�t lek�rdez�s megmagyar�zza, hogy mi�rt tudjuk el�rni �ket.)

--Milyen t�pus� objektumai vannak az orauser nev� felhaszn�l�nak az adatb�zisban?
select distinct object_type from dba_objects where owner = 'ORAUSER';

--H�ny k�l�nb�z� t�pus� objektum van nyilv�ntartva az adatb�zisban?
select count(distinct object_type) from dba_objects;

--Melyek ezek a t�pusok?
select distinct object_type from dba_objects;

--Kik azok a felhaszn�l�k, akiknek t�bb mint 10 f�le objektumuk van?
select owner, count(distinct object_type) 
from dba_objects group by owner 
having count(distinct object_type) > 10 
order by owner;

--Kik azok a felhaszn�l�k, akiknek van triggere �s n�zete is?
select owner from dba_objects where object_type = 'VIEW'
union
select owner from dba_objects where object_type = 'TRIGGER';
-- ! Az union alapesetben v�grehajt egy distinctet, ha union all-t haszn�lunk akkor nem.

--Kik azok a felhaszn�l�k, akiknek van n�zete, de nincs triggere?
select owner from dba_objects where object_type = 'VIEW'
minus
select owner from dba_objects where object_type = 'TRIGGER';

--Kik azok a felhaszn�l�k, akiknek t�bb mint 40 t�bl�juk, de maximum 37 index�k van?
select owner from dba_objects where object_type = 'TABLE' group by owner having count(*) > 40
minus
select owner from dba_objects where object_type = 'INDEX' group by owner having count(*) > 37;

--Melyek azok az objektum t�pusok, amelyek t�nyleges t�rol�st ig�nyelnek, vagyis
--tartoznak hozz�juk adatblokkok? (A t�bbinek csak a defin�ci�ja t�rol�dik adatsz�t�rban)


--Melyek azok az objektum t�pusok, amelyek nem ig�nyelnek t�nyleges t�rol�st, vagyis nem
--tartoznak hozz�juk adatblokkok? (Ezeknek csak a defin�ci�ja t�rol�dik adatsz�t�rban)
--Az ut�bbi k�t lek�rdez�s metszete nem �res. Vajon mi�rt? -> l�sd majd part�cion�l�s


--T�bl�k oszlopai
-----------------
--(DBA_TAB_COLUMNS)

select * from sila.emp;
desc sila.emp;
select * from dba_tab_columns;

select * from user_tab_columns;

--H�ny oszlopa van a nikovits.emp t�bl�nak?
select count(*) from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits';

--Milyen t�pus� a nikovits.emp t�bla 6. oszlopa?
select data_type, data_precision, data_scale  from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits' and column_id = 2;
select data_type from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits' and column_id = 6;
select data_type, data_precision, data_scale from dba_tab_columns where lower(table_name) = 'emp' and lower(owner) = 'nikovits' and column_id = 6;
--Adjuk meg azoknak a t�bl�knak a tulajdonos�t �s nev�t, amelyeknek van 'Z' bet�vel 
--kezd�d� oszlopa.

--Adjuk meg azoknak a t�bl�knak a nev�t, amelyeknek legal�bb 8 darab d�tum tipus� oszlopa van.

--Adjuk meg azoknak a t�bl�knak a nev�t, amelyeknek 1. es 4. oszlopa is
--VARCHAR2 tipus�.

--�rjunk meg egy plsql proced�r�t, amelyik a param�ter�l kapott karakterl�nc alapj�n 
--ki�rja azoknak a t�bl�knak a nev�t �s tulajdonos�t, amelyek az adott karakterl�nccal 
--kezd�dnek. (Ha a param�ter kisbet�s, akkor is m�k�dj�n a proced�ra!)
--     PROCEDURE tabla_kiiro(p_kar VARCHAR2) 
--A fenti proced�ra seg�ts�g�vel �rjuk ki a Z bet�vel kezd�d� t�bl�k nev�t �s tulajdonos�t.


--H�ZI FELADAT
--------------
--�rjunk meg egy plsql proced�r�t, amelyik a param�ter�l kapott t�bl�ra ki�rja 
--az �t l�trehoz� CTREATE TABLE utas�t�st. 
--   PROCEDURE cr_tab(p_owner VARCHAR2, p_tabla VARCHAR2) 
--El�g ha az oszlopok t�pus�t �s DEFAULT �rt�keit k��rja, �s el�g ha a k�vetkez� t�pus� 
--oszlopokra m�k�dik.
-- CHAR, VARCHAR2, NCHAR, NVARCHAR2, BLOB, CLOB, NCLOB, NUMBER, FLOAT, BINARY_FLOAT, DATE, ROWID

--Tesztelj�tek a proced�r�t az al�bbi t�bl�val.
--CREATE TABLE tipus_proba(c10 CHAR(10) DEFAULT 'bubu', vc20 VARCHAR2(20), nc10 NCHAR(10), 
--  nvc15 NVARCHAR2(15), blo BLOB, clo CLOB, nclo NCLOB, num NUMBER, num10_2 NUMBER(10,2), 
--  num10 NUMBER(10) DEFAULT 100, flo FLOAT, bin_flo binary_float DEFAULT '2e+38', 
--  bin_doub binary_double DEFAULT 2e+40,
--  dat DATE DEFAULT TO_DATE('2007.01.01', 'yyyy.mm.dd'), rid ROWID);

