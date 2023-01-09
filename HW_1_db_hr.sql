-- 1. �������� ��� ���������� � ��������.

select * from regions;


-- 2. �������� ���������� � �����, id ������������, �������� � ������� 
-- ��� ���� ����������.

select 
first_name, 
department_id, 
salary, 
last_name 
from employees;


/* 3. �������� ���������� � id ���������, ����������� ����� � ����, 
������� ���� �� ������ �� ��������������� ��� ���� ����������. 
�������, ������� ����� ��������� ���� �������� One week before hire
date. */

select 
employee_id,
email,
hire_date-7 "One week before hiredate" 
from employees;


-- 4. �������� ���������� � ���������� � �� ��������� � �������: 
-- Donald(SH_CLERK). �������� ������� our_employees.

select first_name||'(' || job_id || ')' our_employees from employees;


-- 5. �������� ������ ���������� ��� ����� ����������.

select distinct first_name from employees;


/* 6. �������� ��������� ���������� �� ������� jobs: 
? job_title, 
? ��������� � �������: �min = 20080, max = 40000�
, ��� 20080 � ��� ����������� �/�, � 40000 � ������������.
�������� ���� ������� info.
? ������������ �/� � �������� ������� max,
? ����� �/�, ������� ����� ���������� new_salary � ����������� �� 
�������: max_salary*2-2000. */

select job_title, 'min = '||min_salary||', max = '||max_salary info, 
max_salary max, max_salary*2-2000 new_salary from jobs;


-- 7. �������� �� ����� ����������� �Peter's dog is very clever�, ��������� 
-- ���� �� ���� ������ ������ � ���������� ���������.
select q'<Peter's dog is very clever>' from dual; 


-- 8. �������� �� ����� ����������� �Peter's dog is very clever�, ���������, 
-- �������� �� ����������� �������, ������� ������ � ���������� 
-- ���������.
select 'Peter''s dog is very clever' from dual;


-- 9. �������� �� ����� ���������� ����� � ����� ���� (1 ��� = 365.25 
-- ����).
select 100*365.25*24*60 from dual;