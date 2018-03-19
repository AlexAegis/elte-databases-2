CREATE OR REPLACE PROCEDURE ellenoriz(p_str VARCHAR2, p_user VARCHAR2 := USER) IS
  prog_nev varchar2(100); prog_tipus varchar2(20);
  v_eredm1 varchar2(200); v_eredm2 varchar2(200); v_status integer := 0;
  v_user varchar2(30);
BEGIN
  prog_nev :=upper(substr(p_str,1,instr(p_str,'(')-1));
  BEGIN
    select user into v_user from dual;
    IF v_user='NIKOVITS' THEN v_user := p_user; END IF;
    select object_type into prog_tipus from all_objects where owner='NIKOVITS'
    and object_name = prog_nev and object_type in ('FUNCTION', 'PROCEDURE');
  EXCEPTION WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE ('Program name: '||prog_nev||' ---> I cannot check it.');
    return;
  END;
  IF prog_tipus = 'FUNCTION' THEN 
    EXECUTE IMMEDIATE 'select '||v_user||'.'||p_str||' from dual' INTO v_eredm1;
    EXECUTE IMMEDIATE 'select '||'NIKOVITS'||'.'||p_str||' from dual' INTO v_eredm2;
  ELSIF prog_tipus = 'PROCEDURE' THEN 
    EXECUTE IMMEDIATE 'begin '||v_user||'.'||p_str||'; end;';
    DBMS_OUTPUT.GET_LINE (v_eredm1, v_status);
    EXECUTE IMMEDIATE 'begin '||'NIKOVITS'||'.'||p_str||'; end;';
    DBMS_OUTPUT.GET_LINE (v_eredm2, v_status);
  END IF;
  IF upper(v_eredm1) = upper(v_eredm2) THEN
    DBMS_OUTPUT.PUT_LINE(v_user||'.'||prog_nev||' ---> program and output is GOOD.');
  ELSE
    DBMS_OUTPUT.PUT_LINE(v_user||'.'||prog_nev||' ---> output of the program is BAD.');
  END IF;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(v_user||'.'||prog_nev||' ---> calling the program failed.');
  dbms_output.put_line(sqlcode||' -- '||sqlerrm);
END;
/
call ellenoriz('pr_plusz_2(1)', 'hallgato');
-- grant execute on ellenoriz to public;
-- system-ként az alábbi:
-- create public synonym ellenoriz for nikovits.ellenoriz;
