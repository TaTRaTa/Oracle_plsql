----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE 
/*
===========================================================================
create by TIvanov
create on 15.11.2018
schema BL

@params:
p_schema string DEFAULT '%' 
p_table_name string DEFAULT '%' 
p_user VARCHAR2 DEFAULT USER

example:
-- with HR schema run scripts below
set serveroutput on
begin
bl.grant_dml_priv(p_user => USER);
end;

===========================================================================
*/
BL.Grant_dml_priv(p_schema string DEFAULT '%', p_table_name string DEFAULT '%', p_user VARCHAR2 DEFAULT USER)
IS
  str VARCHAR2(10000);
BEGIN
 IF p_schema = '%' and p_table_name = '%' then 
   for i in (select 'grant select, insert, update, delete on '||owner||'.'||object_name||' to '||p_user as stmt
              from dba_objects 
              where (owner in ('HR','BL','BBP') and owner <> p_user) and object_type in ('TABLE', 'VIEW'))
    loop
      execute immediate i.stmt;
      DBMS_OUTPUT.PUT_LINE(i.stmt);
    end loop;
 ELSIF p_schema <> '%' and p_table_name <> '%' then 
  for i in (select 'grant select, insert, update, delete on '||owner||'.'||object_name||' to '||p_user as stmt
              from dba_objects 
              where owner = p_schema and object_type in ('TABLE', 'VIEW') and object_name = p_table_name)
    loop
      execute immediate i.stmt;
      DBMS_OUTPUT.PUT_LINE(i.stmt);
    end loop;
    
  ELSE  
   DBMS_OUTPUT.PUT_LINE('Invalid parameters :'||p_schema||', '||p_table_name||', '||p_user);
 END IF;
 
 str := null;
 END;
/