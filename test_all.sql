declare 
  v_strings t_strings:=t_strings('one','two', 'abc','ydf');
  v_sorted_strings t_strings;
  v_count integer;
  v_original dbms_utility.lname_array;
begin

    dbms_utility.comma_to_table('ab,fgh', v_count, v_original);

    select * bulk collect into v_sorted_strings from table(v_strings) order by 1;
  
    select count(*) into v_count from table(v_sorted_strings);
  
    for rec in (select * from table(v_sorted_strings))
    loop
      dbms_output.put_line(rec.column_value);
    end loop;
  
    dbms_output.put_line('Sorted count: ' || v_count);
end;


--declare
--   type num_tbl is table of number;
--   l_num_tbl num_tbl:= num_tbl(6,12,9,1,54,21, 11, 2);
--   l_idx integer;
-- begin
-- --  select cast ( multiset( select *
-- --                         from table( l_num_tbl )
-- --                         order by 1
-- --                        ) as varchar2(2048))
--   select *
--                          from table( l_num_tbl )
--                         order by 1
--   into l_num_tbl
--   from dual; 
--   l_idx:= l_num_tbl.first;
--   loop
--     dbms_output.put_line(l_num_tbl(l_idx));
--     l_idx:= l_num_tbl.next(l_idx);
--     exit when l_idx is null;
--   end loop;
--end; 

--declare
--   type num_tbl is table of number;
--   l_num_tbl num_tbl:= num_tbl(6,12,9,1,54,21, 11, 2);
--   l_idx number;
-- begin
--   select cast ( multiset( select *
--                          from table( l_num_tbl )
--                          order by 1
--                         ) as num_tbl)
--   into l_num_tbl
--   from dual;
--
--
--   l_idx:= l_num_tbl.first;
--   loop
--     dbms_output.put_line(l_num_tbl(l_idx));
--     l_idx:= l_num_tbl.next(l_idx);
--     exit when l_idx is null;
--   end loop;
--end;
--declare
-- type num_tbl is table of number;
-- l_num_tbl num_tbl:= num_tbl(6,12,9,1,54,21, 11, 2);
-- l_idx integer;
--begin
-- l_idx:= l_num_tbl.first;
-- loop
--   dbms_output.put_line(l_num_tbl(l_idx));
--   l_idx:= l_num_tbl.next(l_idx);
--   exit when l_idx is null;
--   end loop;
--end;
--DECLARE
--  type num_tbl is table of number;
--  
--  -- define and initialize a simple Nested Table Collection
--  l_num_tbl num_tbl:= num_tbl(6,12,9,1,54,21, 11, 2);
--  l_idx INTEGER;
--BEGIN
--  DECLARE
--    -- here is where the sorting magic starts
--    -- we create an Associative Array that is indexed by binary_integer
--    -- we know that this collection's keys (the only thing we care about in this case)
--    -- will always be kept in sorted order
--  type num_aat_t IS   TABLE OF NUMBER INDEX BY binary_integer;
--  l_num_aat num_aat_t;
--BEGIN
--  l_idx:= l_num_tbl.first;
--  -- loop over all elements in the l_num_tbl collection
--  -- that we want to sort. Use every element in l_num_tbl
--  -- as a key for the l_num_aat associative array. Associate
--  -- the key with a meaningless value; we do not care about
--  -- the value in this case.
--  LOOP
--    l_num_aat( l_num_tbl(l_idx)):=0;
--    l_idx:= l_num_tbl.next(l_idx);
--    EXIT WHEN l_idx IS NULL;
--  END LOOP;
--  -- remove all elements from l_num_tbl
--  l_num_tbl.delete;
--  -- start repopulating l_num_tbl - in the proper order -
--  -- from the sorted collection of keys in the l_num_aat collection
--  l_idx:= l_num_aat.first;
--  LOOP
--    l_num_tbl.extend;
--    l_num_tbl(l_num_tbl.last):= l_idx;
--    l_idx                    := l_num_aat.next(l_idx);
--    EXIT
--  WHEN l_idx IS NULL;
--  END LOOP;
--END;
---- DONE! At this point, l_num_tbl is properly sorted
--l_idx:= l_num_tbl.first;
--LOOP
--  dbms_output.put_line('**     '||l_num_tbl(l_idx));
--  l_idx:= l_num_tbl.next(l_idx);
--  EXIT
--WHEN l_idx IS NULL;
--END LOOP;
--END; 