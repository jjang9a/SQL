-- 1) ��� ���̺��� �����ȣ�� �̸��� ������ ����϶�.
SELECT employee_id, first_name, salary
FROM employees;

-- 2) ��� ���̺��� ��� �÷��� ���� ����϶�.
SELECT *
FROM employees;

-- 3) ��� ���̺��� �����ȣ�� �̸�, ������ ����ϴµ� �÷����� �ѱ۷� '��� ��ȣ', '��� �̸�'���� ����϶�.
SELECT employee_id AS �����ȣ, first_name AS ����̸�, salary
FROM employees;

-- 4) ��� ���̺��� �̸��� ������ �̿��Ͽ� ������ ���� ����϶�.
-- - ��¿��� ) ��� �̸��� Steven �̰� ������ 30000�� ���, 'Steven �� ������ 30000 �޷��Դϴ�.'
SELECT first_name, salary, first_name || '�� ������ ' || salary || '�޷��Դϴ�.' AS result
FROM employees;

-- 5) ��� ���̺��� ������ ����ϴµ� �ߺ��� �����͸� �����ϰ� ����϶�.
SELECT DISTINCT job_id
FROM employees;

-- 6) ��� ����� �̸��� ������ ����ϴµ� ������ ���� ������� ����϶�.
SELECT first_name, salary
FROM employees
ORDER BY salary;

-- 7) ��� ��� �� ������ 3000�� ������� �̸�, ����, ������ ����϶�.
SELECT first_name, salary, job_id
FROM employees
WHERE salary = 3000;

-- 8) �̸��� 'Steven'�� ����� �̸�, ����, ����, �Ի���, �μ���ȣ�� ����϶�.
SELECT first_name, salary, job_id, hire_date, department_id
FROM employees
WHERE first_name = 'Steven';

-- 9) ������ 3600�̻��� ������� �̸��� ������ ����϶�.
-- - ������ Ŀ�̼��� �ִ� ��� ���޿� ������ ���ϰ� 12�� ���ؼ� ���Ѵ�.
-- - ������ ���޿� Ŀ�̼��� ���ؼ� ���Ѵ�.
SELECT first_name, (salary + salary*commission_pct)*12 AS annsal
FROM employees
WHERE (salary + salary*commission_pct)*12 >= 3600;

-- 10) ������ 12000������ ������� �̸���, ����, ����, �μ���ȣ�� ����϶�.
SELECT first_name, salary, job_id, department_id
FROM employees
WHERE salary <= 12000;

-- 11) ������ 'SA_MAN'�� �ƴ� ������� �̸��� �μ���ȣ, ������ ����϶�.
SELECT last_name, department_id, job_id
FROM employees
WHERE job_id != 'SA_MAN';

-- 12) ������ 1000���� 3000������ ������� �̸��� ������ ����϶�.
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 1000 AND 3000;

-- 13) ������ 1000���� 3000������ �ƴ� ������� �̸��� ������ ����϶�.
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1000 AND 3000;

-- 14) 2006�⵵�� �Ի��� ������� �̸��� �Ի����� ����϶�.
SELECT last_name, hire_date
FROM employees
WHERE SUBSTR(hire_date, 1, 2) = 06;

-- 15) �̸��� ù ���ڰ� S�� �����ϴ� ������� �̸��� ������ ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name LIKE 'S%';

-- 16) �̸��� �� ���ڰ� T�� ������ ������� �̸��� ������ ����϶�.
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '%T';

-- 17) �̸��� �ι�° ö�ڰ� M �� ����� �̸��� ������ ����϶�.
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '_M%';

-- 18) �̸��� A�� �����ϰ� �ִ� ������� �̸��� ����϶�.
SELECT first_name, salary
FROM employees
WHERE UPPER(first_name) LIKE '%A%';

-- 19) Ŀ�̼��� NULL�� ������� �̸��� Ŀ�̼��� ����϶�.
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NULL;

-- 20) ������ 'SA_MAN', 'PU_CLERK', 'IT_PROG' �� ������� �̸�, ����, ������ ����϶�.
SELECT first_name, salary, job_id
FROM employees
WHERE job_id = 'SA_MAN' OR job_id = 'PU_CLERK' OR job_id = 'IT_PROG';

-- 21) ������ 'SA_MAN', 'PU_CLERK', 'IT_PROG' �� �ƴ� ������� �̸�, ����, ������ ����϶�.
SELECT first_name, salary, job_id
FROM employees
WHERE job_id != 'SA_MAN' AND job_id != 'PU_CLERK' AND job_id != 'IT_PROG';

-- 22) ������ 'SA_MAN'�̰� ������ 1200�̻��� ������� �̸�, ����, ������ ����϶�.
SELECT first_name, salary, job_id
FROM employees
WHERE job_id = 'SA_MAN' AND salary >= 1200;

-- 23) ��� ���̺��� �̸��� ����϶�. �� ù ��° �÷��� �̸��� �빮�ڷ� ����ϰ�, �� ��° �÷��� �̸��� �ҹ��ڷ� ����ϰ�, �� ��° �÷��� �̸��� ù ��° ö�ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ����϶�.
SELECT UPPER(last_name), LOWER(last_name), INITCAP(last_name)
FROM employees;

-- 24) �̸��� alexander(��� �ҹ���)�� ����� �̸��� ������ ��ȸ�϶�
SELECT LOWER(first_name), salary
FROM employees
WHERE LOWER(first_name) = 'alexander';

-- 25) ���� �ܾ� SMITH���� SMI�� �߶� ����϶�.
SELECT SUBSTR('SMITH', 1, 3)
FROM dual;

-- 26) ������� �̸��� ����ϰ� �� ���� �̸��� ö�� ������ ����϶�.
SELECT first_name, LENGTH(first_name)
FROM employees;

-- 27) �̸��� �ҹ��� a�� �����ϴ� ��� ���° �ڸ��� ��ġ�ϴ� �� ����϶�.
SELECT first_name, INSTR(first_name, 'a')
FROM employees;

-- 28) ������� �̸��� ������ ����϶�. �� ���� �÷��� �ڸ����� 10�ڸ��� �ϰ�, ������ ����ϰ� ���� ������ �ڸ��� *(��ǥ)�� ä���� ����϶�.
SELECT first_name, LPAD(salary, 10, '*')
FROM employees;

-- 29) ������� �̸��� ������ ����϶�. �� ���� 100�� �׸�(��) �ϳ��� ����϶�.
SELECT first_name, REPLACE(salary, 100, '��')
FROM employees; 

-- 30) 876.567 ���ڸ� ����϶�, �� �Ҽ��� �� ��° �ڸ��� 6���� �ݿø��ؼ� ����϶�.
SELECT ROUND(876.567, 1)
FROM dual;

-- 31) 876.567 ���ڸ� ����϶�. �� �Ҽ��� �� ��° �ڸ��� 6�� �� ������ ���ڵ��� ��� ������ ����϶�
SELECT TRUNC(876.567, 1)
FROM dual;

-- 32) ���� 10�� 3���� ���� ������ ���� ����϶�
SELECT MOD(10,3)
FROM dual;

-- 33) ��� ��ȣ�� ��� ��ȣ�� Ȧ���̸� 1, ¦���̸� 0�� ����϶�.
SELECT employee_id, MOD(employee_id, 2)
FROM employees;

-- 34) �����ȣ�� ¦���� ������� ��� ��ȣ�� �̸��� ����϶�.
SELECT employee_id, first_name
FROM employees
WHERE MOD(employee_id, 2) = 0;

-- 35) ����� �̸��� �Ի��� ��¥���� ���� �� �� ���� �ٹ��ߴ��� ����϶�. 

-- 36) 2018�� 10�� 1�Ͽ��� 2019�� 6�� 1�� ������ ���ϼ��� ����϶�.

-- 37) 2018�� 10�� 1�Ͽ��� 2019�� 6�� 1�� ������ �� ��(Week) ���� ����϶�.

-- 38) 2019�� 5�� 1�Ϸκ��� 100�� ���� ��¥�� ��� �Ǵ��� ����϶�.

-- 39) 2019�� 5�� 1�Ϸκ��� 100�� �Ŀ� ���ƿ��� ��¥�� ��� �Ǵ��� ����϶�.

-- 40) 2021�� 6�� 30�Ϸκ��� �ٷ� ���ƿ� ȭ������ ��¥�� ��� �Ǵ��� ����϶�

-- 41) 2019�� 5�� 22�Ϸκ��� �ٷ� ���ƿ� �������� ��¥�� ��� �Ǵ��� ����϶�

-- 42) ���ú��� ������ ���ƿ� ȭ������ ��¥�� ����϶�

-- 43) 2019�� 5�� 22�Ϻ��� 100�� �ڿ� ���ƿ��� ȭ������ ��¥�� ����϶�

-- 44) ���÷κ��� 100�� �ڿ� ���ƿ��� �������� ��¥ ���

-- 45) 2019�� 5�� 22�� �ش� ���� ������ ��¥�� ��� �Ǵ��� ����϶�

-- 46) ���ú��� �̹� �� ���ϱ��� �� ��ĥ ���Ҵ��� ����϶�

-- 47) �̸��� SUSAN�� ����� �̸�, �Ի���, �Ի��� ���� ������ ��¥�� ����϶�

-- 48) �̸��� GRANT�� ����� �̸��� �Ի��� ������ ����ϰ�, GRANT�� ���޿� õ������ ������ �� �ִ� �޸�(,)�� �ٿ� ����϶�

-- 50) 2008�⵵�� �Ի��� ����� �̸��� �Ի����� ����϶�

-- 51) ������ 1500 �̻��� ����� �̸���, ���޿� õ������ ������ �� �ִ� �޸�(,)�� ȭ������� �ٿ� ����϶�

-- 52) 2005�� 06�� 14�Ͽ� �Ի��� ����� �̸��� �Ի����� ����϶�

-- 53) ����� �̸��� Ŀ�̼��� ����϶�. �� Ŀ�̼��� NULL�� ������� 0���� ����϶�

-- 54) ������ 'SA_MAN' �Ǵ� 'IT_PROG' �� ����� ���ް� Ŀ�̼�, �׸��� ���ް� Ŀ�̼��� ���� ����Ͻÿ�. �� Ŀ�̼��� NULL�� ��� 0���� ǥ���Ͽ� ����϶�

-- 55) ����� �̸��� �μ� ��ȣ�� ����Ͻÿ�, ���� �μ� ��ȣ�� 10���̸� 300��, �μ� ��ȣ�� 20���̸� 400��, ������ �μ� ��ȣ�� 0�� ����ϴ� '���ʽ�'�� ����϶�

-- 56) ��� ��ȣ�� ��� ��ȣ�� ¦������ Ȧ�������� ����϶�

-- 57) ����� �̸�, ����, ���ʽ��� ����Ͻÿ�. �� ������ 'SA_MAN'�̸� ���ʽ� 5000�� ����ϰ�, ������ ������ ���ʽ� 2000�� ����϶�

-- 58) ����� �̸�, ����, ����, ���ʽ��� ����Ͻÿ�. �� ���ʽ��� ������ 3000�̻��̸� 500��, ������ 2000�̻� 3000�̸��̸� 300��, ������ 1000�̻� 2000�̸��̸� 200��, �������� 0�� ����϶�

-- 59) ����� �̸�, ����, Ŀ�̼�, ���ʽ��� ����Ͻÿ�. �� ���ʽ��� Ŀ�̼��� NULL�̸� 500��, NULL�� �ƴϸ� 0�� ����϶�

-- 60) ����� �̸�, ����, ���ʽ��� ����Ͻÿ�. �� ���ʽ��� ������ 'SA_MAN', 'PU_CLERK' �̸� 500��, 'ST_CLERK', 'FI_ACCOUNT'�̸� 400��, ������ JOB�� 0�� ����Ͻÿ�.