declare  

  function sort_csv_string(i_original in varchar2)
    return varchar2
  is
    l_sorted varchar2(2048);
  begin
    
    for rec in 
      (select trim(regexp_substr (str, '[^,]+', 1, rownum)) token  
          from (select i_original str from dual)
          connect by level <= regexp_count (str, '[^,]+')
          order by 1)
       loop
       
       if (l_sorted is not null) then
        l_sorted := l_sorted || ',';
        end if;
      
      l_sorted := l_sorted || rec.token;

      --dbms_output.put_line(rec.token);
    end loop;   
  
    return l_sorted;
  end;

  procedure sort_and_update_csv_field(i_table_name in varchar2, i_field_name in varchar2)
  is 
    type t_ref_cursor is REF CURSOR;
    c_records_with_csv_value t_ref_cursor;
    
    l_sorted_str varchar2(2048);
    
    l_row_id rowid;
    l_csv_field_value varchar2(2048);
    
    l_select_str varchar2(200);
    l_update_str varchar2(200);
        
  begin
    
    l_select_str := 'select rowid, ' || i_field_name || 
                    ' from ' || i_table_name ||
                    ' where ' || i_field_name || ' like ''%,%''';
     
    open c_records_with_csv_value for l_select_str;
    
    loop
      fetch c_records_with_csv_value into l_row_id, l_csv_field_value;
      exit when c_records_with_csv_value%notfound;
          
      l_sorted_str :=  sort_csv_string(l_csv_field_value);
    
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
