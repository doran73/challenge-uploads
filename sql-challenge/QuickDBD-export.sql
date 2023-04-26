-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE departments (
    dept_id int   NOT NULL,
    dept_no varchar(10)  NOT NULL,
    dept_name varchar(255)   NOT NULL
);

CREATE TABLE dept_emp (
    Dept_Emp_ID int   NOT NULL,
    Emp_No int   NOT NULL,
    Dept_No int   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        Dept_Emp_ID
     )
);

CREATE TABLE dept_manager (
    Dept_Manager_ID int   NOT NULL,
    Dept_No varchar(10)   NOT NULL,
    Emp_No int   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        Dept_Manager_ID
     )
);

CREATE TABLE employees (
    Emp_ID int   NOT NULL,
    Emp_No int   NOT NULL,
    Emp_Title varchar(255)   NOT NULL,
    Birth_Date date   NOT NULL,
    first_name varchar(50)   NOT NULL,
    last_name varchar(50)   NOT NULL,
    sex varchar(50)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        Emp_No
     )
);

CREATE TABLE salaries (
    Salary_ID int   NOT NULL,
    Emp_No int   NOT NULL,
    Salary double   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        Salary_ID
     )
);

CREATE TABLE titles (
    ID int   NOT NULL,
    title_ID varchar(255)   NOT NULL,
    title varchar(255)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_ID
     )
);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_Emp_No FOREIGN KEY(Emp_No)
REFERENCES employees (Emp_No);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_Dept_No FOREIGN KEY(Dept_No)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_Dept_No FOREIGN KEY(Dept_No)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_Emp_No FOREIGN KEY(Emp_No)
REFERENCES employees (Emp_No);

ALTER TABLE employees ADD CONSTRAINT fk_employees_Emp_Title FOREIGN KEY(Emp_Title)
REFERENCES titles (title_ID);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_Emp_No FOREIGN KEY(Emp_No)
REFERENCES employees (Emp_No);

