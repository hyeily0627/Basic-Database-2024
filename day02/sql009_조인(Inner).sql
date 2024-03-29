-- 2개 이상의 테이블 SQL 쿼리 작성 
-- Customer, Orders 테이블을 동시에 조회

SELECT *
  FROM Customer

SELECT *
  FROM Orders

-- 쿼리를 두개 날리는 멍청한 방법 

-- RDB에서 가장 중요한 쿼리문 1번
SELECT *
  FROM Customer, Orders
  WHERE Customer.custid = Orders.custid
  ORDER BY Customer.custid ASC;

-- 주문한 책의 고객이름과 책판매액의 조회
SELECT Customer.name
	  ,Orders.saleprice
  FROM Customer, Orders
  WHERE Customer.custid = Orders.custid
  ORDER BY Customer.custid ASC;


-- 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬 
-- 표준 SQL문이 아님 
SELECT Customer.name
	  ,SUM(Orders.saleprice) AS 총판매액
  FROM Customer, Orders
  WHERE Customer.custid = Orders.custid
  GROUP BY Customer.name
  ORDER BY Customer.name


-- 각 테이블의 별명으로 줄여서 쓰는게 일반적
SELECT c.custid
	  ,o.custid
	  ,c.name
	  ,c.address
	  ,c.phone
	  ,o.orderid
	  ,o.custid
	  ,o.bookid
	  ,o.saleprice 
	  ,o.orderdate
FROM Customer AS c, Orders AS o 
  WHERE c.custid = o.custid
  ORDER BY c.custid ASC;

-- 3개 테이블 조인 
SELECT * 
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
	   AND o.bookid = b.bookid
	   
-- 실제 표준 SQL inner Join
SELECT *
  FROM Customer AS c
INNER join Customer AS o
	ON c.custid = o.custid
INNER join Book AS b 
	ON o.bookid = b.bookid

-- 책 가격이 20,000원 이상인 도서를 주문한 고객의 이름과 도서명 조회 
SELECT c.name
	 , b.bookname
	 , o.saleprice
	 , b.price
  FROM Customer AS c, Orders AS o , Book AS b 
  WHERE c.custid = o.custid 
  AND o.bookid  = b.bookid -- 여기까진 Join을 위한 조건
  AND b.price >= 20000 -- 그 외 필터링을 위한 조건 




