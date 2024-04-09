-- 1번 회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.(결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 31개입니다)
SELECT Email
	  ,Mobile
	  ,Names
	  ,Addr
  FROM membertbl
 ORDER BY Addr DESC , Email ASC 

-- 2번 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.(전채 행의 개수는 59개입니다)
-- 정가가 높은순으로 정렬(내림차순) 
SELECT Names AS 도서명
      ,Author AS 저자
	  ,ISBN 
	  ,price AS 정가
  FROM bookstbl
 ORDER BY price DESC

-- 3번 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.(책을 한번도 빌린적이 없는 회원을 뜻합니다)

-- 조인으로 구현 
SELECT Names AS 회원명 
      ,Levels AS 회원등급
	  ,Addr AS 주소 
	  ,r.rentalDate 
FROM membertbl AS m left outer join rentaltbl AS r
ON m.memberIdx = r.memberIdx 
Where rentalDate is null
ORDER BY Levels ASC , Names ASC

-- 4번 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.

SELECT d.Names AS '책 장르'
      ,FORMAT (SUM(price),'#,#' ) + '원' AS '총합계금액'
  FROM bookstbl AS b, divtbl AS d
 WHERE b.Division = d.Division
 GROUP BY d.Names

-- 5번 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.

 SELECT ISNULL(d.Names, '합계') AS '책 장르'
	   ,COUNT(d.Names) AS '권 수'
       ,FORMAT (SUM(price),'#,#' ) + '원' AS '총합계금액'
  FROM bookstbl AS b, divtbl AS d
 WHERE b.Division = d.Division
 GROUP BY d.Names WITH ROLLUP
