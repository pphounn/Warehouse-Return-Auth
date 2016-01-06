spool c:\aging.txt

--Peter Phoun
--IS380 - Database Management
--Final Project Delivery

set feedback off
set verify on
set echo off

prompt
prompt ******* OPEN RA AGING REPORT *******
prompt

select 'Today' ||'''s Date: '|| SysDate from DUAL;

accept vAging prompt 'Please enter number of days to query: ';

set heading on

column RANum heading 'RA|Number' format 9999
column status heading 'RA|Status' format a8
column dateOpened heading 'Date|Open' format a10
column RETURNAUTH.P# heading 'Prod|Num' format a5
column prodDesc heading 'Prod|Desc' format a10
column QtyExpectedToRcv heading 'Request|Qty' format 9999
column RETURNAUTH.UnitPrice heading 'Unit|Price' format $9999.99
column AmntExpectedToRcv heading 'Request|Amount' format $9999.99
column daysOpen heading 'Days|Open' format 999

select RANum, status, to_char(daysOpen, 'mm/dd/yyy') dateOpened, RETURNAUTH.P#, prodDesc, QtyExpectedToRcv, RETURNAUTH.UnitPrice,  AmntExpectedToRcv, trunc(SysDate)-trunc(dateOpened)
	from RETURNAUTH, PRODUCT
		where status = 'O' and RETURNAUTH.P#=PRODUCT.ProdNum and trunc(dateOpened) <= trunc(SysDate) - trunc(&vAging) order by daysOpen desc;

spool off