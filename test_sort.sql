declare 
  v_strings t_strings:=t_strings('one','two', 'abc','ydf');
  v_sorted_strings t_strings;
  v_count integer;
  v_original dbms_utility.lname_array;
begin

    select * bulk collect into v_sorted_strings from table(v_strings) order by 1;
  
    select count(*) into v_count from table(v_sorted_strings);
  
    for rec in (select * from table(v_sorted_strings))
    loop
      dbms_output.put_line(rec.column_value);
    end loop;
  
    dbms_output.put_line('Sorted count: ' || v_count);
end;

