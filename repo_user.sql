-- (c) Kyle Hailey 2007
-- (c) Marcin Przepiorowski 2010
-- v2.1 Changes: add password and tablespace prompt, add new privileges to sash user on repository
-- v2.2 Changes: add schema owner as a variable, display more information
-- v2.3
-- v2.4
 
 set ver off

-- prompt Are you connected as the SYS user? 
-- accept toto prompt "If you are not the SYS user hit Control-C , else Return : "

accept SASH_USER default sash prompt "Enter user name (schema owner) [or enter to accept username sash] ? " 
accept SASH_PASS default sash prompt "Enter user password ? "
accept SASH_TS default users prompt "Enter SASH user default tablespace [or enter to accept USERS tablespace] ? "
prompt SASH default tablespace is: &SASH_TS

prompt "------------------------------------------------------------------------------------"
prompt Existing &SASH_USER user will be deleted.
accept toto prompt "If you are not sure hit Control-C , else Return : "
prompt "------------------------------------------------------------------------------------"

drop user &SASH_USER cascade;

prompt New &SASH_USER user will be created.

WHENEVER SQLERROR EXIT 
create user &SASH_USER identified by &SASH_PASS default tablespace &SASH_TS;

alter user &SASH_USER quota unlimited on &SASH_TS;

grant connect, resource to &SASH_USER;

grant ANALYZE ANY  to &SASH_USER;
grant CREATE TABLE         to &SASH_USER;
grant ALTER SESSION               to &SASH_USER;
grant CREATE SEQUENCE            to &SASH_USER;
grant CREATE DATABASE LINK      to &SASH_USER;
grant UNLIMITED TABLESPACE     to &SASH_USER;
grant CREATE PUBLIC DATABASE LINK to &SASH_USER;
grant create view to &SASH_USER;
grant create public synonym to &SASH_USER;
grant execute on dbms_lock to &SASH_USER;
grant Create job to  &SASH_USER;
grant manage scheduler to  &SASH_USER;
grant create session to &SASH_USER;				 
grant select on v_$database to &SASH_USER;
grant select on dba_users to &SASH_USER;
grant select on v_$sql to &SASH_USER;
grant select on v_$parameter to &SASH_USER;
grant select on dba_data_files to &SASH_USER;
grant select on v_$instance to &SASH_USER;
grant select on dba_objects to &SASH_USER;
grant select on v_$sql_plan to &SASH_USER;
grant select on DBA_LIBRARIES to &SASH_USER;
grant select on v_$event_name to &SASH_USER;
grant select on v_$sql_plan to &SASH_USER;
grant select on v_$sqltext to &SASH_USER;
grant select on v_$latch to &SASH_USER;
grant select on dba_extents to &SASH_USER;
grant select on v_$sysstat to &SASH_USER;
grant select on v_$system_event to &SASH_USER;
grant select on v_$sysmetric_history to &SASH_USER;
grant select on v_$iostat_function to &SASH_USER;
grant select on v_$sqlstats to &SASH_USER;
grant select on v_$event_histogram to &SASH_USER;
grant select on v_$sys_time_model to &SASH_USER;
grant select on v_$osstat to &SASH_USER;


$if dbms_db_version.ver_le_9 $then
@target_user_view_9i.sql
$else $if dbms_db_version.ver_le_10 $then
@target_user_view_10g.sql
$else $if dbms_db_version.ver_le_10_2 $then
@target_user_view_10.2.0.1.sql
$else $if dbms_db_version.ver_le_11_1 $then
@target_user_view_11g1.sql
$else $if dbms_db_version.ver_le_11_2 $then 
@target_user_view_11g2.sql
$else
@target_user_view_12cPDB.sql
$end
