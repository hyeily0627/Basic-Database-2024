-- 조회 복합 조건
-- 축구에 관한 도서중, 가격이 20,000원 이상인 도서를 검색하시오
SELECT bookid
	 , bookname
	 , publisher
	 , price
-- 줄 나눠서 쓰는 이유는 필요없어졌을때 쉽게 지우기 위해서
  FROM Book 
 WHERE bookname LIKE '%축구%' 
   AND price >=20000

