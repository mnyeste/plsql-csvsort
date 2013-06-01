create tablespace csvsort_data
     datafile '/u01/app/oracle/oradata/XE/csvsort_data_01.dbf' size 256M
     extent management local autoallocate segment space management auto;

create user csvsort identified by "csvsort" default tablespace csvsort_data;

grant connect to csvsort;

alter user csvsort quota unlimited on csvsort_data;

grant create table to csvsort;

--drop user csvsort;
