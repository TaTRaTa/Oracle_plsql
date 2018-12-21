-- by default I am going to use HR schema
-- but for all new procedures, functions and packages, I am going to use new schema BL

-- new schema and grants

create user BL identified by BL;
grant connect to BL;
grant all privileges to BL;
alter profile default limit PASSWORD_LIFE_TIME UNLIMITED;

grant SELECT_CATALOG_ROLE to BL;   
grant EXECUTE_CATALOG_ROLE to BL;
grant select on dba_tablespaces to BL;

-- grants to HR	

grant select on dba_tablespaces to HR;
grant EXECUTE on bl.alter_tablespace to HR;
grant EXECUTE on bl.Grant_dml_priv to HR;

