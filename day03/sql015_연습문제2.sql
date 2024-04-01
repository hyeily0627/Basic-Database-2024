 -- 1. 주문하지 않은 고객의 이름(서브쿼리 사용)
SELECT [name]
    FROM Customer 
    WHERE custid NOT IN (SELECT DISTINCT custid FROM Orders)

-- 2. 주문 금액의 총액과 주문의 평균 금액
SELECT (sum(saleprice)) AS '총 금액'
      , (AVG(saleprice)) AS '평균 금액'
    FROM Orders 

-- 3. 고객의 이름과 고객별 구매액
SELECT (SELECT [name] FROM Customer c WHERE c.custid = Orders.custid) AS '고객명'
        , sum(saleprice) AS '고객별 구매액'
    FROM Orders
    GROUP BY custid

-- 4. 고객의 이름과 고객이 구매한 도서 목록
SELECT c.name, b.bookname
    FROM Customer c, Orders o,Book b
    WHERE c.custid = o.custid
    AND o.bookid = b.bookid

-- 5. 도서의 가격(BOOK테이블)과 판매가격(ORDERS테이블)의 차이가 가장 많은 주문
SELECT TOP 1 o.saleprice --1       - TOP 가장 높은
     , o.orderid    --2
     , b.price  --3
     , (b.price - o.saleprice) AS '판매금액 차' --4
    FROM Orders o, Book b
    WHERE o.bookid = b.bookid
    ORDER BY 4 DESC;

-- 6. 도서 판매액 평군보다 자신의 구매액 평균이 더 높은 고객의 이름
-- 전체 도서의 판매 평균금액 = 11,800원 
SELECT b.AVG AS '구매액 평균'
      ,c.name
    FROM(SELECT AVG(o1.saleprice) AS avg
               ,o1.custid
            FROM Orders AS o1
            GROUP BY o1.custid) AS b, Custpmer AS c 
    WHERE b.custid = c.custid 
      AND b.avg >= (SELECT AVG(slaeprice)
                    FROM Orders)
                 

SELECT(SELECT name FROM Customer WHERE custid = base.custid) AS '고객명'
      ,base.Average 
   FROM(SELECT o.custid
            ,AVG(o.saleprice) AS Average 
            FROM Orders AS o 
            GROUP BY o.custid) AS base 
WHERE nase.Average >= (SELECT AVG(saleprice))

