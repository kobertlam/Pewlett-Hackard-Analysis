------------------
-- Deliverable 1:
------------------
-- Step 1-7
-- Retrieve all the titles of current employees who were born between January 1, 1952 and December 31, 1955
SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	tit.title,
	tit.from_date,
	tit.to_date
INTO retirement_titles
FROM employees as emp
INNER JOIN titles as tit
ON (emp.emp_no = tit.emp_no)
WHERE emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp.emp_no;

-- Step 8-14
-- Remove the duplicates rows and keep only the most recent title of each employee
SELECT DISTINCT ON (emp_no) emp.emp_no,
	emp.first_name,
	emp.last_name,
	tit.title
INTO unique_titles
FROM employees as emp
INNER JOIN titles as tit
ON (emp.emp_no = tit.emp_no)
WHERE emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp.emp_no, tit.to_date DESC;

-- Step 15-20
-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT  count(1), title
INTO retiring_titles
FROM UNIQUE_TITLES
GROUP BY title
ORDER BY count(1) DESC;

------------------
-- Deliverable 2:
------------------
-- create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (emp_no) emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	de.from_date,
	de.to_date,
	tit.title
-- INTO mentorship_eligibilty
FROM employees as emp
INNER JOIN dept_emp as de
ON (emp.emp_no = de.emp_no)
INNER JOIN titles as tit
ON (emp.emp_no = tit.emp_no)
WHERE de.to_date = '9999-01-01'
AND emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp.emp_no;
