-- 1. Используя функции, получите список всех сотрудников у которых в имени есть буква 'b' (без учета регистра).

-- v1
SELECT *
FROM employees
WHERE
LOWER(first_name) LIKE '%b%';

-- v2
SELECT *
FROM employees
WHERE INSTR(LOWER(first_name), 'b') > 0;

-- v3
SELECT *
FROM employees
WHERE first_name LIKE '%b%'
UNION
SELECT *
FROM employees
WHERE first_name LIKE '%B%';


-- 2. Используя функции, получите список всех сотрудников у которых в имени содержатся минимум 2 буквы 'a'.

-- v1
SELECT *
FROM employees
WHERE
LOWER(first_name) LIKE '%a%a%';

-- v2
SELECT *
FROM employees
WHERE INSTR(LOWER(first_name), 'a', 1, 2) > 0;


-- 3. Получите первое слово из имени департамента, для тех департаментов,
-- у которых название состоит больше, чем из одного слова.

SELECT SUBSTR (department_name, 1, INSTR(department_name, ' ')-1) as first_word
FROM departments
WHERE INSTR(department_name, ' ') > 0;


-- 4. Получите имена сотрудников без первой и последней буквы в имени.

SELECT first_name, SUBSTR(first_name, 2, LENGTH(first_name) - 2) as new_name
FROM employees;


-- 5. Получите список всех сотрудников, у которых в значении job_id после знака '_' как минимум 3 символа,
-- но при этом это значение после '_' не равно 'CLERK'.

SELECT *
FROM employees
WHERE
LENGTH(SUBSTR(job_id, INSTR(job_id, '_') + 1)) > 3
AND SUBSTR(job_id, INSTR(job_id, '_') + 1) != 'CLERK';


-- 6. Получите список всех сотрудников, которые пришли на работу в первый день любого месяца.

SELECT *
FROM employees
WHERE TO_CHAR(hire_date, 'DD') = '01';


-- 7. Получите список всех сотрудников, которые пришли на работу в 1998ом году.

SELECT *
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '1998';


-- 8. Покажите завтрашнюю дату в формате: Tomorrow is Second day of January.

SELECT SYSDATE, TO_CHAR(SYSDATE + 1, 'fm"Tomorrow is "Ddspth "day of "Month"') as tomorrow_date
FROM dual;


-- 9. Выведите имя сотрудника и дату его прихода на работу в формате: 21st of June, 2007.

SELECT first_name, TO_CHAR(hire_date, 'fmddth "of" Month, YYYY') as hire_date
FROM employees;


-- 10.Получите список работников с увеличенными зарплатами на 20%. Зарплату показать в формате: $28,800.00.

SELECT first_name, salary, salary * 0.20, TO_CHAR(salary + salary * 0.20, '$999,999.99') as new_salary
FROM employees;


-- 11.Выведите актуальную дату (нынешнюю), + секунда, + минута, + час, + день, + месяц, + год.
-- (Всё это по отдельности прибавляется к актуальной дате).

SELECT
TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS') as now,
TO_CHAR(SYSDATE + 1 / (24 * 60 * 60), 'DD-MON-YY HH:MI:SS') as plus_sec_v1,
REPLACE(TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS'), TO_CHAR(SYSDATE, 'SS'), TO_CHAR(SYSDATE, 'SS')+1) as plus_sec_v2,
TO_CHAR(SYSDATE + 1 / 24 / 60, 'DD-MON-YY HH:MI:SS') as plus_minute_v1,
REPLACE(TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS'), TO_CHAR(SYSDATE, 'MI'), TO_CHAR(SYSDATE, 'MI')+1) as plus_minute_v2,
TO_CHAR(SYSDATE + 1 / 24 , 'DD-MON-YY HH:MI:SS') as plus_hour_v1,
REPLACE(TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS'), TO_CHAR(SYSDATE, 'HH'), TO_CHAR(SYSDATE, 'HH')+1) as plus_hour_v2,
TO_CHAR(SYSDATE+1, 'DD-MON-YY HH:MI:SS') as plus_day_v1,
REPLACE(TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS'), TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'DD')+1) as plus_day_v2,
ADD_MONTHS(SYSDATE, 1) as plus_month,
ADD_MONTHS(SYSDATE, 12) as plus_year_v1,
REPLACE(TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YY')+1) as plus_year_v2
FROM dual;


--12.Выведите имя сотрудника, его з/п и новую з/п, которая равна старой плюс это значение из текста «$12,345.55».

SELECT first_name, salary, salary + TO_NUMBER('$12,345.55', '$99,999.99') as new_salary
FROM employees;


-- 13.Выведите имя сотрудника, дату его трудоустройства, а также количество месяцев
-- между датой его трудоустройства и датой, которую необходимо получить из текста «SEP, 18:45:00 18 2009».

SELECT first_name, hire_date,
ROUND(MONTHS_BETWEEN(TO_DATE('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY'), hire_date), 0) as months
FROM employees;


--14.Выведите имя сотрудника, его з/п, а также полную з/п (salary + commission_pct(%)) в формате: $24,000.00.

SELECT first_name, salary,
TO_CHAR(salary + salary * NVL(commission_pct, 0), '$999,999.99') as full_salary
FROM employees;


-- 15.Выведите имя сотрудника, его фамилию, а также
-- выражение «different length», если длина имени не равна длине фамилии или
-- выражение «same length», если длина имени равна длине фамилии. Не используйте conditional functions.

SELECT first_name, last_name,
NVL2(NULLIF(LENGTH(first_name), LENGTH(last_name)), 'different length', 'same length')
FROM employees;


-- 16.Выведите имя сотрудника, его комиссионные, а также информацию о наличии бонусов к зарплате
-- – есть ли у него комиссионные (Yes/No).

SELECT first_name, commission_pct,
NVL2(commission_pct, 'Yes', 'No')
FROM employees;


-- 17.Выведите имя сотрудника и значение которое его будет характеризовать:
-- значение комиссионных, если присутствует, если нет, то id его менеджера, если и оно отсутствует, то его з/п.

SELECT first_name, commission_pct, manager_id, salary,
COALESCE(commission_pct, manager_id, salary) as info
FROM employees;


-- 18.Выведите имя сотрудника, его з/п, а также уровень зарплаты каждого сотрудника:
-- Меньше 5000 считается Low level, Больше или равно 5000 и меньше 10000 считается Normal level,
-- Больше или равно 10000 считается High level.

SELECT first_name, salary,
CASE
WHEN salary < 5000 THEN 'Low level'
WHEN salary >= 5000 AND salary < 10000 THEN 'Normal level'
WHEN salary >= 10000 THEN 'High level'
END as level_salary
FROM employees;


-- 19.Для каждой страны показать регион, в котором она находится: 1-Europe, 2-America, 3-Asia, 4-Africa.
-- Используйте DECODE.

SELECT country_name,
DECODE(region_id, 1, 'Europe', 2, 'America', 3, 'Asia', 4, 'Africa') as region
FROM countries;


-- 20.Для каждой страны показать регион, в котором она находится: 1-Europe, 2-America, 3-Asia, 4-Africa.
-- Используйте CASE.

SELECT country_name,
CASE region_id
WHEN 1 THEN 'Europe'
WHEN 2 THEN 'America'
WHEN 3 THEN 'Asia'
WHEN 4 THEN 'Africa'
END as region
FROM countries;


-- 21.Выведите имя сотрудника, его з/п, а также уровень того, насколько у сотрудника хорошие условия :
-- - BAD: з/п меньше 10000 и отсутствие комиссионных;
-- - NORMAL: з/п между 10000 и 15000 или, если присутствуют комиссионные;
-- - GOOD: з/п больше или равна 15000

SELECT first_name, salary,
CASE
WHEN salary < 10000 AND commission_pct IS NULL THEN 'BAD'
WHEN salary >= 10000 AND salary < 150000 OR commission_pct IS NOT NULL THEN 'NORMAL'
WHEN salary >= 15000 THEN 'GOOD'
END as level_salary
FROM employees;
