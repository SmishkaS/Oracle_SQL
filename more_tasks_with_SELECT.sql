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
