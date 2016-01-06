spool c:\openRA.txt

--Peter Phoun
--IS380 - Database Management
--Final Project Delivery

set echo off
set heading off
set feedback off
set verify off

set pagesize 0
set colsep ' '

prompt
prompt ****** OPEN A RETURN AUTHORIZATION ******
prompt


select 'Today' ||'''s Date: '|| SysDate from DUAL;
prompt

accept vCustNum CHAR prompt 'Enter the Customer Number: ';
select ' '||' '||' '||'Customer Name:', rtrim(initcap(lastName))|| ', ' ||rtrim(initcap(firstName))
	from CUSTOMER
		where CustNum='&vCustNum';
select ' '||' '||' '||'Shipping Address:', rtrim(streetAddress)
	from CUSTOMER
		where CustNum='&vCustNum';
select ' '||' '||' '||'City, State. Zip Code:', rtrim(city)|| ', ' ||rtrim(stateCode)|| '. ' ||rtrim(zipCode)
	from CUSTOMER
		where CustNum='&vCustNum';
select ' '||' '||' '||'Phone: ', '('||substr(phoneNum,1,3)||')'||' '||substr(phoneNum,4,3)||'-'||substr(phoneNum,7,4)
	from CUSTOMER
		where CustNum='&vCustNum';

--TURN HEADING ON TO SEE COLUMN NAMES
set heading on

prompt
accept vProdNum CHAR prompt 'Enter the Product Number: ';
select '   Product ID: ', ProdNum
	from PRODUCT
		where ProdNum='&vProdNum';
		
select '   Product Description: ', prodDesc 
	from PRODUCT
		where ProdNum='&vProdNum';
		
select '   Unit Price: ', ltrim(to_char(PRODUCT.PPrice, '$99999.99'))
	from PRODUCT
		where ProdNum='&vProdNum';
prompt


accept vRetQ prompt 'Enter the Return Quantity: ';

Select '    Amount returned:'||to_char(PPrice*'&vRetQ', '$99999.99')
	from PRODUCT
		where ProdNum= '&vProdNum';
	
prompt
prompt Please choose from the following reason code:
prompt

set heading on

column RC# heading 'Reason|Code' format a4
column reasonDesc heading 'Reason|Description' format a30

select * from RETURNREASON;

set heading off
prompt
accept vRcode prompt 'Enter the Reason Code: '
prompt

insert into RETURNAUTH(RANum, RC#, C#, P#, UnitPrice, dateOpened, QtyExpectedToRcv, AmntExpectedToRcv, qtyActualRcvd, amntActualRcvd, daysOpen, dateClosed, status)
	select maxvalue, '&vRcode', '&vCustNum', '&vProdNum', PPrice, sysdate, '&vRetQ', PPrice*&vRetQ, null, null,null,null, 'O'
		from PRODUCT, Counter
			where ProdNum='&vProdNum';
	
COMMIT;

prompt ***** Please print the Return Label. Thank you! *****
prompt

select 'Return Authorization Number: ', ltrim(rtrim(maxvalue))
	from COUNTER;
	
prompt Mail to: 1213 Warehouse Road
prompt 	Gainsville, FL 13802
prompt

update COUNTER set maxvalue = maxvalue + 1;

spool off