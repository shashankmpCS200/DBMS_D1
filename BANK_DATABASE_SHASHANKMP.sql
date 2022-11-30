CREATE DATABASE bank_database_shashankmp;
USE bank_database_shashankmp;

CREATE TABLE branch(
	branch_name VARCHAR(30), 
    branch_city VARCHAR(10),
    assets REAL,
    PRIMARY KEY(branch_name)
    );

CREATE TABLE bank_account(
	acc_no INT,
    branch_name VARCHAR(30),
    balance REAL,
    PRIMARY KEY(acc_no,branch_name)
    );
    
CREATE TABLE bank_customer(
	customer_name VARCHAR(10),
    customer_street VARCHAR(10),
    customer_city VARCHAR(10),
    PRIMARY KEY(customer_name,customer_street,customer_city)
    );

CREATE TABLE depositer(
	customer_name VARCHAR(10),
    acc_no INT,
    PRIMARY KEY(acc_no,customer_name),
    FOREIGN KEY(customer_name)REFERENCES bank_customer(customer_name) ON DELETE CASCADE,
	FOREIGN KEY(acc_no)REFERENCES bank_account(acc_no) ON DELETE CASCADE
    );

CREATE TABLE loan(
	loan_number INT,
    branch_name VARCHAR(30),
    amount REAL,
    PRIMARY KEY(loan_number),
    foreign key(branch_name)REFERENCES branch(branch_name) ON DELETE CASCADE
    );
CREATE TABLE borrower(
	loan_number INT,
    customer_name VARCHAR(10),
    PRIMARY KEY(loan_number,customer_name),
    FOREIGN KEY(loan_number)REFERENCES loan(loan_number) ON DELETE CASCADE,
    FOREIGN KEY(customer_name)REFERENCES bank_customer(customer_name) ON DELETE CASCADE
    );
 
INSERT INTO borrower
VALUE("1","AVINASH"),
("2","DINESH"),
("3","NIKIL"),
("4","RAVI"),
("5","AVINASH");
insert into borrower value("6","mohan");

INSERT INTO branch
VALUE("SBI_CHAMRAJPET","BANGALORE","50000"),
("SBI_RESIDENCY_ROAD","BANGALORE","10000"),
("SBI_SHIVAJI_ROAD","BOMBAY","20000"),
("SBI_PARLIAMENT_ROAD","DELHI","10000"),
("SBI_JANTAR_MANTAR","DELHI","20000");

INSERT INTO bank_account
VALUE("1","SBI_CHAMRAJPET","2000"),
("2","SBI_RESIDENCY_ROAD","5000"),
("3","SBI_SHIVAJI_ROAD","6000"),
("4","SBI_PARLIAMENT_ROAD","9000"),
("5","SBI_JANTAR_MANTAR","8000"),
("6","SBI_SHIVAJI_ROAD","4000"),
("8","SBI_RESIDENCY_ROAD","4000"),
("9","SBI_PARLIAMENT_ROAD","3000"),
("10","SBI_RESIDENCY_ROAD","5000"),
("11","SBI_JANTAR_MANTAR","2000");

ALTER TABLE bank_customer
MODIFY customeR_street VARCHAR(20);

INSERT INTO bank_customer
VALUE("AVINASH","BULL_TEMPLE_ROAD","BANGALORE"),
("DINESH","BANNERGATTA_ROAD","BANGALORE"),
("MOHAN","NATIONALCOLLEGE_ROAD","BANGALORE"),
("NIKIL","AKBAR_ROAD","DELHI"),
("RAVI","PRITHVIRAJ_ROAD","DELHI");

INSERT INTO depositer
VALUE("AVINASH","1"),
("DINESH","2"),
("NIKIL","4"),
("RAVI","5"),
("AVINASH","8"),
("NIKIL","9"),
("DINESH","10"),
("NIKIL","11");

INSERT INTO loan
VALUE("1","SBI_CHAMRAJPET","1000"),
("2","SBI_RESIDENCY_ROAD","2000"),
("3","SBI_SHIVAJI_ROAD","3000"),
("4","SBI_PARLIAMENT_ROAD","4000"),
("5","SBI_JANTAR_MANTAR","5000"),
("6","SBI_SHIVAJI_ROAD","3000"),
("7","SBI_PARLIAMENT_ROAD","4000"),
("8","SBI_RESIDENCY_ROAD","2000");





SELECT branch_name,assets/100000 assets_in_lakhs
FROM branch;

create view total_loan
as
SELECT l.branch_name, sum(amount)
from loan l
group by l.branch_name;

select * from total_loan;

UPDATE  bank_account b,bank_customer,depositer
SET balance=balance+1000
WHERE b.acc_no=depositer.acc_no AND
 depositer.customer_name=bank_customer.customer_name AND
 bank_customer.customer_city="BANGALORE";   

select *
from bank_account;

select d.customer_name
from depositer d,bank_account a,branch b
where d.acc_no=a.acc_no AND a.branch_name=b.branch_name
group by d.customer_name
having count(*)>=2;

select d.customer_name
from branch b,depositer d,bank_account a
where b.branch_city="delhi" and d.acc_no=a.acc_no and b.branch_name=a.branch_name
group by d.customer_name
having count(customer_name)>1;

select b.branch_name
from branch b
where b.assets> all(select sum(b.assets)
				from branch b
				where b.branch_city="BANGALORE");
                
select distinct b.customer_name 
from borrower b,depositer d
where b.customer_name not in(select d.customer_name from loan l,depositer d,borrower b
							where l.loan_number=b.loan_number and
                            d.customer_name=b.customer_name);

select distinct d.customer_name
from depositer d
where d.customer_name in( select d.customer_name 
					from branch b,depositer d,bank_account a
                    where b.branch_city="bangalore" and b.branch_name=a.branch_name and
                    a.acc_no=d.acc_no and d.customer_name in(select customer_name from borrower));

update bank_account
set balance=(balance+(balance*0.05))
where acc_no in(1,2,3,4,5,6,8,9,10,11);
select*from bank_account;

delete a.*
from bank_account a,branch b
where branch_city="bombay" and a.branch_name=b.branch_name;

delete ba.* from bank_account ba, branch b where branch_city='Bombay' and
ba.branch_name=b.branch_name;


delete b.*,ba.* from branch b, bank_account ba,loan l
Where b.branch_city=”Bangalore” and b.branch_name=ba.branch_name
And l.branch_name=ba.branch_name;
select * from branch;

















'
    
    
