spool c:\byReason.txt

--Peter Phoun
--IS380 - Database Management
--Final Project Delivery

set feedback off
set verify on
set echo off

prompt
prompt ******* RETURN PRODUCT BY REASON REPORT *******
prompt

set heading on

column P# heading 'Prod|Num' format a5
column prodDesc heading 'Product|Description' format a11
column RC# heading 'Reason|Code' format a6
column reasonDesc heading 'Reason|Description' format a30
column count(qtyActualRcvd) heading 'No of|Returns' format 9999
column sum(QtyExpectedToRcv) heading 'Total|Qty' format 9999
column sum(AmntExpectedToRcv) heading 'Total|Amount' format $9999.99

select RETURNAUTH.P#, prodDesc, RETURNAUTH.RC#, reasonDesc, count(qtyActualRcvd), sum(QtyExpectedToRcv), sum(AmntExpectedToRcv)
	from RETURNAUTH, PRODUCT, RETURNREASON
		where RETURNAUTH.P#=PRODUCT.ProdNum and RETURNAUTH.RC#=RETURNREASON.ReasonCode
			group by RETURNAUTH.P#, prodDesc, RETURNAUTH.RC#, reasonDesc;

spool off