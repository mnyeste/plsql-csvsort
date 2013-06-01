DROP TABLE "CSVSORT"."TEST_DATA1";

CREATE TABLE "CSVSORT"."TEST_DATA1" 
(	"ID" VARCHAR2(32 BYTE), 
"CSVFIELD" VARCHAR2(2048 BYTE)
  );
  
SET DEFINE OFF;
Insert into TEST_DATA1 (ID,CSVFIELD) values ('test01','abc,xyz,ghj');
Insert into TEST_DATA1 (ID,CSVFIELD) values ('test02','tuv,yxc,jkl ');
Insert into TEST_DATA1 (ID,CSVFIELD) values ('test03',null);
Insert into TEST_DATA1 (ID,CSVFIELD) values ('test04','ghj');
Insert into TEST_DATA1 (ID,CSVFIELD) values ('test05',' ab, tu ,ed ,fg');


DROP TABLE "CSVSORT"."TEST_DATA2";

CREATE TABLE "CSVSORT"."TEST_DATA2" 
(	"ID" VARCHAR2(32 BYTE),
  "NUM" number(10),
"LISTOFVALUES" VARCHAR2(2048 BYTE)
  );
  
SET DEFINE OFF;
Insert into TEST_DATA2 (ID,num,LISTOFVALUES) values ('test01',10,' ab, tu ,ed ,fg');
Insert into TEST_DATA2 (ID,num,LISTOFVALUES) values ('test02',20,'tuv,yxc,jkl ');
Insert into TEST_DATA2 (ID,num,LISTOFVALUES) values ('test03',30,'ghj');
Insert into TEST_DATA2 (ID,num,LISTOFVALUES) values ('test04',40,null);
Insert into TEST_DATA2 (ID,num,LISTOFVALUES) values ('test05',50,'abc,xyz,ghj');
Insert into TEST_DATA2 (ID,num,LISTOFVALUES) values ('test06',50,'abc-special,x-xyz,b*ghj');

