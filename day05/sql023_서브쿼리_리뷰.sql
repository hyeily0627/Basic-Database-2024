-- 서브쿼리 리뷰
-- ❗ALL, ANY, SOME
-- ✅3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 다른 주문의 주문번호와 금액을 표시하라
SELECT *
  FROM Customer

-- > 3번 : 장미란이 주문한 내역 중 최고금액
SELECT MAX(saleprice)
  FROM Orders
 WHERE custid = 3 

--> 13,000원 보다 비싼 도서를 구입한 주문번호와 금액
SELECT o1.*
      ,o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > 13000

-- > 최종 입력 
SELECT o1.*
      ,o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > (SELECT MAX(saleprice)
                        FROM Orders
                        WHERE custid = 3)

-- ❗EXISTS, NOT EXISTS - 열을 명시 하지 않음
-- ✅ 대한민국 거주 고객에게 판매한 도서의 총 판매액 

--> 대한민국 거주고객 
SELECT * 
  FROM Customer AS c 
 WHERE c.address LIKE '%대한민국%'

--> 최종입력 
SELECT SUM(saleprice)
  FROM Orders AS o 
 WHERE EXISTS
(SELECT * 
  FROM Customer AS c 
 WHERE c.address LIKE '%대한민국%'
 AND c.custid = o. custid)

 --> 조인으로 출력
 SELECT SUM(o.saleprice) AS '조인도 가능'
   FROM Orders AS o, Customer AS c 
 WHERE o.custid = c.custid
   AND c.address LIKE '%대한민국%'

-- p.228 스칼라 부속질의 
-- ❗SELECT절 서브쿼리(join으로 변경가능, 이미 쿼리가 복잡해서 테이블 추가 힘들면 많이 사용 ) 
-- ✅ 고객별 판매액을 보이시오
-- ** GROUP BY가 들어가면 SELECT절에 반드시 집계함수가 들어가야함
SELECT SUM(o.saleprice) AS '고객별 판매액'
      ,o.custid
      ,(SELECT [name] FROM Customer WHERE custid = o.custid) AS 고객명
  FROM Orders AS o 
 GROUP BY o.custid 

-- ❗UPDATE에서도 사용가능 
-- 한꺼번에 필요한 필드값을 한테이블에서 다른테이블로 복사할때 아주 유용!! 
-- 사전준비하기 
ALTER TABLE Orders ADD bookname VARCHAR(40)

UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book
                    WHERE Book.bookid = Orders.bookid)

-- p.231 인라인뷰 
-- ❗FROM절 서브쿼리 
-- ✅고객별 판매액을 보이시오(서브쿼리에서 조인으로!!)
-- 고객별 판매액 집계 쿼리가 FROM절에 들어가면 모든 속성(컬럼)에 이름이 지정되어야함
SELECT b.total
      ,c.name
  FROM ( SELECT SUM(o.saleprice) AS 'total'
      ,o.custid
  FROM Orders AS o 
 GROUP BY o.custid) AS b, Customer AS c 
 WHERE b.custid = c.custid

 -- ✅고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
SELECT SUM(o.saleprice) AS '고객별 판매액'
      ,(SELECT name FROM Customer WHERE custid = c.custid) AS 고객명 
   FROM ( SELECT custid 
                ,name 
           FROM Customer
          WHERE custid <=2)AS c, Orders o 
 WHERE c.custid = o.custid
 GROUP BY c.custid 