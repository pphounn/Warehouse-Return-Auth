spool c:\closeRA.txt

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
prompt ****** CLOSE A RETURN AUTHORIZATION ******
prompt


select 'Today' ||'''s Date: '|| SysDate from DUAL;
prompt

accept vRANum CHAR prompt 'Enter RA Number: ';
prompt

select 'RA Number: ', RANum
	from RETURNAUTH
		where RANum='&vRANum';
	
select 'RA Open Date: ', dateOpened
	from RETURNAUTH
		where RANum='&vRANum';
prompt

select 'Customer Number: ', C#
	from RETURNAUTH
		where RANum='&vRAnum';

select ' '||' '||' '||'Customer Name:', rtrim(initcap(lastName))|| ', ' ||rtrim(initcap(firstName))
	from CUSTOMER, RETURNAUTH
		where RANum='&vRANum'
			and CUSTOMER.CustNum=RETURNAUTH.C#;
	
select ' '||' '||' '||'Shipping Address:', rtrim(streetAddress)
	from CUSTOMER, RETURNAUTH
		where RANum='&vRANum'
			and CUSTOMER.CustNum=RETURNAUTH.C#;

select ' '||' '||' '||'City, State. Zip Code:', rtrim(city)|| ', ' ||rtrim(stateCode)|| '. ' ||rtrim(zipCode)
	from CUSTOMER, RETURNAUTH
		where RANum='&vRANum'
			and CUSTOMER.CustNum=RETURNAUTH.C#;

select ' '||' '||' '||'Phone: ', '('||substr(phoneNum,1,3)||')'||' '||substr(phoneNum,4,3)||'-'||substr(phoneNum,7,4)
	from CUSTOMER, RETURNAUTH
		where RANum='&vRANum'
			and CUSTOMER.CustNum=RETURNAUTH.C#;
	
	
prompt
select 'Prod Number: ', P#
	from RETURNAUTH
		where RANum='&vRANum';

select ' '||' '||' '||'Prod Description: ', prodDesc
	from PRODUCT, RETURNAUTH
		where RANum='&vRANum'
			and PRODUCT.ProdNum=RETURNAUTH.P#;

select ' '||' '||' '||'Unit Price: ', ltrim(to_char(PRODUCT.PPrice, '$99999.99'))
	from PRODUCT, RETURNAUTH
		where RANum='&vRANum'
			and PRODUCT.ProdNum=RETURNAUTH.P#;


prompt
select 'Reason Code: ', RC#
	from RETURNAUTH
		where RANum='&vRANum';

select 'Reason Description: ', reasonDesc
	from RETURNREASON, RETURNAUTH
		where RANum='&vRANum'
			and RETURNREASON.ReasonCode=RETURNAUTH.RC#;
			

prompt
select 'Quantity requested to return: ', ltrim(QtyExpectedToRcv)
	from RETURNAUTH
		where RANum='&vRANum';
	
select 'Amount requested to return: ', ltrim((to_char(AmntExpectedToRcv, '$99999.99')))
	from RETURNAUTH
		where RANum='&vRANum';			
			
					
prompt
accept vRetQ prompt 'Please enter actual return quantity: ';

update RETURNAUTH
	set qtyActualRcvd='&vRetQ'
		where RANum='&vRANum';
		
update RETURNAUTH
	set amntActualRcvd=UnitPrice*&vRetQ
		where RANum='&vRANum';
		
update RETURNAUTH
	set dateClosed=Sysdate
		where RANum='&vRANum';
		
update RETURNAUTH
	set daysOpen = trunc(Sysdate)-trunc(dateOpened)
		where RANum='&vRANum';
		
update RETURNAUTH
	set status = 'C'
		where RANum='&vRANum';
		
prompt
prompt **********************************

select '********** Return Authorization -->'||' '||(RANum)||' is now Closed'
	from RETURNAUTH
		where RANum='&vRANum';
prompt
	
select 'Date Closed: ', dateClosed
	from RETURNAUTH	
		where RANum='&vRANum';

select 'Quantity Received: ', ltrim(qtyActualRcvd)
	from RETURNAUTH
		where RANum='&vRANum';
		
select 'Amount Credited: '||to_char(amntActualRcvd, '$99999.99')
	from RETURNAUTH
		where RANum='&vRANum';
prompt

spool off