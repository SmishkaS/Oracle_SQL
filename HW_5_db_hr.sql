-- 1. Получить репорт по department_id с минимальной и максимальной зарплатой,
-- с самой ранней и самой поздней датой прихода на работу и с количеством сотрудников.
-- Сортировать по количеству сотрудников (по убыванию).

SELECT department_id,
MIN(salary) min_salary,
MAX(salary) max_salary,
MIN(hire_date) min_hire_date,
MAX(hire_date) max_hire_date,
COUNT(*) count_emploees
FROM employees
GROUP BY department_id
ORDER BY COUNT(*) DESC;


-- 2. Выведите информацию о первой букве имени сотрудника и количество имён, которые начинаются с этой буквы.
-- Выводить строки для букв, где количество имён, начинающихся с неё больше 1.
-- Сортировать по количеству.

SELECT SUBSTR(first_name, 1, 1) first_char, COUNT(*) count_emploees
FROM employees
GROUP BY SUBSTR(first_name, 1, 1)
HAVING COUNT(*) > 1
ORDER BY count DESC;


-- 3. Выведите id департамента, з/п и количество сотрудников, которые работают в одном и том же департаменте
-- и получают одинаковую зарплату.

SELECT department_id, salary, COUNT(*) count_emploees
FROM employees
GROUP BY department_id, salary;


-- 4. Выведите день недели и количество сотрудников, которых приняли на работу в этот день.

SELECT TO_CHAR(hire_date, 'Day') day, COUNT(*) count_emploees
FROM employees
GROUP BY TO_CHAR(hire_date, 'Day');


-- 5. Выведите id департаментов, в которых работает больше 30 сотрудников и сумма их з/п-т больше 300тыс.

SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 30 and SUM(salary) > 300000


-- 6. Из таблицы countries вывести все region_id, для которых сумма всех букв их стран больше 50ти.

SELECT region_id
FROM countries
GROUP BY region_id
HAVING SUM(LENGTH(country_name)) > 50;


-- 7. Выведите информацию о job_id и округленную среднюю зарплату работников для каждого job_id.

SELECT job_id, ROUND(AVG(salary))
FROM employees
GROUP BY job_id;


-- 8. Получить список id департаментов, в которых работают сотрудники нескольких (>1) job_id.

SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(DISTINCT job_id) > 1;


-- 9. Выведите информацию о department, job_id, максимальную и минимальную з/п для всех сочетаний
-- department_id - job_id, где средняя з/п больше 10000.

SELECT department_id, job_id, MIN(salary) min_salary, MAX(salary) max_salary
FROM employees
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000;


-- 10.Получить список manager_id, у которых средняя зарплата всех его подчиненных, не имеющих комиссионные,
-- находится в промежутке от 6000 до 9000.

SELECT manager_id
FROM employees
WHERE commission_pct IS NULL
GROUP BY manager_id
HAVING AVG(salary) BETWEEN 6000 AND 9000;


-- 11.Выведите округлённую до тысяч (не тысячных) максимальную зарплату среди всех средних зарплат по департаментам.
SELECT ROUND(MAX(AVG(salary)), -3) round_salary
FROM employees
GROUP BY department_id;
