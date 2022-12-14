CREATE DATABASE employee_database_shashankmp;
USE employee_database_shashankmp;

CREATE TABLE project(
	p_no INT,
    p_name VARCHAR(20),
    p_loc VARCHAR(10),
    PRIMARY KEY(p_no)
    );

CREATE TABLE dept(
	dept_no INT,
    d_name VARCHAR(20),
    d_loc VARCHAR(20),
    PRIMARY KEY(dept_no)
    );

CREATE TABLE employee(
	emp_no INT,
    e_name VARCHAR(20),
    mgr_no INT,
    hire_date DATE,
    sal INT,
    dept_no INT,
    PRIMARY KEY(emp_no),
    FOREIGN KEY(dept_no) REFERENCES dept(dept_no) ON DELETE CASCADE
    );
    
CREATE TABLE incentives(
	emp_no INT,
    incentive_date DATE,
    incentive_amount INT,
    PRIMARY KEY(emp_no,incentive_date),
    FOREIGN KEY(emp_no)REFERENCES employee(emp_no)ON DELETE CASCADE
    );

CREATE TABLE assigned_to(
	emp_no INT,
    p_no INT,
    job_role VARCHAR(20),
    PRIMARY KEY(emp_no,p_no),
    FOREIGN KEY(emp_no)REFERENCES employee(emp_no) ON DELETE CASCADE,
    FOREIGN KEY(p_no) REFERENCES project(p_no) ON DELETE CASCADE
    );

INSERT INTO dept VALUES
("1","SURVEY","BENGALURU"),
("2","ARCHITECTURE","HYDERABAD"),
("3","TEST_TEAM","MYSURU"),
("4","FINANCE","DELHI"),
("5","ENGINEERING","BOMBAY"),
("6","R&D","DHARWAD");

INSERT INTO project VALUES
("1","ROYAL_BRIDGE","BENGALURU"),
("2","HOTEL_TRAVEL_INN","JAMMU"),
("3","RAILWAY_STATION","CHENNAI"),
("4","SUNSHINE_APARTMENT","BOMBAY"),
("5","HOTEL_PRESIDENT","MANGALORE"),
("6","CENTRAL_AIRPORT","GOA"),
("7","THEME_PARK","MYSURU"),
("8","IT_FIRM","HYDERABAD");


INSERT INTO employee VALUES
("10","DEV",NULL,'2016-11-21',"50000","2"),
("11","ARJUN",NULL,'2015-1-12',"20000","3"),
("12","RAHUL",'16','2016-10-20',"35000","6"),
("13","SARANG",NULL,'2020-12-21',"60000","1"),
("14","PUSHKAR","16",'2019-9-15',"15000","1"),
("15","VIRAT",NULL,'2012-5-13',"50000","4"),
("16","PHILIP",13,'2021-7-1',"20000","1"),
("17","ARUN","10",'2016-4-13',"40000","2"),
("18","RAJ","16",'2016-5-13',"15000","1"),
("19","SARA","10",'2012-5-13',"60000","2"),
("20","ROHIT","16",'2016-5-13',"15000","1");


INSERT INTO incentives VALUES
("11",'2019-1-21',"2000"),
("14",'2020-10-15',"8000"),
("15",'2015-11-15',"10000"),
("15",'2021-11-5',"10000"),
("14",'2021-11-5',"9000"),
("13",'2021-11-5',"5000");

INSERT INTO assigned_to VALUES
("10","2","LEAD"),
("17","2","SITE_ARCHITECT"),
("11","3","TESTING_LEAD"),
("13","1","SITE_ENG"),
("13","3","SITE_ENG"),
("14","3","SURVEY_LEAD"),
("15","6","FINANCE_MANAGER"),
("10","4","SITE_ARCHITECT"),
("15","5","FINANCE_MANAGER"),
("14","1","SURVEY_LEAD"),
("11","7","TESTING_LEAD"),
("10","8","LEAD");

SELECT DISTINCT e.emp_no,e.e_name
FROM employee e,assigned_to a,project p
WHERE e.emp_no=a.emp_no AND a.p_no=p.p_no AND p.p_loc in("BENGALURU","HYDERABAD","MYSURU");

SELECT DISTINCT e.emp_no
FROM employee e,incentives i
WHERE e.emp_no NOT IN (SELECT i.emp_no
						FROM incentives i);

SELECT DISTINCT e.e_name,e.emp_no,e.dept_no,a.job_role,d.d_loc,p.p_loc
FROM employee e,dept d,assigned_to a,project p
WHERE d.dept_no=e.dept_no AND e.emp_no=a.emp_no AND a.p_no=p.p_no AND p.p_loc=d.d_loc;

SELECT DISTINCT e.e_name,d.d_name,a.job_role
FROM employee e,dept d,assigned_to a,incentives i
WHERE e.emp_no=a.emp_no AND e.emp_no=i.emp_no AND e.dept_no=d.dept_no AND i.incentive_amount=(
SELECT max(incentive_amount)
FROM incentives i
WHERE i.incentive_date between '2021-1-1'AND'2021-12-31');

#WEEK 6

SELECT e1.e_name,e1.sal
FROM employee e1
WHERE  sal>(SELECT avg(sal) FROM employee e WHERE e1.dept_no=e.dept_no) AND e1.mgr_no is NULL;

SELECT e.emp_no,i.incentive_amount,i.incentive_date
FROM employee e,incentives i 
WHERE e.emp_no=i.emp_no and incentive_date between '2021-10-31' and '2021-12-1'
and incentive_amount=(SELECT max(incentive_amount) FROM incentives i
                                  WHERE incentive_date between '2021-10-31' and '2021-12-1'
      and i.incentive_amount<(SELECT max(incentive_amount) FROM incentives
                                  WHERE incentive_date between '2021-10-31' and '2021-12-1'));
                                  
select e.e_name
from employee e
where  e.emp_no
in (select e.mgr_no
from employee e
where  e.emp_no in(select mgr_no from employee));
    
