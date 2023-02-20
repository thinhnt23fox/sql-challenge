--------------------------- DATA ANALYSIS ---------------------------

-- Question 1:	
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salarych
	FROM company.employees AS e
	INNER JOIN company.salaries AS s
	ON e.emp_no=s.emp_no;

-- Question 2:	
SELECT e.first_name, e.last_name, e.hire_date
	FROM company.employees AS e
	WHERE to_char(e.hire_date, 'YYYY')='1986';

-- Question 3:
SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
	FROM company.employees AS e
	INNER JOIN company.dept_manager AS dm ON e.emp_no = dm.emp_no
	INNER JOIN company.departments AS d ON dm.dept_no = d.dept_no;

-- Question 4:
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
	FROM company.employees AS e
	INNER JOIN company.dept_emp AS de ON e.emp_no = de.emp_no
	INNER JOIN company.departments AS d ON de.dept_no = d.dept_no;

-- Question 5:
SELECT first_name, last_name, sex
	FROM company.employees
	WHERE first_name='Hercules' AND last_name like 'B%';

-- Question 6:
-- 6.1. Solution 01 - create views , then Union these views
CREATE VIEW company.Sales_Department_Employees_VIEW AS
	SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
		FROM company.employees AS e
		INNER JOIN company.dept_emp AS de ON e.emp_no = de.emp_no
		INNER JOIN company.departments AS d ON de.dept_no = d.dept_no;

CREATE VIEW company.Sales_Department_Managers_VIEW AS 
	SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
	FROM company.employees AS e
	INNER JOIN company.dept_manager AS dm ON e.emp_no = dm.emp_no
	INNER JOIN company.departments AS d ON dm.dept_no = d.dept_no;

SELECT e.emp_no, e.last_name, e.first_name
	FROM company.Sales_Department_Employees_VIEW AS e
	UNION 
SELECT m.emp_no, m.last_name, m.first_name 
	FROM company.Sales_Department_Managers_VIEW AS m;
	
-- 6.2. Solution 02 - directly union two searching results
SELECT e.emp_no, e.last_name, e.first_name
		FROM company.employees AS e
		INNER JOIN company.dept_emp AS de ON e.emp_no = de.emp_no
		INNER JOIN company.departments AS d ON de.dept_no = d.dept_no
	UNION
SELECT e.emp_no, e.last_name, e.first_name
	FROM company.employees AS e
	INNER JOIN company.dept_manager AS dm ON e.emp_no = dm.emp_no
	INNER JOIN company.departments AS d ON dm.dept_no = d.dept_no;

-- Question 7:
SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
	FROM company.departments AS d
	INNER JOIN company.dept_emp AS de ON d.dept_no = de.dept_no
	INNER JOIN company.employees AS e ON de.emp_no = e.emp_no
	WHERE d.dept_name='Sales' OR d.dept_name='Development';

-- Question 8:
SELECT last_name, COUNT(last_name) as num
	FROM company.employees GROUP BY last_name ORDER BY num DESC;