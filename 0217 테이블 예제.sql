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
VALUES (00001, '맛나요 떡볶이', '분식');

INSERT INTO menu
VALUES (00001, '떡볶이', 3000);
INSERT INTO menu
VALUES (00001, '튀김', 500);

INSERT INTO ingre
VALUES ('떡볶이', '떡', 100, 5);
INSERT INTO ingre
VALUES ('떡볶이', '오뎅', 50, 4);
INSERT INTO ingre
VALUES ('떡볶이', '양배추', 400, 1);
INSERT INTO ingre
VALUES ('떡볶이', '고추장', 250, 1);
INSERT INTO ingre
VALUES ('떡볶이', '물엿', 50, 5);
INSERT INTO ingre
VALUES ('튀김', '기름', 50, 1);
INSERT INTO ingre
VALUES ('튀김', '튀김가루', 50, 1);
INSERT INTO ingre
VALUES ('튀김', '야채', 100, 1);

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
VALUES (00001, '떡볶이', 2);
INSERT INTO customer
VALUES (00001, '튀김', 5);

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
VALUES (00002, '마이카츠', '일식', 1000000);

INSERT INTO menu
VALUES (00002, '돈까스', 7000);
INSERT INTO menu
VALUES (00002, '에비동', 8000);

INSERT INTO ingre
VALUES ('돈까스', '돼지고기', 1800, 1, 00002);
INSERT INTO ingre
VALUES ('돈까스', '튀김가루', 50, 2, 00002);
INSERT INTO ingre
VALUES ('에비동', '튀김가루', 50, 1, 00002);
INSERT INTO ingre
VALUES ('에비동', '새우', 800, 3, 00002);
INSERT INTO ingre
VALUES ('에비동', '밥', 400, 1, 00002);

UPDATE menu
SET s_id = '00003'
WHERE m_name = '제육볶음';

INSERT INTO store
VALUES (00003, '최귤이식당', '한식', 8000000);

INSERT INTO menu
VALUES (00002, '제육볶음', 7500);
INSERT INTO menu
VALUES (00003, '소불고기', 10000);


INSERT INTO ingre
VALUES ('제육볶음', '돼지고기', 1800, 1, 00003);
INSERT INTO ingre
VALUES ('제육볶음', '고춧가루', 100, 3, 00003);
INSERT INTO ingre
VALUES ('제육볶음', '대파', 200, 1, 00003);
INSERT INTO ingre
VALUES ('소불고기', '소고기', 2500, 1, 00003);
INSERT INTO ingre
VALUES ('소불고기', '당면', 300, 1, 00003);
INSERT INTO ingre
VALUES ('소불고기', '양파', 250, 1, 00003);

INSERT INTO store
VALUES (00004, '보쿠타치', '일식', 75000000);

INSERT INTO menu
VALUES (00004, '스키야키', 20000);
INSERT INTO menu
VALUES (00004, '모듬초밥', 15000);
INSERT INTO menu
VALUES (00004, '오코노미야키', 9000);


INSERT INTO ingre
VALUES ('스키야키', '육수', 300, 3, 00004);
INSERT INTO ingre
VALUES ('스키야키', '소고기', 2500, 1, 00004);
INSERT INTO ingre
VALUES ('스키야키', '버섯', 500, 4, 00004);
INSERT INTO ingre
VALUES ('스키야키', '계란', 200, 2, 00004);
INSERT INTO ingre
VALUES ('모듬초밥', '회', 400, 12, 00004);
INSERT INTO ingre
VALUES ('모듬초밥', '밥', 400, 2, 00004);
INSERT INTO ingre
VALUES ('오코노미야키', '양배추', 700, 1, 00004);
INSERT INTO ingre
VALUES ('오코노미야키', '가쓰오부시', 100, 4, 00004);
INSERT INTO ingre
VALUES ('오코노미야키', '새우', 800, 1, 00004);

--1) 모든 식당 리스트 조회
SELECT * FROM store;
SELECT * FROM ingre;

--2) 가게별 가게명, 카테고리, 재료 목록, 재료 가격 조회
SELECT s.s_name, s.s_kate, i.i_name, i.i_price
FROM store s NATURAL JOIN ingre i;

--3) 가게별 매출 순위
SELECT RANK() OVER(ORDER BY s_sales desc) AS 매출순, s_name, s_sales
FROM store;

--4) 카테고리별 매출 순위
SELECT RANK() OVER(PARTITION BY s_kate ORDER BY s_sales desc) AS 매출순, s_name, s_sales
FROM store;

-- 5) 가게명, 메뉴, 메뉴 가격 조회
SELECT * FROM menu;

-- 6) 가게별 최고 금액인 메뉴 조회
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
--                            SELECT RANK() OVER(PARTITION BY s_id ORDER BY m_price) AS 가게별
--                            FROM employees;
--                            );

-- 7) 메뉴가 가장 많은 가게의 메뉴명, 메뉴 가격 조회
SELECT m_name, m_price, count(m_name)
FROM menu
GROUP BY s_id
--WHERE count(m_name) = (
--                                    SELECT (count(m_name))
--                                    FROM menu
--                                    GROUP BY s_id
                                    );

-- 8) 0001 가게가 보유하고 있는 재료 명, 갯수 조회
SELECT i_name, i_num
FROM ingre
WHERE s_id = 00001;