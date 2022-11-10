create database insuranceD1;
use insuranceD1;

create table person(
	driver_id char(10),
	name varchar(10),
    address varchar(20),
    primary key(driver_id)
    );

create table car(
	reg_no char(10),
    model varchar(15),
    primary key(reg_no)
    );

create table owns(
	driver_id char(10),
    reg_no char(10),
    primary key(driver_id,reg_no),
    foreign key(driver_id) references person(driver_id) on delete cascade,
    foreign key(reg_no) references car(reg_no) on delete cascade
    );
    
create table accidents(
	report_num char(10),
    accident_date char(10),
    location char(20),
    primary key(report_num)
    );
    
create table participated(
	driver_id char(10),
    reg_no char(10),
	report_num char(10),
    damage_amount int,
    primary key(driver_id,reg_no,report_num),
    foreign key(driver_id) references person(driver_id) on delete cascade,
    foreign key(reg_no) references car(reg_no) on delete cascade,
    foreign key(report_num) references accidents(report_num) on delete cascade
    );

alter table car
add year year;

alter table accidents
modify accident_date date;

insert into person
value('A01','RICHARD','SRINIVAS NAGAR'),
('A02','PRADEEP','RAJAJI NAGAR'),
('A03','SMITH','ASHOK NAGAR'),
('A04','VENU','N R COLONY'),
('A05','JHON','HANUMANTH NAGAR');

insert into car
value('KA052250','INDICA','1990'),
('KA031181','LANCER','1957'),
('KA095477','TOYOTA','1998'),
('KA053408','HONDA','2008'),
('KA041702','AUDI','2005');

insert into owns
value('A01','KA052250'),
('A02','KA053408'),
('A03','KA031181'),
('A04','KA095477'),
('A05','KA041702');

insert into accidents
value('11','2003-01-01','MYSORE ROAD'),
('12','2004-02-04','SOUTH END CIRCLE'),
('13','2003-01-21','BULL TEMPLE ROAD'),
('14','2008-01-17','MYSORE ROAD'),
('15','2005-03-04','KANAKPURA ROAD');

insert into participated
value('A01','KA052250','11','10000'),
('A02','KA053408','12','50000'),
('A03','KA095477','13','25000'),
('A04','KA031181','14','3000'),
('A05','KA041702','15','5000');

select * from person;
select * from car;
select * from owns;
select * from accidents;
select * from participated;

update person
set address = 'WHITE FEILD'
where driver_id = 'A02';

select address from person;

update person
set name = 'DAVE'
where driver_id = 'A05';

select name from person;

select * from person
where driver_id = 'A04';

select year+1 from car;
select year+1 update_date from car;

select distinct location from accidents;

select * from participated
order by damage_amount asc;

select * from car
where year between 1990 and 2003;

select * from car
where year > 1990;

update person
set name = 'DRAVID'
where driver_id = 'A03';

select * from person
where name like 'D%';

select * from person
where name like '_A%'; 

select * from car
where year in(2008,2005);

select * from person
where name like 'P%';

select * from person
where name like 'p%';

select * from car
where model = 'HONDA' or year = '1957';

select * from car
where year not in(2008,2005);

select name from person
order by name asc;

select name from person
order by name desc;










    
    
    


