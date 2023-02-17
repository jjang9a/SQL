-- 1��) ��� ����鿡 ���� �����ȣ, �̸�, ����, �Ի��� ���
SELECT employee_id, first_name, job_id, hire_date
FROM employees;

-- 2��) �Ŵ��� ��å�� �����ȣ - �ߺ����� �ʰ� ���
SELECT DISTINCT manager_id
FROM employees;

-- 3��) �޿��� 7000�̻�, 12000�����̸� �̸��� 'H'�� �����ϴ� ����� �����ȣ, �̸�, �޿�, �μ���ȣ ���
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary BETWEEN 7000 AND 12000 AND last_name like 'H%';

--4��) 2005�� 1�� 1�� ���Ŀ� �Ի��� ����� ���, �̸�, �Ի���, ù ���ں��� 3���ڸ� ��µ� �̸��ϰ���, �̸����� ���ڼ� ���
SELECT employee_id, first_name, hire_date, SUBSTR(email, 1, 3) EMAIL, LENGTH(email) AS EMAIL_LENGTH
FROM employees
WHERE hire_date >= '2005/01/01';

-- 5��) ����� : �̸�, �Ի���, �Ի� 6�������� ��¥, �Ի� �� ù �ݿ���, �� �ٹ� ����(����), ù �޿���(�Ի��� ���� �� 1��) - �������� ����
SELECT first_name, hire_date, ADD_MONTHS (hire_date, 6) AS ��������, NEXT_DAY(hire_date, '�ݿ���') AS �����ݿ���, 
            TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS �ٹ�����, TRUNC(ADD_MONTHS(hire_date,1),'month') AS ù�޿��� 
FROM employees
ORDER BY hire_date;

-- 6��) Ŀ�̼��� �޴� ��� ��� / �����ȣ, �̸�, �Ի���, ����(�޿�*Ŀ�̼�)
SELECT employee_id, first_name, TO_CHAR(hire_date, 'dd/mm/yyyy day') AS �Ի���, TO_CHAR(salary*commission_pct, '$9,999.99') as ����
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY ���� DESC;

-- 7��) �μ���ȣ�� 50���� 60�� ���� ��� �޿��� 5000���� ���� ������ �����ȣ, �̸�, ����ID, �޿�, �μ���ȣ
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE (department_id = 50 OR department_id = 60) AND salary > 5000;

-- 8��) �Լ��̿� - ��ȭ��ȣ�� ������ȣ�� 515�� �����ϴ� ����� ���, ����ID, ��ȭ��ȣ, �μ���ȣ ���
SELECT employee_id, job_id, phone_number, department_id
FROM employees
WHERE SUBSTR(phone_number, 1, 3) = 515;

-- 9��) �����ȣ, ����̸�, ����=(�޿�+����)*12, �Ի��� ����, ������ �޴��� ����(COMM, NOCOMM)�� ��Ÿ���� ���, �μ���ȣ / �μ���ȣ, ������ ��������
SELECT employee_id, first_name, (salary * (1+NVL(commission_pct,0)))*12 as ����, TO_CHAR(hire_date, 'yyyy') as �Ի�⵵,
            NVL2(commission_pct, 'COMM', 'NOCOMM') AS ���, department_id
FROM employees
ORDER BY department_id, salary;

-- 10��) �����ȣ, ����̸�, �μ���ȣ �� �ٹ����� - 20 ĳ����, 80 ����, ������ �̱�
SELECT employee_id, first_name, department_id,
            CASE department_id WHEN 20 THEN 'Canada'
                                       WHEN 80 THEN 'UK'
            ELSE                      'USA' END AS �ٹ�����
FROM employees;