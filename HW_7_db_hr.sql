-- 1. Выведите всю информацию о сотрудниках, с самым длинным именем.

SELECT * FROM employees WHERE LENGTH(first_name) IN
(SELECT MAX(LENGTH(first_name))FROM employees);


-- 2. Выведите всю информацию о сотрудниках, с зарплатой большей средней зарплаты всех сотрудников.

SELECT * FROM employees WHERE salary >
(SELECT AVG(salary) FROM employees);


-- 3. Получить город/города, где сотрудники в сумме зарабатывают меньше всего.

SELECT city, SUM(salary) FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
JOIN locations l ON (d.location_id = l.location_id)
GROUP BY city
HAVING SUM(salary) =
    (SELECT MIN(SUM(salary)) FROM employees e
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (d.location_id = l.location_id)
    GROUP BY city);


-- 4. Выведите всю информацию о сотрудниках, у которых менеджер получает зарплату больше 15000.

SELECT * FROM employees WHERE manager_id IN
(SELECT employee_id FROM employees WHERE salary > 15000);


-- 5. Выведите всю информацию о департаментах, в которых нет ни одного сотрудника.

SELECT * FROM departments WHERE department_id NOT IN
(SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);


-- 6. Выведите всю информацию о сотрудниках, которые не являются менеджерами.

SELECT * FROM employees WHERE employee_id NOT IN
(SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);


-- 7. Выведите всю информацию о менеджерах, которые имеют в подчинении больше 6ти сотрудников.

SELECT * FROM employees e WHERE
(SELECT COUNT(*) FROM employees WHERE manager_id = e.employee_id) > 6;


-- 8. Выведите всю информацию о сотрудниках, которые работают в департаменте с названием IT.

SELECT * FROM employees WHERE department_id =
(SELECT department_id FROM departments WHERE department_name = 'IT');


-- 9. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2000ом году,
-- но при это сами работники устроились на работу до 2000 года.

SELECT * FROM employees WHERE manager_id IN
(SELECT employee_id FROM employees WHERE TO_CHAR(hire_date, 'YYYY') = '2000')
AND hire_date < TO_DATE ('01012000', 'DDMMYYYY');


-- 10. Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в январе любого года,
-- и длина job_title этих сотрудников больше 15ти символов.

SELECT * FROM employees WHERE manager_id IN
(SELECT employee_id FROM employees WHERE TO_CHAR(hire_date, 'YYYY') = '2000')
AND hire_date < TO_DATE ('01012000', 'DDMMYYYY');
