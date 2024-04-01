-- Customer 를 기준으로 order 테이블과 외부조인하기 

SELECT c.custid 
      ,c.[name]
      ,c.[address]
      ,c.phone 
      ,o.orderid
      ,o.custid -- OUTER JOIN에서는 이 외래키 필요 없음
      ,o.bookid
      ,o.saleprice
      ,o.orderdate
  FROM Customer AS c LEFT OUTER JOIN Orders AS o -- LEFT, RIGHT, FULL로 변경하면서 실행해보기
    ON c.custid = o.custid