# Basic-Database-2024
부경대학교 2024 IoT 개발자 과정 - SQLServer 학습 리포지토리

## 1일차 
- MS SQL Server 설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 - 개발자 버젼
        - ** ISO 다운로드 후 설치 추천
        - 다운로드 폴더 - 파일 선택 - 오른쪽 마우스 - 탑재 - setup.exe 클릭(설치센터)
        - 설치센터 - 메뉴:설치 - 새 SQL Server 독립실행형 또는~ 설치 
        - Developer / 표준 / -> Azure확장 체크해제 
        - 기능선택 : 데이터베이스 엔진 서비스,  SQL Server복제 , 검색을 위한 전체 텍스트~, intergration Services 
        - 인스턴스 구성: 이름 굳이 바꿀 필요없으나, 여러 서버 사용시에는 지정 이름이 필요
        - 서버구성 : 손댈거 없음 / *데이터 정렬에 엔진 보면 CI 는 대소문자 구분안함
        - 데이터베이스 엔진 구성 (혼합모드로 선택!)
            - WINDOWS인증모드 : 외부에서 접근 불가 
            - 혼합모드(sa) : sa에 대한 암호를 지정(8자이상, 대소문자구분, 특수문자 포함) / 현재 mssql_p@ss 으로 설정함 - 현재 사용자 추가 
            - 데이터루트 디렉토리는 변경 - C: Datas 폴더 생성 후 설정 
        - 설치 준비 - 설치 클릭 
    - 개발툴 설치 
        - SSMS(Sql Server Management Studio) : https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16 - 사용가능한 언어에서 '한국어' 설치 - 다운로드 후 바로 설치하기! 
        : DB에 접근, 여러 개발 작업 
        
        -SSMS 로그인 화면

        ![SSMS로그인](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS.png)

        - SSMS 메인화면
        ![SSMS로그인](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS3.png)

 - SQL 기본 학습
    - SSMS 실행        
        - 도구 - 옵션 - 글자체 및 크기 설정 
        -> 모든 언어 - 줄번호 체크 
        -> 디자이너 - 테이블 다시 만들어야하는 변경내용 저장 안 함 체크해제 - NULL 기본키 경고 체크 
        -> SQL Server 개체탐색기 - 테이블 및 뷰 옵션 - 명령의 값 2개 다 0으로 바꾸기 

        - 새쿼리로 생성하여 콘솔 열기(ctrl + n) 
        - utf - 8 
        - F5로 실행

        ![SSMS생성예시](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS1.png)

        - (주석관련) -- , /* */  사용가능
        - equal 연산자 == 사용하지 않고 = 사용
        - "" 사용하지 않고 '' 사용
        - ; 는 필수가 아니나, 중요한 사항에서는 사용할 것
        - 데이터베이스에서 all 은 * 이다!!(모든 컬럼을 읽어오다) 
        - ctrl + shift + U  : 대문자 변환
        - ctrl + shift + L  : 소문자 변환
            => 스크롤 해서 사용인가봄 
        - ctrl + h 검색해서 바꾸기 

        - 인코딩 관련 
            - 도구 - 텍스트편집기 - 파일 확장명 - 아래 사진 같이 설정 - ctrl+n 안내창 뜸  
            ![SSMS인코딩](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/SSMS2.png)

- SSMS 특이사항(sql002.sql 파일참조)
: SSMS 쿼리창에서 소스코드 작성시 빨간색 오류 밑줄이 가끔 표현됨(전부 오휴는 아님!)
-------------------------------------------------------------------------------------------------------------

- 데이터베이스 개념
1. 데이터, 정보, 지식  
    - 데이터 : 관찰의 결과로 나타난 정량적 혹은 실제적 값 
    - 정보 : 데이터에 의미 부여
    - 지식 : 사물이나 현상에 대한 이해 
2. 데이터베이스의 활용 : 검색과 변경(삽입,삭제,수정)
3. 데이터베이스 개념 및 특징  
    - 개념: 통합된 데이터 / 저장된 데이터 / 운영데이터 / 공용데이터 
    - 특징: 실시간 접근성 / 계속적인 변화 / 동시공유 /내용에 따른 참조 
4. 데이터베이스 시스템의 구성 
: DBMS < DATABASE < DATA (MODEL) 

-데이터베이스 시스템의 구성 
1. DB 언어 
    - SQL(Structured Query Language) : 구조화된 질의 언어 
        - DDL(Data Definition Lang) - 데이터 정의어 : CREATE, ALTER, DROP (데이터베이스, 테이블, 인덱스 생성 )
        - DML(Data Manipulation Lang) - 데이터 조작어 : SELECT, INSERT, DELETE, UPDATE
        - DCL(Data Control Lang) - 데이터 제어어 : GRANT, REVOKE (보안, 사용자 권한 부여/제거 기능)
        - TCL(Transaction) - 트랜젝션 제어 : COMMIT, ROLLBACK (원래 DCL 의 일부지만, 기능이 특이해서 TCL로 분리)

2. 데이터 모델 
    - 계층 데이터모델(사용x)
    - 네트워트 데이터모델(사용x)
    - 관계 데이터모델(주로사용)
    - 객체 데이터모델
    - 겍체-관계 데이터모델

3. 스키마
- PK(primary key: 기본키) - : 박스에서 줄 위에 위치 

- FK(foreign key: 외래키(외부키)) 

4. DML 학습
    - SQL 명령어 키워드 : SELECT, INSERT, DELETE, UPDATE
    - IT 개발에서 표현하는 언어 : Create, Request, Update, Delete => CRUD로 부름 
      (ex. CRU 개발하라 의 뜻은 Create, Request, Update를 기능을 가진 것을 개발)
    - SELECT문의 기본 문법
        ```sql
        SELECT [ALL|DISTINCT] 속성이름(들) - (All* 전부 | DISTINCT 를 사용하여 중복제거 )
        FROM 테이블이름(들)
        [WHERE 검색조건(들)]
        [HAVING 검색조건(들)]
        [ORDER BY 속성이름(들) [ASC|DESC]]
        ```
   - 중복제거 : DISTINCT
   - 조건 연산자 : < > = 
   - 집합 : (ex) IN ('굿스포츠' , '대한미디어') , NOT IN
   - 패턴비교 - LIKE 사용 : '축구%' -- '축구'라는 글자로 시작 
   - 패턴비교 - 와일드문자 _ 사용 : '_구%' _(밑줄기호)특정 위치에 한문자만 대신할때 사용 

## 2일차
- DataBase 학습
    - DB 개발시 사용할 수 있는 툴 
        - SSMS(기본)
        - Visual Studio : 아무런 설치 없이 개발 가능 
        - Visual Studio Code : 플러그인 설치시 가능(SQL Server(mssql)) 
        - ServerName(hostName) - 내 컴퓨터 이름|내네트워크주소|127.0.0.1(LoopBack IP)|localhost(LoopBack URL) 중에서 선호하는거 아무거나 선택

- 관계 데이터 모델 :데이터를 2차원 테이블 형태인 릴레이션으로 표현하며, 릴레이션에 대한 제약조건과 관계연산을 위한 관계대수를 정의
    1.  릴레이션(relation) : 행과 열로 구성된 테이블 
        : 행(튜플), 열(속성), 스키마, 인스턴스 용어 
        - 릴레이션 특징 
        1) 속성은 단일값을 가진다.
        2) 속성은 다른 이름으로 구성
        3) 속성의 값은 정의된 도메인값만 가짐 (ex 대학교 1~4학년 외에 5학년 있으면 안됨)
        4) 릴레이션 내 중복된 튜플 허용하지 않음
        5) 튜플 순서는 상관 없음  

    ![릴레이션개념](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/re.png)

        - 매핑되는 이름 테이블(실제 DB)
            - 행(레코드), 열(필드,컬럼), 내포(필드명), 외연(데이터)
        - 차수(degree) - 속성의 갯수
        - 카디날리티(cardinality) - 튜플의 수 
    2. 제약조건(constraints)

    3. 관계대수(relational algebra)

-------------------------------------------------------------------------------------------------------------

- DML 학습(*줄 나눠서 쓰는 이유는 필요없어졌을때 쉽게 지우기 위해서!!)
    - 복합조건  
        (ex) WHERE bookname LIKE '%축구%' 
                   AND price >=20000
    - 정렬 : ORDER BY     
        - 기본은 오름차순(ASC 생략) 
        - 내림차순은 ORDER BY price DESC 

    - 집계함수 : SUM, AVG, MIN, MAX, COUNT
        - COUNT()는 *을 사용할 수 있음. 
        - 나머지 집계함수는 열(컬럼)하나만 지정해서 사용할 것 
        - HAVING은 집계함수의 필터 GROUP BY 뒤에 작성

    ```sql
    SELECT SUM(saleprice) AS 총매출
    FROM Orders
    /*
    SUM(saleprice)는 저장된 데이터를 가공하여 얻은 새로운 열이기때문에
    결과테이블에 별도의 이름없이 출력됨.
    이를 의미있는 열 이름 부여를 위해서는 속성이름의 별칭을 지정하는
    AS 키워드를 사용하여 열이름을 부여 한다. 
    */
    SELECT SUM(saleprice) AS "총 매출"
    FROM Orders
    -- 별칭 중간에 공백이 필요한 경우 큰따옴표, 대괄호를 사용한다.
    
    ```
    
    - 🚨GROUP BY 검색 : 필요조건으로 그룹핑 하여 결과를 내거나 통계를 산출
    
    ```sql
    -- 이거 🚨짱짱짱짱짱🚨 중요
    -- GROUP BY절에 들어있는 컬럼 외에는 SELECT문에 절대(!) 쓸 수 없음.
    -- 단, saleprice는 집계함수안에 들어있으므로 예외이다. 
    /*
    SELECT *
  FROM Orders
  GROUP BY custid
    집계 함수나 GROUP BY 절에 없으므로 SELECT 목록에서 사용할 수 없습니다. 라는 에러뜸 
    */

    SELECT custid, SUM(saleprice) AS [판매액]
    FROM Orders
    GROUP BY custid

    ```
    - 2개 이상의 테이블 질의(Query) 163p
        - 관계형 DB에서 가장 중요한 기법 중 하나 = 조인

        [참조] https://sql-joins.leopard.in.ua/ 조인 보여주는 사이트 

        1) Inner Join(내부조인) : 교집합

        ```sql
        -- 주문한 책의 고객이름과 책판매액의 조회
            SELECT Customer.name
                 , Orders.saleprice
            FROM Customer, Orders
            WHERE Customer.custid = Orders.custid
            ORDER BY Customer.custid ASC;
        ``` 
        2) Outer Join(외부조인) : LEFT OUTER JOIN vs RIGHT OUTER JOIN
        -> 어느 테이블이 기준인지에 따라서 결과가 상이함

        ![조인](https://raw.githubusercontent.com/hyeily0627/Basic-Database-2024/main/images/join.png)