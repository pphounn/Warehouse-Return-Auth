spool c:\queryRA.txt

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
prompt ****** RETURN AUTHORIZATION DETAIL REPORT ******
prompt


accept vRANum CHAR prompt 'Enter RA Number: ';
prompt


select 'RA Number: ', RANum
	from RETURNAUTH
		where RANum='&vRANum';
	
select 'RA Status: ', status
	from RETURNAUTH
		where RANum='&vRANum';

		
prompt
select 'Customer Number: ', C#
	from RETURNAUTH
		where RANum='&vRANum';
		
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
select 'RA Open Date: ', dateOpened
	from RETURNAUTH
		where RANum='&vRANum';
	
Select 'RA Close Date: ', dateClosed
	from RETURNAUTH
		where RANum='&vRANum';

		
prompt
select 'Quantity requested to return: ', ltrim(QtyExpectedToRcv)
	from RETURNAUTH
		where RANum='&vRANum';
	
select 'Amount requested to return: ', ltrim(to_char(AmntExpectedToRcv, '$99999.99'))
	from RETURNAUTH
		where RANum='&vRANum';
	
select 'Quantity Received: ', ltrim(qtyActualRcvd)
	from RETURNAUTH
		where RANum='&vRANum';
	
select 'Amount Credited: ', ltrim(to_char(amntActualRcvd, '$99999.99'))
	from RETURNAUTH
		where RANum='&vRANum';
prompt
		

spool off