create or replace type t_temp_str_table is table of varchar2(2048); 
/

declare  

  function sort_csv_string(i_original in varchar2)
    return varchar2
  is
    l_count integer;
  
    l_str_array dbms_utility.lname_array;
    l_str_array_sorted dbms_utility.lname_array;
    
    l_str_table t_temp_str_table := t_temp_str_table();
    l_str_table_sorted t_temp_str_table;
   
    l_sorted varchar2(2048);
  
  begin

    dbms_utility.comma_to_table(i_original, l_count, l_str_array);

    for i in 1..l_count 
    loop
        l_str_table.extend;
        l_str_table(i) := l_str_array(i);
    end loop;
  
    select trim(column_value) bulk collect 
    into l_str_table_sorted from table(l_str_table) order by 1;

    for i in 1..l_count
    loop
      l_str_array_sorted(i) := l_str_table_sorted(i);
    end loop;
  
    dbms_utility.table_to_comma(l_str_array_sorted, l_count, l_sorted);
  
    return l_sorted;
  end;

  procedure sort_and_update_csv_field(i_table_name in varchar2, i_field_name in varchar2)
  is 
    type t_ref_cursor is REF CURSOR;
    c_records_with_csv_value t_ref_cursor;
    
    l_sorted_str varchar2(2048);
    
    l_row_id rowid;
    l_csv_field varchar2(2048);
    
    l_select_str varchar2(200);
    l_update_str varchar2(200);
        
  begin
    
    l_select_str := 'select rowid, ' || i_field_name || 
                    ' from ' || i_table_name ||
                    ' where ' || i_field_name || ' like ''%,%''';
     
    open c_records_with_csv_value for l_select_str;
    
    loop
      fetch c_records_with_csv_value into l_row_id, l_csv_field;
      exit when c_records_with_csv_value%notfound;
          
      l_sorted_str :=  sort_csv_string(l_csv_field);
    
      l_update_str := 'update ' || i_table_name || 
                      ' set ' || i_field_name || ' = ''' || l_sorted_str ||
                      ''' where rowid = '''  || l_row_id || '''';
      
      execute immediate l_update_str;
      commit;
    
    end loop;
  end;


begin  
  sort_and_update_csv_field('test_data1','csvfield');
  sort_and_update_csv_field('test_data2','listofvalues');
end;
