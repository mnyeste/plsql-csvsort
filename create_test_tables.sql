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
