spool c:\Setup.txt

--Peter Phoun
--IS380 - Database Management
--Final Project Delivery

set echo on;
set heading on;
set feedback on;
set verify off;


drop table COUNTER;
drop table RETURNAUTH;
drop table RETURNREASON;
drop table PRODUCT;
drop table CUSTOMER;


create table CUSTOMER (
	CustNum CHAR (3),
	firstName VARCHAR2 (9),
	lastName VARCHAR2 (9),
	streetAddress VARCHAR2 (20),
	city VARCHAR2 (15),
	stateCode CHAR (2),
	zipCode VARCHAR2 (5),
	phoneNum VARCHAR2 (10),
	primary key (CustNum)
);

insert into CUSTOMER (CustNum, firstName, lastName, streetAddress, city, stateCode, zipCode, phoneNum) values ('101', 'Peter', 'Phoun', '725 E Hill St.', 'Long Beach', 'CA', '90806', '5622533038');
insert into CUSTOMER (CustNum, firstName, lastName, streetAddress, city, stateCode, zipCode, phoneNum) values ('102', 'Adam', 'Quincy', '836 W Mars Ave.', 'Los Angeles', 'CA', '91331', '8182135321');
insert into CUSTOMER (CustNum, firstName, lastName, streetAddress, city, stateCode, zipCode, phoneNum) values ('103', 'Betty', 'Reyes', '947 N Neptune Way', 'New York', 'CA', '10161', '2129810608');
insert into CUSTOMER (CustNum, firstName, lastName, streetAddress, city, stateCode, zipCode, phoneNum) values ('104', 'Carrie', 'Sims', '158 S Jupiter Lane', 'Fulton', 'GA', '30301', '4044562130');
insert into CUSTOMER (CustNum, firstName, lastName, streetAddress, city, stateCode, zipCode, phoneNum) values ('105', 'Dillon', 'Tan', '269 Venus Creek', 'Dallas', 'TX', '75201', '2149986532');


create table PRODUCT (
	ProdNum CHAR (2),
	prodDesc VARCHAR2 (9),
	PPrice NUMBER (7, 2),
	primary key (ProdNum)
);

insert into PRODUCT (ProdNum, prodDesc, PPrice) values ('P1', 'Piano', ' 111.99');
insert into PRODUCT (ProdNum, prodDesc, PPrice) values ('P2', 'Guitar', '222.49');
insert into PRODUCT (ProdNum, prodDesc, PPrice) values ('P3', 'Drum Set', '333.99');
insert into PRODUCT (ProdNum, prodDesc, PPrice) values ('P4', 'Violin', '444.49');
insert into PRODUCT (ProdNum, prodDesc, PPrice) values ('P5', 'Cello', '555.99');


create table RETURNREASON (
	ReasonCode CHAR (1),
	reasonDesc VARCHAR (30),
	primary key (ReasonCode)
);

insert into RETURNREASON (ReasonCode, reasonDesc) values ('1', 'Unsatisfied Quality');
insert into RETURNREASON (ReasonCode, reasonDesc) values ('2', 'Defective Product');
insert into RETURNREASON (ReasonCode, reasonDesc) values ('3', 'Cannot Assemble');
insert into RETURNREASON (ReasonCode, reasonDesc) values ('4', 'Different from Description');
insert into RETURNREASON (ReasonCode, reasonDesc) values ('5', 'Arrived too Late');


create table RETURNAUTH (
	RANum CHAR (4),
	RC# CHAR (1),
	C# CHAR (3),
	P# CHAR (2),
	UnitPrice NUMBER (7, 2),
	dateOpened date,
	QtyExpectedToRcv NUMBER (3),
	AmntExpectedToRcv NUMBER (7, 2),
	qtyActualRcvd NUMBER (3),
	amntActualRcvd NUMBER (7, 2),
	daysOpen number(3),
	dateClosed date,
	status VARCHAR2 (9),
	primary key (RANum),
	constraint FK_CustNum2 foreign key (C#) references CUSTOMER (CustNum),
	constraint FK_ProdNum2 foreign key (P#) references PRODUCT (ProdNum),
	constraint FK_ReasonCode2 foreign key (RC#) references RETURNREASON (ReasonCode)
);


update RETURNAUTH
	set daysopen = trunc(SysDate)-(dateOpened)
		where status = 'O';


create table COUNTER
(
	maxvalue NUMBER (4)	
);


insert into COUNTER (maxvalue) values ('1000');

commit;

spool off;
set echo off;