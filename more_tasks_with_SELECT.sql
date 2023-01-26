-- Вывести информацию о имени работника, фамилии о его старых работах и времени когда он работал на этих работах
-- (испольуя natural join with using)
SELECT first_name, last_name, jh.job_id, start_date, end_date
FROM employees
JOIN job_history jh
USING (employee_id);

-- Вывести информацию о имени работника, фамилии о его старых работах и времени когда он работал на этих работах
-- (испольуя natural join with on)
SELECT first_name, last_name, jh.job_id, start_date, end_date
FROM employees e
JOIN job_history jh
ON (e.employee_id = jh.employee_id);

-- Из всех работников вы ведите имена менеджеро названия их подразделений.
SELECT first_name, department_name
FROM employees e JOIN departments d ON (e.employee_id = d.manager_id);

-- Вывести информацию о имени работника его старых job_id, название департамента и времени когда он работал.
SELECT first_name, jh.job_id, department_name, start_date, end_date
FROM employees e
JOIN job_history jh ON (e.employee_id = jh.employee_id)
JOIN departments d ON (jh.department_id = d.department_id);

-- Выведите назнавние департамента и минимальную и максимальную зарплату в нем
SELECT department_name, MIN(salary), MAX(salary)
from employees e
JOIN departments d ON (e.department_id = d.department_id)
GROUP BY department_name
ORDER BY department_name DESC;

-- Найдите работников чья зарплата равна максимальной зарплате для их job_id.
SELECT first_name, salary, max_salary
FROM employees e
JOIN jobs j ON (e.job_id = j.job_id AND salary = max_salary);

-- Найдите работников чья зарплата меньше половины от максимальной зарплаты для их job_id
SELECT first_name, salary, max_salary
FROM employees e
JOIN jobs j ON (e.job_id = j.job_id AND salary*2 < max_salary);

-- Найдите работников чья зарплата находится в интервале min_salary+2000 и max_salary-3000 для их job_id
SELECT first_name, salary, min_salary, max_salary
FROM employees e
JOIN jobs j ON (e.job_id = j.job_id AND salary BETWEEN min_salary+2000 AND max_salary-3000);

-- Выведите информацию об id и имени менеджера, а так же какие сотрудники ему подчиняются их id и имена.
SELECT e1.manager_id, e2.first_name manager_name, e1.employee_id, e1.first_name
FROM employees e1
JOIN employees e2 ON (e1.manager_id = e2.employee_id)
ORDER BY e1.manager_id;

-- Выведите информацию о колличестве сотрудников для каждого менеджера.
SELECT e2.first_name manager_name, count(*) count_employee
FROM employees e1
JOIN employees e2 ON (e1.manager_id = e2.employee_id)
GROUP BY e2.first_name
ORDER BY count_employee DESC;

-- Выведите департаменты где сейчас нет работников
SELECT d.department_name, d.department_id, e.first_name
FROM departments d
LEFT OUTER JOIN employees e ON (e.department_id = d.department_id)
WHERE e.first_name IS NULL;

-- Выведите название странн городов и улиц для всех локаций (включая отсутствующие)
SELECT c.country_name, l.city, l.street_address
FROM locations l
RIGHT OUTER JOIN countries c ON (l.country_id = c.country_id);

-- Выведите информацию о работниках у которых нет департамена и департаменты у которых нет работников.
SELECT first_name, last_name, salary, department_name
FROM employees e
FULL OUTER JOIN departments d ON (e.department_id = d.department_id);

-- Найдите сотрудников чья зарплата больше средней по всей компании
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Выведите Именаи и Фамилии менеждеров.
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);

-- Выведите название департамента и максимальную и минимальную зарплату по всем департаментам (используя SUBQUERY)
SELECT department_name, MIN(salary), MAX(salary)
FROM (SELECT salary, department_name FROM employees e
      JOIN departments d ON (e.department_id = d.department_id))
GROUP BY department_name;

-- Найдите сотрудников чья зарплата меньше чем 1/5 самой большой зарплаты в фирме.
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT MAX(salary)/5 FROM employees);

-- Найти работу с самой высокой средней зарплатой
SELECT job_title
FROM jobs j
JOIN employees e ON (j.job_id = e.job_id)
GROUP BY job_title
HAVING AVG(salary) = (SELECT MAX(AVG(salary)) FROM employees GROUP BY job_id);

-- Найдите информацию о сотрудниках у которых job_id такой же как job_id из таблицы JOBS где min_salary>8000
SELECT first_name, last_name, job_id, salary FROM employees
WHERE job_id IN (SELECT job_id FROM jobs WHERE min_salary > 8000);

-- Найдите информацию о сотрудниках чья зарплата больше зарплаты работников в департаменте с id = 100
SELECT first_name, last_name, job_id, salary FROM employees
WHERE salary > ANY(SELECT salary from employees WHERE department_id = 100);

-- Найдите имена департаментов где есть работники
--v1 JOIN
SELECT DISTINCT department_name
FROM employees e
JOIN departments d ON (e.department_id = d.department_id);

--V2 SUBQUERY
SELECT department_name
FROM departments
WHERE department_id IN (SELECT DISTINCT department_id FROM employees);

-- Найдите работников кто получает зарплату больше чем средняя зарплата по своему департаменту
SELECT e1.first_name, e1.last_name, e1.salary FROM employees e1
WHERE salary > (SELECT AVG(e2.salary) FROM employees e2
WHERE e2.department_id = e1.department_id);

-- Найдите работников которые работают в Великобритании
SELECT first_name, last_name FROM employees WHERE department_id IN
(SELECT department_id FROM departments WHERE location_id IN
(SELECT location_id FROM locations WHERE country_id =
(SELECT country_id FROM countries WHERE country_name = 'United Kingdom')));

-- Найдите среди менеджеров кто зарабатывает больше чем средняя зарплата по всей компании
SELECT first_name, last_name FROM employees WHERE job_id IN
(SELECT job_id FROM jobs WHERE UPPER(job_title) like '%MANAGER%') AND salary >
(SELECT AVG(salary) FROM employees);

--Найдите работников которые зарабатывают больше чем David
SELECT first_name, last_name FROM employees WHERE salary >
(SELECT MIN(salary) FROM employees where first_name = 'David');