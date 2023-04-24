--Data Analysis
--List the employee number, last name, first name, sex, and salary of each employee.
Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary from
employees e
left join
Salaries s
on e.emp_no = s.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986.
Select e.first_name, e.last_name, e.hire_date from employees e 
WHERE
e.hire_date between '1986-01-01' and '1986-12-31'
Order by e.hire_date

--List the manager of each department along with their department number, department name, employee number, last name, and first name.


select dm.dept_no,dm.emp_no, d.dept_name,e.first_name,e.last_name from dept_manager dm
inner join departments d 
on
dm.dept_no = d.dept_no
inner join
employees e on
dm.emp_no = e.emp_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.


Select e.emp_no, e.first_name, e.last_name, de.dept_no, d.dept_name from employees e
left join
dept_emp de on
e.emp_no = de.emp_no
left join
departments d
on
de.dept_no = d.dept_no


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

Select e.first_name, e.last_name, e.sex from employees e
WHERE e.first_name = 'Hercules' and e.last_name like 'B%'


--List each employee in the Sales department, including their employee number, last name, and first name.

Select e.emp_no,e.last_name,e.first_name, d.dept_name from employees e
inner join 
dept_emp de on
e.emp_no = de.emp_no
inner join 
departments d 
on 
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

Select e.emp_no,e.last_name,e.first_name, d.dept_name from employees e
inner join 
dept_emp de on
e.emp_no = de.emp_no
inner join 
departments d 
on 
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development' 


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select e.last_name, count(*) as last_count from employees e
Group by e.last_name
order by last_count desc


