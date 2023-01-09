-- 1. Выведите всю информацию о регионах.

select * from regions;


-- 2. Выведите информацию о имени, id департамента, зарплате и фамилии 
-- для всех работников.

select 
first_name, 
department_id, 
salary, 
last_name 
from employees;


/* 3. Выведите информацию о id работника, электронной почте и дату, 
которая была за неделю до трудоустройства для всех работников. 
Столбец, который будет содержать дату назовите One week before hire
date. */

select 
employee_id,
email,
hire_date-7 "One week before hiredate" 
from employees;


-- 4. Выведите информацию о работниках с их позициями в формате: 
-- Donald(SH_CLERK). Назовите столбец our_employees.

select first_name||'(' || job_id || ')' our_employees from employees;


-- 5. Выведите список уникальных имён среди работников.

select distinct first_name from employees;


/* 6. Выведите следующую информацию из таблицы jobs: 
? job_title, 
? выражение в формате: «min = 20080, max = 40000»
, где 20080 – это минимальная з/п, а 40000 – максимальная.
Назовите этот столбец info.
? максимальную з/п и назовите столбец max,
? новую з/п, которая будет называться new_salary и вычисляться по 
формуле: max_salary*2-2000. */

select job_title, 'min = '||min_salary||', max = '||max_salary info, 
max_salary max, max_salary*2-2000 new_salary from jobs;


-- 7. Выведите на экран предложение «Peter's dog is very clever», используя 
-- одну из двух техник работы с одинарными кавычками.
select q'<Peter's dog is very clever>' from dual; 


-- 8. Выведите на экран предложение «Peter's dog is very clever», используя, 
-- отличную от предыдущего примера, технику работы с одинарными 
-- кавычками.
select 'Peter''s dog is very clever' from dual;


-- 9. Выведите на экран количество минут в одном веке (1 год = 365.25 
-- дней).
select 100*365.25*24*60 from dual;