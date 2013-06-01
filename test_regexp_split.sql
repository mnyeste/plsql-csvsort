create or replace type t_temp_str_table is table of varchar2(2048); 
/

declare
  l_t_str t_temp_str_table;
  
  l_field_value varchar2(200) := 'ABC,GHI,DEF,J-KL,bc*asd';

begin

for rec in 
( select regexp_substr (str, '[^,]+', 1, rownum) token  
  from (select l_field_value str from dual)
  connect by level <= regexp_count (str, '[^,]+')
  order by 1)
loop
  dbms_output.put_line('line: ' || rec.token);
end loop;

end;
 
