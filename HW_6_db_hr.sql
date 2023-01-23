-- 1.Выведите информацию о регионах и колличестве сотрудников в каждом регионе

--v1
SElECT r.region_name, count(*)
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (d.location_id = l.location_id)
JOIN countries c ON (l.country_id = c.country_id)
JOIN regions r ON (c.region_id = r.region_id)
GROUP BY region_name;

--v2
SElECT region_name, count(*)
FROM employees e
FULL OUTER JOIN departments d ON (e.department_id = d.department_id)
FULL OUTER JOIN locations l ON (d.location_id = l.location_id)
FULL OUTER JOIN countries c ON (l.country_id = c.country_id)
FULL OUTER JOIN regions r ON (c.region_id = r.region_id)
WHERE first_name IS NOT NULL AND region_name IS NOT NULL
GROUP BY region_name;

--v3 oracle join syntax
SElECT r.region_name, count(*)
FROM employees e, departments d, locations l, countries c, regions r
WHERE (
e.department_id = d.department_id AND
d.location_id = l.location_id AND
l.country_id = c.country_id AND
c.region_id = r.region_id
)
GROUP BY region_name;


-- 2.Выведите информацию о каждом сотруднике (имя, фамилия, название департамента, job_id, адресс(страна, регион)

SElECT e.first_name, e.last_name, d.department_name, e.job_id, l.street_address, c.country_name, r.region_name
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (d.location_id = l.location_id)
JOIN countries c ON (l.country_id = c.country_id)
JOIN regions r ON (c.region_id = r.region_id);


-- 3.Выведите инормацию о имени менджеров которые имеют в подчиении больше 6 сотрудников

SELECT manager.first_name manager_name, COUNT(*)
FROM employees
JOIN employees manager ON (employees.manager_id = manager.employee_id)
GROUP BY manager.first_name
HAVING COUNT (*) > 6;


-- 4.Показать все департаменты в которых работают больше 30ти сотрудников

--v1
SElECT d.department_name, count(*)
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
GROUP BY d.department_name
HAVING count(*) > 30;

--v2
SElECT d.department_name, count(*)
FROM employees
JOIN departments d USING (department_id)
GROUP BY d.department_name
HAVING count(*) > 30;


-- 5.Показать всех сотрудников которые ни кому не подчиняются

--v1
SELECT e.first_name, d.department_name
FROM employees e
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id)
WHERE d.department_name IS NULL;

--v2 oracle join syntax
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id (+)
AND department_name IS NULL;


-- 6.Получить список сотрудников менеджеры которых устроились на работу в 2000ом году
-- но при это сами эти работники устроились на работу до 2000 года

SELECT emp.*
FROM employees emp
JOIN employees manager ON (emp.manager_id = manager.employee_id)
WHERE TO_CHAR(manager.hire_date, 'YYYY') = '2000'
AND emp.hire_date < TO_DATE('01-JAN-2000', 'DD-MON-YYYY');


-- 7.Выведите название страны и название региона используя natural join

SELECT country_name, region_name
FROM countries
NATURAL JOIN regions;


-- 8.Выведите имена, фамилии, зарплаты сотрудников
-- которые получают меньше чем минимальная зарплата по их специальности +1000.

SELECT first_name, last_name, salary, min_salary+1000
FROM employees e
JOIN jobs j ON (e.job_id = j.job_id AND salary < min_salary + 1000);


--9.Выведите уникальные имена фамилии и названия стран сотрудников которые работают,
-- а так же имена и фамилии сотрудников о странах которых нет информации.

SELECT DISTINCT first_name, last_name, country_name
FROM employees e
FULL OUTER JOIN departments d ON (e.department_id = d.department_id)
FULL OUTER JOIN locations l ON (d.location_id = l.location_id)
FULL OUTER JOIN countries c ON (l.country_id = c.country_id);

-- 10.
