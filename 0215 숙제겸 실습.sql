CREATE TABLE market(
--VARCHAR2 -> 영어는 1byte, 한글은 3byte
m_id NUMBER(5) PRIMARY KEY,
mname VARCHAR2(30) NOT NULL,
madd VARCHAR2(150) NOT NULL,
mphone CHAR(13),
mmoney NUMBER(6) CHECK (mmoney>=1000));

INSERT INTO market
VALUES (12345, '털보네 슈퍼', '대구시 중구 중앙대로 430', '053-1234-1234', 1000);

CREATE TABLE products(
pno NUMBER(4) PRIMARY KEY,
pname VARCHAR2 (30),
pprice NUMBER(5) CHECK (pprice >= 100),
pkeep CHAR(1) CHECK ( pkeep IN ('F','C') ),
m_id NUMBER(5),
CONSTRAINT m_id_fk FOREIGN KEY (m_id) REFERENCES market(m_id)
);

INSERT INTO products
VALUES(1000, '귤', 1500, 'C', 12345);

INSERT INTO products
VALUES(1001, '사과', 3000, 'C', 12345);

INSERT INTO products
VALUES(1002, '고등어', 4000, 'C', 12345);

INSERT INTO products
VALUES(1003, '만두', 10000, 'F', 12345);

INSERT INTO products
VALUES(1004, '얼음', 3000, 'F', 12345);

SELECT *
FROM products;

DROP TABLE market;

CREATE TABLE iusers(
u_id VARCHAR2(15) PRIMARY KEY,
u_name VARCHAR2(9) NOT NULL,
u_pw VARCHAR2(10) NOT NULL,
m_id NUMBER(5),
CONSTRAINT m_id_ifk FOREIGN KEY (m_id) REFERENCES market(m_id)
);

CREATE TABLE basket(
b_id CHAR(10) PRIMARY KEY,
pno NUMBER(5),
            CONSTRAINT pno_ifk FOREIGN KEY (pno) REFERENCES products(pno),
b_num NUMBER(1) NOT NULL,
m_id NUMBER(5),
            CONSTRAINT m_id_bfk FOREIGN KEY (m_id) REFERENCES market(m_id),
u_id VARCHAR2(15),
            CONSTRAINT u_id_fk FOREIGN KEY (u_id) REFERENCES iusers(u_id),
b_pro CHAR(1) DEFAULT 'R' CHECK (b_pro in ('R', 'D', 'F'))
);

INSERT INTO iusers
VALUES ('yedam001', '또치', 'yeadam001', 12345);

INSERT INTO iusers
VALUES ('yedam002', '희동', 'yeadam002', 12345);

INSERT INTO iusers
VALUES ('yedam003', '길동', 'yeadam003', 12345);

INSERT INTO basket
VALUES ('basket0001', 1001, 9, 12345, 'yedam001', 'R');

INSERT INTO basket
VALUES ('basket0002', 1002, 5, 12345, 'yedam002', 'D');

INSERT INTO basket
VALUES ('basket0003', 1003, 3, 12345, 'yedam003', 'R');

INSERT INTO basket
VALUES ('basket0016', 1000, 8, 12345, 'yedam001', 'F');

INSERT INTO basket
VALUES ('basket0004', 1004, 6, 12345, 'yedam002', 'F');

INSERT INTO basket
VALUES ('basket0005', 1003, 2, 12345, 'yedam002', 'R');

INSERT INTO basket
VALUES ('basket0006', 1003, 1, 12345, 'yedam001', 'F');

INSERT INTO basket
VALUES ('basket0007', 1002, 4, 12345, 'yedam002', 'D');

INSERT INTO basket
VALUES ('basket0008', 1001, 8, 12345, 'yedam003', 'F');

INSERT INTO basket
VALUES ('basket0017', 1000, 5, 12345, 'yedam003', 'R');

INSERT INTO basket
VALUES ('basket0009', 1004, 3, 12345, 'yedam002', 'R');

INSERT INTO basket
VALUES ('basket0010', 1001, 2, 12345, 'yedam002', 'R');

INSERT INTO basket
VALUES ('basket0011', 1003, 7, 12345, 'yedam003', 'F');

INSERT INTO basket
VALUES ('basket0012', 1004, 6, 12345, 'yedam003', 'F');

INSERT INTO basket
VALUES ('basket0013', 1001, 2, 12345, 'yedam002', 'D');

INSERT INTO basket
VALUES ('basket0014', 1002, 5, 12345, 'yedam001', 'D');

INSERT INTO basket
VALUES ('basket0015', 1003, 9, 12345, 'yedam002', 'R');

INSERT INTO basket
VALUES ('basket0018', 1000, 6, 12345, 'yedam002', 'R');

SELECT *
FROM market
WHERE m_id = 12345;

SELECT m.mname, m.mmoney, p.pname
FROM products p NATURAL JOIN market m
WHERE m_id = 12345;

SELECT b.b_id, b.b_num, p.pname, (p.pprice * b.b_num) AS price,
CASE WHEN b.b_pro = 'R' THEN '배송 전'
        WHEN b.b_pro = 'D' THEN '배송 중'
        WHEN b.b_pro = 'F' THEN '배송 완료'
        END AS 배송상태
FROM basket b NATURAL JOIN products p
WHERE m_id = (
                        SELECT m_id
                        FROM market
                        WHERE mname = '털보네 슈퍼'
                        );
                        
SELECT b.b_id, b.b_num, p.pname, (p.pprice * b.b_num) AS price,
CASE WHEN b.b_pro = 'R' THEN '배송 전'
        WHEN b.b_pro = 'D' THEN '배송 중'
        WHEN b.b_pro = 'F' THEN '배송 완료'
        END AS 배송상태
FROM basket b NATURAL JOIN products p
WHERE u_id = (
                        SELECT u_id
                        FROM iusers
                        WHERE u_name = '또치'
                        );
                        
SELECT SUM(b_num)
FROM basket
WHERE pno = (
                        SELECT pno
                        FROM products
                        WHERE pname = '귤'
                        );              