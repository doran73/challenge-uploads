-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_id" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_id"
     )
);

CREATE TABLE "Dept_Emp" (
    "Dept_Emp_ID" int   NOT NULL,
    "Emp_No" int   NOT NULL,
    "Dept_No" int   NOT NULL,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "Dept_Emp_ID"
     )
);

CREATE TABLE "Dept_Manager" (
    "Dept_Manager_ID" int   NOT NULL,
    "Dept_No" varchar   NOT NULL,
    "Emp_No" int   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "Dept_Manager_ID"
     )
);

CREATE TABLE "Employees" (
    "Emp_ID" int   NOT NULL,
    "Emp_No" int   NOT NULL,
    "Emp_Title" varchar   NOT NULL,
    "Birth_Date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    "title_ID" varchar   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Emp_ID"
     )
);

CREATE TABLE "Salaries" (
    "Salary_ID" int   NOT NULL,
    "Emp_No" int   NOT NULL,
    "Salary" double   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "Salary_ID"
     )
);

CREATE TABLE "Titles" (
    "ID" int   NOT NULL,
    "title_ID" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "ID"
     )
);

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Employees" ("Emp_No");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_Dept_No" FOREIGN KEY("Dept_No")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_Dept_No" FOREIGN KEY("Dept_No")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Employees" ("Emp_No");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_title_ID" FOREIGN KEY("title_ID")
REFERENCES "Titles" ("title_ID");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Employees" ("Emp_No");

