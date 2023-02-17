DESC employees;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT department_id, department_name
FROM departments;

SELECT manager_id, location_id
FROM departments;

--���������
SELECT last_name, salary, salary+100
FROM employees;

SELECT last_name, salary, 12*salary+100
FROM employees;

SELECT last_name, salary, 12*(salary+100), 12*salary+100
FROM employees;

--�ΰ��� �������
SELECT last_name, job_id, salary, commission_pct
FROM employees;

SELECT last_name, 12*salary*commission_pct, commission_pct
FROM employees;

SELECT commission_pct+100
FROM employees;

--Columm Alias(��Ī)
SELECT last_name AS name, job_id JOB_ID, salary*12 "Annual_Sal"
FROM employees;

--���� ������(||)
SELECT first_name, last_name, first_name || ' ' ||last_name As full_name
FROM employees;

SELECT employee_id || '-' || last_name || '''s Salary : ' || salary
FROM employees;

--Q�����ڷ� ������ ����
SELECT employee_id || '-' || last_name || q'['s Salary :]' || salary
FROM employees;

--DISTINCT ������� ������� �ߺ� ����
SELECT department_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;

SELECT DISTINCT department_id, job_id
FROM employees;


--WHERE �⺻���� ���

--department_id�� 60�� ���� �߿��� ��ȸ ���ּ���
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 60;

SELECT last_name, job_id, department_id
FROM employees;

SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'King';

SELECT last_name, hire_date
FROM employees;

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '1999/09/21';

SELECT employee_id, salary, department_id
FROM employees
WHERE department_id <> 90;

SELECT last_name, salary
FROM employees
WHERE salary <= 5000;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '00/01/01';

SELECT last_name, hire_date
FROM employees
WHERE last_name < 'King';


--Between �������� ���
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 6000 AND 9000;

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 9000 AND 6000;


--IN �������� ���

SELECT employee_id, last_name, salary, department_id
FROM employees
--java : department_id = 50 || department_id = 60 || department_id = 80
WHERE department_id IN (50,60,80);

SELECT employee_id, last_name, salary, department_id
FROM employees
--java : job_id = IT_PROG || job_id = SA_REP
WHERE job_id IN ('IT_PROG', 'SA_REP');


--LIKE ������ (������ Ȱ���ؼ� ���ǿ� �´� �����͸� ��ȸ)
SELECT employee_id, last_name, job_id, department_id
FROM employees
--A�� �����ϴ� �ܾ�
WHERE Last_name LIKE 'A%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--����� a�� ���� �ܾ�
WHERE Last_name LIKE '%a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--last_name���� ù ���ڴ� �ƹ��ų� �Ѱ� �����ϰ� a�� �����ϴ� �ܾ�(�ι�° ���ڰ� a�� �ܾ�)
WHERE Last_name LIKE '_a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--last_name���� a�տ� �ƹ��ų� �� ���ڰ� �����ϰ� a�� ����°�� ���� �ܾ�
WHERE Last_name LIKE '__a%';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--Last_name ���� �����ڷ� �� �ܾ�
WHERE Last_name LIKE '___';

SELECT employee_id, last_name, job_id, department_id
FROM employees
--last_name���� s�� ������ �ܾ�
WHERE Last_name LIKE '%s';


--ESCAPE���� ���
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id LIKE '%SA\_%' ESCAPE '\';


--NULL�� �˻�
SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id = null;

SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id IS NULL;


--�� �������� ���
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
OR salary > 8000;

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
AND salary > 8000;


--NOT ������
SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id IS NOT NULL;

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name NOT LIKE '%a%';

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 6000 AND 9000;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE department_id NOT IN (50,60,80);


--�������� �켱 ����
select employee_id, last_name, job_id, salary
from employees
where job_id like 'IT%'
or job_id like '%CLERK%'
and salary < 5000;

select employee_id, last_name, job_id, salary
from employees
where (job_id like 'IT%'
or job_id like '%CLERK%')
and salary < 5000;


--ORDER BY ������ ����
--1�� �� �������� ����
SELECT *
FROM employees
ORDER BY last_name;

--�Ի����� ���� ������� ����
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY hire_date;

--�޿��� ���� ������� ���
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY salary DESC;

--2�� �̻��� �� ���� ����
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY department_id, salary DESC;

--ǥ���� �Ǵ� ��Ī ���� ����
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY department_id, salary*12 DESC;

SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY department_id, annsal DESC;


--��ġ�� (position Number)�� ���� ���� ���
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY 5,4 DESC;

SELECT *
FROM employees
ORDER BY 6;

--���̺� ���� Ȯ��
DESC employees;


--UNION ���� (������)
SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;

SELECT employee_id FROM employees
UNION ALL
SELECT employee_id FROM job_history;

--MINUS (������)
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;

SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;

--INTERSECT (������)
SELECT employee_id FROM employees
INTERSECT
SELECT employee_id FROM job_history;


--UNION �������
--SELECT employee_id, department_id FROM employees
--UNION  ���� ������ �ٸ�. ������ �߰��ϰų� ������ �ٿ��� ��
--SELECT employee_id FROM job_history;

--SELECT employee_id, department_id FROM employees
--UNION  �� �Ʒ� ���� �°� ������ Ÿ���� ���ƾ���
--SELECT employee_id, job_id FROM job_history;

--SELECT employee_id, last_name FROM employees
--ORDER BY �����ϰ� ���ϰ� �� �ٽ� �����Ѵ�? ��ȿ����! �� ������ ����
--UNION
--SELECT employee_idm job_id FROM job_history;

SELECT employee_id, last_name FROM employees
UNION
SELECT employee_id, job_id FROM job_history
ORDER BY employee_id;



--ġȯ����
set verify on
show verify
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no;
set verify off

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = UPPER ('&job_title');

SELECT employee_id, last_name, job_id, &column_name
FROM employees
ORDER BY &column_name;

define column_name;
undefine column_name;
