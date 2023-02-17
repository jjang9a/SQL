CREATE TABLE store(
s_id NUMBER(5) PRIMARY KEY,
s_name VARCHAR2(30) NOT NULL,
s_kate VARCHAR2(20)
);

CREATE TABLE menu(
s_id NUMBER(5),
CONSTRAINT s_id_fk FOREIGN KEY (s_id) REFERENCES store(s_id),
m_name VARCHAR2(30) PRIMARY KEY,
m_price NUMBER(7) CHECK (m_price >= 100)
);

CREATE TABLE ingre(
m_name VARCHAR2(30),
CONSTRAINT m_name_fk FOREIGN KEY (m_name) REFERENCES menu(m_name),
i_name VARCHAR2(20) NOT NULL,
i_price NUMBER(6) CHECK (i_price >= 10),
i_num NUMBER(4) CHECK (i_num >= 1)
);

DROP TABLE ingre;
DROP TABLE menu;
DROP TABLE store;

INSERT INTO store
VALUES (00001, '������ ������', '�н�');

INSERT INTO menu
VALUES (00001, '������', 3000);
INSERT INTO menu
VALUES (00001, 'Ƣ��', 500);

INSERT INTO ingre
VALUES ('������', '��', 100, 5);
INSERT INTO ingre
VALUES ('������', '����', 50, 4);
INSERT INTO ingre
VALUES ('������', '�����', 400, 1);
INSERT INTO ingre
VALUES ('������', '������', 250, 1);
INSERT INTO ingre
VALUES ('������', '����', 50, 5);
INSERT INTO ingre
VALUES ('Ƣ��', '�⸧', 50, 1);
INSERT INTO ingre
VALUES ('Ƣ��', 'Ƣ�谡��', 50, 1);
INSERT INTO ingre
VALUES ('Ƣ��', '��ä', 100, 1);

SELECT * FROM store;
SELECT * FROM menu;
SELECT * FROM ingre;

CREATE TABLE customer(
s_id NUMBER(5),
CONSTRAINT s_id_cfk FOREIGN KEY (s_id) REFERENCES store(s_id),
m_name VARCHAR2(30),
CONSTRAINT m_name_cfk FOREIGN KEY (m_name) REFERENCES menu(m_name),
c_num VARCHAR2(3) CHECK (c_num > 0)
);

INSERT INTO customer
VALUES (00001, '������', 2);
INSERT INTO customer
VALUES (00001, 'Ƣ��', 5);

SELECT * FROM customer;

ALTER TABLE store
ADD (s_sales NUMBER(9));

ALTER TABLE ingre
ADD (s_id NUMBER(5),
CONSTRAINT s_id_ifk FOREIGN KEY (s_id) REFERENCES store(s_id));

SELECT * FROM store;

UPDATE store
SET s_sales = 3000000;

UPDATE ingre
SET s_id = 00001;

SELECT * FROM ingre;

INSERT INTO store
VALUES (00002, '����ī��', '�Ͻ�', 1000000);

INSERT INTO menu
VALUES (00002, '���', 7000);
INSERT INTO menu
VALUES (00002, '����', 8000);

INSERT INTO ingre
VALUES ('���', '�������', 1800, 1, 00002);
INSERT INTO ingre
VALUES ('���', 'Ƣ�谡��', 50, 2, 00002);
INSERT INTO ingre
VALUES ('����', 'Ƣ�谡��', 50, 1, 00002);
INSERT INTO ingre
VALUES ('����', '����', 800, 3, 00002);
INSERT INTO ingre
VALUES ('����', '��', 400, 1, 00002);

UPDATE menu
SET s_id = '00003'
WHERE m_name = '��������';

INSERT INTO store
VALUES (00003, '�ֱ��̽Ĵ�', '�ѽ�', 8000000);

INSERT INTO menu
VALUES (00002, '��������', 7500);
INSERT INTO menu
VALUES (00003, '�ҺҰ��', 10000);


INSERT INTO ingre
VALUES ('��������', '�������', 1800, 1, 00003);
INSERT INTO ingre
VALUES ('��������', '���尡��', 100, 3, 00003);
INSERT INTO ingre
VALUES ('��������', '����', 200, 1, 00003);
INSERT INTO ingre
VALUES ('�ҺҰ��', '�Ұ��', 2500, 1, 00003);
INSERT INTO ingre
VALUES ('�ҺҰ��', '���', 300, 1, 00003);
INSERT INTO ingre
VALUES ('�ҺҰ��', '����', 250, 1, 00003);

INSERT INTO store
VALUES (00004, '����Ÿġ', '�Ͻ�', 75000000);

INSERT INTO menu
VALUES (00004, '��Ű��Ű', 20000);
INSERT INTO menu
VALUES (00004, '����ʹ�', 15000);
INSERT INTO menu
VALUES (00004, '���ڳ�̾�Ű', 9000);


INSERT INTO ingre
VALUES ('��Ű��Ű', '����', 300, 3, 00004);
INSERT INTO ingre
VALUES ('��Ű��Ű', '�Ұ��', 2500, 1, 00004);
INSERT INTO ingre
VALUES ('��Ű��Ű', '����', 500, 4, 00004);
INSERT INTO ingre
VALUES ('��Ű��Ű', '���', 200, 2, 00004);
INSERT INTO ingre
VALUES ('����ʹ�', 'ȸ', 400, 12, 00004);
INSERT INTO ingre
VALUES ('����ʹ�', '��', 400, 2, 00004);
INSERT INTO ingre
VALUES ('���ڳ�̾�Ű', '�����', 700, 1, 00004);
INSERT INTO ingre
VALUES ('���ڳ�̾�Ű', '�������ν�', 100, 4, 00004);
INSERT INTO ingre
VALUES ('���ڳ�̾�Ű', '����', 800, 1, 00004);

--1) ��� �Ĵ� ����Ʈ ��ȸ
SELECT * FROM store;
SELECT * FROM ingre;

--2) ���Ժ� ���Ը�, ī�װ�, ��� ���, ��� ���� ��ȸ
SELECT s.s_name, s.s_kate, i.i_name, i.i_price
FROM store s NATURAL JOIN ingre i;

--3) ���Ժ� ���� ����
SELECT RANK() OVER(ORDER BY s_sales desc) AS �����, s_name, s_sales
FROM store;

--4) ī�װ��� ���� ����
SELECT RANK() OVER(PARTITION BY s_kate ORDER BY s_sales desc) AS �����, s_name, s_sales
FROM store;

-- 5) ���Ը�, �޴�, �޴� ���� ��ȸ
SELECT * FROM menu;

-- 6) ���Ժ� �ְ� �ݾ��� �޴� ��ȸ
--WITH menuPan AS(
--        SELECT m_price, s_name, m_name
--        FROM store s JOIN menu m
--        USING (s_id)
--)
--SELECT s_name, MAX(m_price)
--FROM menuPan
--GROUP BY s_name
--ORDER BY 2;

SELECT s_name, m_name
FROM store NATURAL JOIN menu
GROUP BY s_name;
WHERE m_price = (
                            SELECT MAX(m_price)
                            FROM menu
                            );

--SELECT m_name
--FROM menu
--WHERE m_price = (
--                            SELECT RANK() OVER(PARTITION BY s_id ORDER BY m_price) AS ���Ժ�
--                            FROM employees;
--                            );

-- 7) �޴��� ���� ���� ������ �޴���, �޴� ���� ��ȸ
SELECT m_name, m_price, count(m_name)
FROM menu
GROUP BY s_id
--WHERE count(m_name) = (
--                                    SELECT (count(m_name))
--                                    FROM menu
--                                    GROUP BY s_id
                                    );

-- 8) 0001 ���԰� �����ϰ� �ִ� ��� ��, ���� ��ȸ
SELECT i_name, i_num
FROM ingre
WHERE s_id = 00001;