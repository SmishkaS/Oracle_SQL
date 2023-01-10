-- 1. Получите список всех сотрудников, у которых длина имени больше 10 букв.

SELECT *
FROM employees
WHERE LENGTH(first_name) > 10;


-- 2. Получите список всех сотрудников, зарплата которых кратна 1000.

SELECT *
FROM employees
WHERE MOD(salary, 1000) = 0;


-- 3. Выведите телефонный номер и первое 3х значное число телефонного номера сотрудника,
-- если его номер представлен в формате ХХХ.ХХХ.ХХХХ .

SELECT phone_number, SUBSTR(phone_number,1,3)
FROM employees
WHERE phone_number LIKE'___.___.____';


-- 4. Получите список всех сотрудников, у которых последняя буква в имени равна 'm' и длина имени больше 5ти.

SELECT *
FROM employees
WHERE SUBSTR(first_name, -1) = 'm'
--WHERE first_name like '%m'
AND LENGTH(first_name) > 5;


-- 5. Выведите дату следующей пятницы.

SELECT NEXT_DAY(SYSDATE, 'Пятница') next_friday
FROM dual;


-- 6. Получите список всех сотрудников, которые работают в компании больше 12 лет и 6ти месяцев (150 месяцев).

SELECT *
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) > 150;


-- 7. Выведите телефонный номер, заменив в значении PHONE_NUMBER все '.' на '-'.

SELECT REPLACE(phone_number, '.', '-') new_phone
FROM employees;


-- 8. Выведите имя, email, job_id для всех работников в формате: STEVEN sking Ad_Pres

SELECT
UPPER(first_name),
LOWER(email),
INITCAP(job_id)
FROM employees;

-- 9. Выведите информацию о имени работника и его з/п, не используя символ || , в таком виде: Steven24000

SELECT CONCAT(first_name, salary) 
FROM employees;


-- 10.Выведите информацию о дате приёма сотрудника на работу,
-- округлённой дате приёма на работу до месяца и первом дне года приёма на работу.

SELECT hire_date,
ROUND(hire_date, 'mm'),
TRUNC(hire_date, 'yyyy')
FROM employees;


-- 11.Выведите информацию о имени и фамилии всех работников.
-- Имя должно состоять из 10 символов
-- и если длина имени меньше 10, то дополняйте до 10 символов знаком $.
-- Фамилия должна состоять из 15 символов
-- и если длина фамилии меньше 15, то перед фамилией ставьте столько знаков ! сколько необходимо.

SELECT
RPAD(first_name, 10, '$'),
LPAD(last_name, 15, '!')
FROM employees;


-- 12.Выведите имя сотрудника и позицию второй буквы ‘a’ в его имени.

SELECT first_name
INSTR(first_name, 'a', 1, 2)
FROM employees;


-- 13.Выведите на экран текст '!!!HELLO!! MY FRIEND!!!!!!!!' и тот же текст, но
-- без символа восклицательный знак в начале и конце текста.

SELECT '!!!HELLO!! MY FRIEND!!!!!!!!',
TRIM('!' FROM '!!!HELLO!! MY FRIEND!!!!!!!!')
FROM DUAL;


-- 14.Выведите информацию о:
-- - з/п работника,
-- - з/п умноженной на коэффициент 3.1415 ,
-- - округлённый до целого значения вариант увеличенной з/п-ты,
-- - целое количество тысяч из увеличенной з/п.

SELECT salary, salary*3.1415,
ROUND(salary*3.1415, 0),
TRUNC(salary*3.1415, -3)/1000
FROM employees;


-- 15.Выведите информацию о:
-- - дате приёма сотрудника на работу,
-- - дате, которая была через пол года, после принятия сотрудника на работу,
-- - дате последнего дня в месяце принятия сотрудника на работу

SELECT hire_date,
ADD_MONTHS(hire_date, 6),
LAST_DAY(hire_date)
FROM employees;
