-- 1. ѕолучите список всех сотрудников с именем David.

select *
from employees
where first_name = 'David';


-- 2. ѕолучите список всех сотрудников, у которых job_id равен FI_ACCOUNT.

select *
from employees
where job_id = 'FI_ACCOUNT';


-- 3. ¬ыведите информацию о имени, фамилии, з/п и номере департамента 
-- дл€ сотрудников из 50го департамента с зарплатой, большей 4000.

select first_name, last_name, salary, department_id
from employees
where department_id = 50 
and salary > 4000;


-- 4. ѕолучите список всех сотрудников, которые работают или в 20м, или в 30м департаменте.

select *
from employees
where department_id = 20 or department_id = 30;


-- 5. ѕолучите список всех сотрудников, у которых втора€ и последн€€ буква в имени равна 'a'.

select *
from employees
where first_name
LIKE '_a%a';


-- 6. ѕолучите список всех сотрудников из 50го и из 80го департамента, у которых есть бонус(комиссионные).
-- ќтсортируйте строки по email (возрастающий пор€док), использу€ его пор€дковый номер.

select *
from employees
where department_id = 50 or department_id = 80
and commission_pct is not NULL
ORDER BY 4;


-- 7. ѕолучите список всех сотрудников, у которых в имени содержатс€ минимум 2 буквы 'n'.

select *
from employees
where first_name
like '%n%n%';


-- 8. ѕолучить список всех сотрудников, у которых длина имени больше 4 букв.
-- ќтсортируйте строки по номеру департамента (убывающий пор€док) так, чтобы значени€ УnullФ были в самом конце.

select *
from employees
where first_name
LIKE '_____%'
order by department_id desc
NULLS LAST;


-- 9. ѕолучите список всех сотрудников, у которых зарплата находитс€ в промежутке от 3000 до 7000 (включительно),
-- нет бонуса (комиссионных) и job_id среди следующих вариантов: PU_CLERK, ST_MAN, ST_CLERK.

select *
from employees
where salary
BETWEEN 3000 AND 7000
and commission_pct is NULL
and job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');


-- 10.ѕолучите список всех сотрудников у которых в имени содержитс€ символ '%'.

select *
from employees
where first_name
like '%\%%'
ESCAPE '\';


-- 11.¬ыведите информацию о job_id, имене и з/п дл€ работников, рабочий id которых больше или равен 120
-- и job_id не равен IT_PROG. ќтсортируйте строки по job_id (возрастающий пор€док) и именам (убывающий пор€док)

select job_id, first_name, salary
from employees
where employee_id >= 120
and job_id != 'IT_PROG'
ORDER BY job_id,first_name DESC;
