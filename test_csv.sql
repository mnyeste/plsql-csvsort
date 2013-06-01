create or replace type t_temp_str_table is table of varchar2(2048); 
/

declare  

  function sort_csv_string(i_original in varchar2)
    return varchar2
  is
    v_count integer;
  
    v_str_array dbms_utility.lname_array;
    v_str_array_sorted dbms_utility.lname_array;
    
    v_str_table t_temp_str_table := t_temp_str_table();
    v_str_table_sorted t_temp_str_table;
   
    v_sorted varchar2(2048);
  
  begin

    dbms_utility.comma_to_table(i_original, v_count, v_str_array);

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

  procedure sort_and_update_csv_field(i_table_name in varchar2, i_field_name in varchar2)
  is 
    type r_cursor is REF CURSOR;
    cur r_cursor;
    
    v_tmp_str varchar2(2048);
    
    v_row_id rowid;
    v_csvfield varchar2(2048);
    
    l_sql_str VARCHAR2(200);
    l_update_str VARCHAR2(200);
        
  begin
    
    l_sql_str := 'select rowid, ' || i_field_name || ' from ' || i_table_name ||' where ' || i_field_name || ' like ''%,%''';
     
    open cur for l_sql_str;
    
    loop
      fetch cur into v_row_id, v_csvfield;
      exit when cur%notfound;
          
      v_tmp_str :=  sort_csv_string(v_csvfield);
    
      l_update_str := 'update ' || i_table_name || 
                      ' set ' || i_field_name || ' = ''' || v_tmp_str ||
                      ''' where rowid = '''  || v_row_id || '''';
      
      execute immediate l_update_str;
    
    end loop;
  end;


begin  
  sort_and_update_csv_field('test_data1','csvfield');
  sort_and_update_csv_field('test_data2','listofvalues');
end;
