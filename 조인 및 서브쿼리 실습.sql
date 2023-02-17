-- Chapter 07 ) ����


--1. LOCATIONS �� COUNTRIES ���̺��� ����Ͽ� HR �μ��� ���� ��� �μ��� �ּҸ� �����ϴ� query�� �ۼ��Ͻÿ�.
--��¿� ��ġ ID, �ּ�, ��/��, ��/�� �� ������ ǥ���ϸ�, NATURAL JOIN�� ����Ͽ� ����� �����մϴ�.
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM locations l NATURAL JOIN countries c;

--2. ��� ����� ��, �Ҽ� �μ���ȣ �� �μ� �̸��� ǥ���ϴ� query�� �ۼ��Ͻÿ�.
SELECT e.last_name, department_id, d.department_name
FROM employees e JOIN departments d
USING (department_id);

--3. Toronto�� �ٹ��ϴ� ����� ���� ������ �ʿ�� �մϴ�. toronto���� �ٹ��ϴ� ��� ����� ��, ����, �μ���ȣ �� �μ� �̸��� ǥ���Ͻÿ�. (��Ʈ : 3-way join ���)
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
                            JOIN locations l ON (d.location_id = l.location_id)
WHERE l.city = 'Toronto';

--4. ����� �� �� ��� ��ȣ�� �ش� �������� �� �� ������ ��ȣ�� �Բ� ǥ���ϴ� ������ �ۼ��ϴµ�, �� ���̺��� ���� Employee, Emp#, Manager �� Mgr#���� �����Ͻÿ�.
SELECT e.last_name as Employee, e.employee_id Emp#, m.last_name Manager, m.employee_id Mgr#
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

--5. King�� ���� �ش� �����ڰ� �������� ���� ��� ����� ǥ���ϵ��� 4�� ������ �����մϴ�. ��� ��ȣ������ ����� �����Ͻÿ�. 
SELECT e.last_name as Employee, e.employee_id Emp#, m.last_name Manager, m.employee_id Mgr#
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id)
ORDER BY e.employee_id;

--6. ����� ���� �μ� ��ȣ �� �־��� ����� ������ �μ��� �ٹ��ϴ� ��� ����� ǥ���ϴ� ������ �ۼ��Ͻÿ�. ������ ������ ���̺��� �����Ӱ� ������ ���ϴ�.
SELECT e.last_name, e.department_id, m.last_name
FROM employees e, employees m
WHERE e.department_id = m.department_id
AND e.employee_id != m.employee_id;

-- Chapter 08 ) ��������

--1. Zlotkey�� ������ �μ��� ���� ��� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. Zlotkey�� ������������Ͻÿ�.
SELECT first_name, hire_date
FROM employees
WHERE department_id = (
                                    SELECT department_id
                                    FROM employees
                                    WHERE last_name = 'Zlotkey'
                                    );

--2. �޿��� ��� �޿����� ���� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ����� �޿��� ���� ������������ �����Ͻÿ�.
SELECT employee_id, first_name
FROM employees
WHERE salary > (
                        SELECT TRUNC(AVG(salary))
                        FROM employees
                        )
ORDER BY salary;

--3. �̸��� u�� ���Ե� ����� ���� �μ����� ���ϴ� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ���Ǹ� �����Ͻÿ�.
SELECT employee_id, first_name
FROM employees
WHERE department_id IN (
                                    SELECT department_id
                                    FROM employees
                                    WHERE first_name LIKE '%u%'
                                    );

--4. �μ� ��ġ ID�� 1700�� ��� ����� �̸�, �μ� ��ȣ �� ���� ID�� ǥ���Ͻÿ�.
SELECT first_name, department_id, job_id
FROM employees
WHERE department_id IN (
                                    SELECT department_id
                                    FROM departments
                                    WHERE location_id = 1700
                                    );

--5. King���� �����ϴ�(manager�� King) ��� ����� �̸��� �޿��� ǥ���Ͻÿ�.
SELECT first_name, salary
FROM employees
WHERE manager_id = (
                                SELECT employee_id
                                FROM employees
                                WHERE last_name = 'King'
                                );

--6. Executive �μ��� ��� ����� ���� �μ� ��ȣ, �̸� �� ���� ID�� ǥ���Ͻÿ�.
SELECT department_id, e.first_name, e.job_id
FROM employees e NATURAL JOIN departments d
WHERE d.department_name = (
                                            SELECT department_name
                                            FROM departments
                                            WHERE department_name = 'Executive'
                                            );

--7. ��� �޿����� ���� �޿��� �ް� �̸��� u�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ��� ����� ��� ��ȣ, �̸� �� �޿��� ǥ���Ͻÿ�.
SELECT employee_id, first_name, salary 
FROM employees
WHERE salary > (
                        SELECT TRUNC(AVG(salary))
                        FROM employees
                        )
AND department_id IN (
                                SELECT department_id
                                FROM employees
                                WHERE first_name LIKE '%u%'
                                );
