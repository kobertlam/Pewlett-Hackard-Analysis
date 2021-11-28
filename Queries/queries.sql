-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and managers tables
SELECT dept.dept_name,
     mgr.emp_no,
     mgr.from_date,
     mgr.to_date
FROM departments as dept
INNER JOIN managers as mgr
ON dept.dept_no = mgr.dept_no;

SELECT departments.dept_name,
     managers.emp_no,
	 employees.first_name || ' ' || employees.last_name "Full Name",
     managers.from_date,
     managers.to_date
FROM departments
INNER JOIN managers
ON (departments.dept_no = managers.dept_no)
INNER JOIN employees
ON (employees.emp_no = managers.emp_no);

-- Joining retirement_info and dept_emp tables
-- filter to select current employees only
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
--INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
--INTO retirement_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- List 1:
-- Employee Information: A list of employees containing their unique employee number, their last name, first name, gender, and salary
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
	s.salary,
	de.to_date
-- INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List 2: 
-- Management: A list of managers for each department,
-- including the department number, name, and the manager's employee number,
-- last name, first name, and the starting and ending employment dates
SELECT  mgr.dept_no,
        d.dept_name,
        mgr.emp_no,
        ce.last_name,
        ce.first_name,
        mgr.from_date,
        mgr.to_date
--INTO manager_info
FROM managers AS mgr
    INNER JOIN departments AS d
        ON (mgr.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (mgr.emp_no = ce.emp_no);

-- List 3:
-- Department Retirees: An updated current_emp list that includes everything
-- it currently has, but also the employee's departments
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Tailored Lists
-- List from retirement_info table contains only employees in Sales department
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments as dept
ON (de.dept_no = dept.dept_no)
WHERE dept.dept_name = 'Sales';

select * from departments;


-- List from retirement_info table contains only employees in Sales department or Development department
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments as dept
ON (de.dept_no = dept.dept_no)
WHERE dept.dept_name IN ('Sales','Development');