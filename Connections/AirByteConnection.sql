-- set variables (these need to be uppercase)
set airbyte_role = 'AIRBYTE_ROLE';
set airbyte_username = '*******';
set airbyte_warehouse = 'AIRBYTE_WAREHOUSE';
set airbyte_database = 'AIRBYTE_DATABASE';
set airbyte_schema = 'AIRBYTE_SCHEMA';

-- set user password
set airbyte_password = '********';
 
begin;

-- create Airbyte role
use role securityadmin;
create role if not exists identifier($airbyte_role);
grant role identifier($airbyte_role) to role SYSADMIN;

-- create Airbyte user
create user if not exists identifier($airbyte_username)
password = $airbyte_password
default_role = $airbyte_role
default_warehouse = $airbyte_warehouse;

grant role identifier($airbyte_role) to user identifier($airbyte_username);

-- change role to sysadmin for warehouse / database steps
use role sysadmin;

-- create Airbyte warehouse
create warehouse if not exists identifier($airbyte_warehouse)
warehouse_size = xsmall
warehouse_type = standard
auto_suspend = 60
auto_resume = true
initially_suspended = true;

-- create Airbyte database
create database if not exists identifier($airbyte_database);

-- grant Airbyte warehouse access
grant USAGE
on warehouse identifier($airbyte_warehouse)
to role identifier($airbyte_role);

-- grant Airbyte database access
grant OWNERSHIP
on database identifier($airbyte_database)
to role identifier($airbyte_role);

commit;

begin;

USE DATABASE identifier($airbyte_database);

-- create schema for Airbyte data
CREATE SCHEMA IF NOT EXISTS identifier($airbyte_schema);

commit;
-- create Schema for dim/fact table

use role SYSADMIN; -- made change here from AIT_BYTE ROLE

begin;

USE DATABASE identifier($airbyte_database);

-- create schema for dim/fact 
CREATE SCHEMA IF NOT EXISTS Dim_Fact;

grant USAGE
on schema Dim_Fact
to role identifier($airbyte_role);

commit;

begin;

-- grant Airbyte schema access
grant OWNERSHIP
on schema identifier($airbyte_schema)
to role identifier($airbyte_role);

commit;

USE ROLE ACCOUNTADMIN;
begin; -------- Why does my role not work here? I had to use ACCOUNTADMIN? 


USE DATABASE identifier($airbyte_database);
-- snowflake_rw object level
GRANT ALL ON ALL TABLES IN SCHEMA AIRBYTE_SCHEMA TO ROLE AIRBYTE_ROLE;
GRANT ALL ON FUTURE TABLES IN SCHEMA AIRBYTE_SCHEMA TO ROLE AIRBYTE_ROLE;

GRANT ALL ON ALL TABLES IN SCHEMA DIM_FACT TO ROLE AIRBYTE_ROLE;
GRANT ALL ON FUTURE TABLES IN SCHEMA DIM_FACT TO ROLE AIRBYTE_ROLE;



commit;

--SELECT * from   INFORMATION_SCHEMA.OBJECT_PRIVILEGES
--WHERE
--OBJECT_NAME = 'DIM_FACT';

/*
*/

-- create Schema for dim/fact table

use role SYSADMIN; -- made change here from AIT_BYTE ROLE

begin;

USE DATABASE identifier($airbyte_database);

-- create schema for data_mart
CREATE SCHEMA IF NOT EXISTS data_mart;

grant USAGE
on schema data_mart
to role identifier($airbyte_role);

commit;

USE ROLE accountadmin;

begin;

GRANT ALL ON ALL TABLES IN SCHEMA data_mart TO ROLE AIRBYTE_ROLE;
GRANT ALL ON FUTURE TABLES IN SCHEMA data_mart TO ROLE AIRBYTE_ROLE;

commit;


GRANT ROLE NETWORK_ADMIN TO USER AIRBYTE_USER;




