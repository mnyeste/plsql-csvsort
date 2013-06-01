create or replace type t_temp_str_table is table of varchar2(2048); 
/

declare  

  function sort_csv_string(v_original in varchar2)
    return varchar2
  is
    v_count integer;
  
    v_str_array dbms_utility.lname_array;
    v_str_array_sorted dbms_utility.lname_array;
    
    v_str_table t_temp_str_table := t_temp_str_table();
    v_str_table_sorted t_temp_str_table;
   
    v_sorted varchar2(2048);
  
  begin

    dbms_utility.comma_to_table(v_original, v_count, v_str_array);

    for i in 1..v_count 
    loop
        v_str_table.extend;
        v_str_table(i) := v_str_array(i);
    end loop;
  
    select trim(column_value) bulk collect 
    into v_str_table_sorted from table(v_str_table) order by 1;

    for i in 1..v_count
    loop
      v_str_array_sorted(i) := v_str_table_sorted(i);
    end loop;
  
    dbms_utility.table_to_comma(v_str_array_sorted, v_count, v_sorted);
  
    return v_sorted;
  end;

  procedure sort_and_update_csv_field(table_name in varchar2)
  is 
    v_tmp_str varchar2(2048);
  begin
      
    for rec in 
      (select rowid, csvfield from test_data1
       where csvfield like '%,%') 
    loop
      dbms_output.put_line(rec.csvfield);
    
      v_tmp_str :=  sort_csv_string(rec.csvfield);
    
      update test_data1 
      set csvfield =  v_tmp_str
      where rowid = rec.rowid;
    end loop;
  end;


begin  
  --dbms_output.put_line('Sorted: ' || sort_csv_string('asd,zui,fgh'));
  sort_and_update_csv_field;
end;
