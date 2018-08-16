/*
 * Coming from here:
 * https://github.com/tidyverse/haven/issues/204
 */

libname mylib '/home/bceuser/fajardoo/tests/catalog';

proc format library=mylib.test_formats;
/* both A and B formats are identical, only order of possible values is different*/
value $A
  "1" = "Male"
  "2" = "Female" ;
value $B
  "2" = "Female"
  "1" = "Male";
run ;

Options fmtsearch=(work mylib.test_formats);

proc formats library=mylib.test_formats cntlout=mjh;
run;

data mylib.test_data (label="mytest label");
  input ID $ SEXA $ SEXB $ ;
format SEXA $A. SEXB $B. ;   
  datalines ;
    ID1 1 1
    ID2 2 2
    ID3 1 1
  ;
run ;

proc contents details data=mylib.test_data out=content;
run;