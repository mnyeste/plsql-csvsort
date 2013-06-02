plsql-csvsort
=============

Task: sort CSV values stored in one field (in-place)

First idea was to split CSV:

http://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_util.htm#i1002468

It doesn't work if the field contains hyphen (-)...

Thanks to: 

http://nuijten.blogspot.hu/2009/07/splitting-comma-delimited-string-regexp.html
