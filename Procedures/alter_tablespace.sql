create or replace Procedure 
/*
===========================================================================
created by TIvanov
create on 15.11.2018
schema BL

@params:
  p_tablespace
  p_mode default 'READ WRITE'
  
Example:
  set SERVEROUTPUT ON
  begin 
    bl.alter_tablespace('DEV_ODI_TEMP', 'READ WRITE'); 
  end;
===========================================================================
*/

   alter_tablespace(p_tablespace varchar2, p_mode varchar2 default 'READ WRITE')
IS
  v_str varchar2(1000);
  v_curr_mode varchar2(1000);
BEGIN
  select decode(a.status,'ONLINE','READ WRITE',a.status)
    into v_curr_mode
    from dba_tablespaces a
   where a.tablespace_name=p_tablespace
  ;
  if (v_curr_mode!=p_mode) then
    v_str:='alter tablespace '||p_tablespace||' '||p_mode;
    dbms_output.put_line(v_str||';');
    execute immediate v_str;
  else
    dbms_output.put_line('Already in the mode '||p_mode);
  end if;
  EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line(''||TO_CHAR(SQLCODE)||' '||SQLERRM);
    RAISE_APPLICATION_ERROR (-20004,'alter_tablespace: '||TO_CHAR(SQLCODE)||' '||SQLERRM);
END;