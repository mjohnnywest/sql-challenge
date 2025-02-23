-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/v01ew8
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(10) NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(10)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(10)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(10)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(10)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);


select * from departments d  
;

select * from dept_emp de 
;

select * from dept_manager dm ;

select * from employees e ;

select * from salaries s ;

select * from titles t ;

-- employee number, last name, first name, sex, and salary of each employee 
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees e
join salaries s on s.emp_no = e.emp_no 
order by e.emp_no asc ;

-- first name, last name, and hire date for the employees who were hired in 1986
select e.first_name, e.last_name,e.hire_date 
from employees e 
where extract(year from e.hire_date) = 1986
order by e.hire_date  asc ;

-- manager of each department along with their department number, department name, employee number, last name, and first name
select e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name 
from employees e
join dept_emp de on de.emp_no = e.emp_no 
join dept_manager dm on dm.emp_no = e.emp_no
join departments d on d.dept_no = de.dept_no
order by d.dept_no asc
;

-- department number for each employee along with that employee’s employee number, last name, first name, and department name
select de.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
from employees e
join dept_emp de on de.emp_no = e.emp_no 
join departments d on d.dept_no = de.dept_no
order by d.dept_no asc
;

--first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B

select e.first_name, e.last_name, e.sex
from employees e 
where e.first_name = 'Hercules' and e.last_name like 'B%'
order by e.last_name  asc ;

-- each employee in the Sales department, including their employee number, last name, and first name
select e.emp_no, de.dept_no, d.dept_name, e.last_name, e.first_name 
from employees e
join dept_emp de on de.emp_no = e.emp_no 
join departments d on d.dept_no = de.dept_no
where d.dept_name = 'Sales'
order by e.emp_no  asc
;

-- employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select e.emp_no, de.dept_no, d.dept_name, e.last_name, e.first_name 
from employees e
join dept_emp de on de.emp_no = e.emp_no 
join departments d on d.dept_no = de.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development'
order by e.emp_no  asc

--frequency counts, in descending order, of all the employee last names
select e.last_name, count(e.emp_no) as "Employee Count"
from employees e
group by e.last_name
order by "Employee Count"  desc 
;





















