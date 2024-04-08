-- 지난주 잘못 만든 데이터를 전부 초기화 
-- 삭졔 
DELETE FROM Users; -- WHERE절이 없으면 모두 삭제임 
-- 단, indentity(1,1)로 설정한 테이블에서 1부터 다시 넣도록 설정하려면
-- 모두 지우고 테이블 초기화까지 진행 
TRUNCATE TABLE Users 

-- 200만건으로 줄여서 다시 시작 
DECLARE @i INT;
SET @i = 0;

WHILE (@i < 2000000)
BEGIN
	SET @i = @i + 1;
	INSERT INTO Users (username, guildno, regdate)
	VALUES (CONCAT('user', @i), @i/100, DATEADD(dd, -@i/100, GETDATE()));
END;

-- > 인덱스 없는 상태에서 100만건 정도 데이터 조회시 5~8초 정도 소요 


--  ✅인덱스를 걸기 위해서 userid에 기본키(PK)를 설정 
ALTER TABLE Users ADD PRIMARY KEY(userid)
--> ❗실행시 PK도 클러스터 인덱스로 걸림 

/*
-- username에 넌클러스트터 설정 
CREATE INDEX IX_Users_username ON Users(username)
--> 둘다 해도 별 차이가 없네,,,? 왜 그럴까 이건 진짜 의문인데,,, 
*/ 

-- WHERE에 검색을 위해서 username을 사용함
-- ❗인덱스를 PK에 거는게 아니라 username 에 걸기 
CREATE CLUSTERED INDEX IX_Users_username ON Users(username)

DROP INDEX IX_Users_username ON Users

-- ctrl + l 로 예상실행계획 표시 확인

-- 클러스터를 안걸면 1초이상, 걸면 0초에서 실행됨! 

/*
🚨 위에서 실수한 점이 있는데, 인덱스는 대량의 데이터에서 찾고자 하는 데이터를 빨리 찾게 해주는 목적이므로
위와 같이 대량으로 찾으면 당연히 시간은 동일하게 느릴 수 밖에 없음.
*/
-- WHERE, JOIN의 ON절에 들어가는 컬럼에 인덱스를 설정하는 것이 속도 개선에 좋다.
-- 1번 PK, 2번 FK, 3번 WHERE절에 검색시 들어가는 컬럼에 인덱스를 설정
-- 단, NULL 값이 많거나, 중복이 많은 컬럼의 인덱스를 걸면 성능 도움 X 

