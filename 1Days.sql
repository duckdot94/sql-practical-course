-- BMS Instance 접속 및 SGA생성 확인
Select instance_name, host_name, status from v$instance;

-- DataBase 기동 확인
Select name,platform_name, open_mode from v$database;

--테이블 전체 조회
Select * from employees ;

--테이블 전체 컬럼 조회
DESC employees ;

--특정 컬럼의 모든 Rows 조회.
Select DEPARTMENT_ID, SALARY  from employees ;

--90번 부서만 조회
Select DEPARTMENT_ID, SALARY
from employees
WHERE  DEPARTMENT_ID=90
;

--90번 부서의 인원수 조회
Select COUNT(*)
from employees
WHERE  DEPARTMENT_ID=90
;

-- 90번 부서에 SUM함수 사용.
Select SUM(SALARY)
from employees
Where  department_id=90;

-- 90번 부서에 AVG함수와 사칙연산 사용 동일결과 확인.
Select AVG(SALARY) , sum(salary) / count(salary)
from employees
where department_id=90
;

-- 각각의 함수를 하나의 Select절에 함께 기술하며, 소수점 처리 위해 Round/Trunc사용
select COUNT(SALARY) , SUM(SALARY) , Round(AVG(SALARY)) from employees where DEPARTMENT_ID=90
;
select COUNT(SALARY) , SUM(SALARY) , TRUNC(AVG(SALARY)) from employees where DEPARTMENT_ID=90
;

-- ※ where 절에 절대 함수를 사용하면 안됨.
 
-- 문자, 숫자속성의 가상컬럼 적용 부서정보 표시
select '부서번호',  90 , COUNT(SALARY) , SUM(SALARY) , ROUND(AVG(SALARY))
from employees
where department_id=90 ;

-- 연결연산자를 가상컬럼에 적용(실제컬럼에도 적용가능함.)
select '부서번호'  ||  90 , COUNT(SALARY) , SUM(SALARY) , ROUND(AVG(SALARY))
from employees
where department_id=90 ;

-- Alias적용 가독성 향상
select '부서번호 90' AS 부서번호 , COUNT(SALARY) || SUM(SALARY) || ROUND(AVG(SALARY)) AS 인원수소계평균
from employees
where department_id=90
;

select '부서번호 90' AS 부서_번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , ROUND(AVG(SALARY)) AS 평균
from employees
where department_id=90
;

--부서 컬럼만 조회.
Select DEPARTMENT_ID
from employees
;

--Distinct 사용.
Select DISTINCT DEPARTMENT_ID
from employees
;

--Order by 부서 정렬
Select DISTINCT DEPARTMENT_ID  from employees
ORDER BY DEPARTMENT_ID
;

Select DISTINCT DEPARTMENT_ID  from employees
ORDER BY DEPARTMENT_ID NULLs First
;

Select DISTINCT DEPARTMENT_ID  from employees
ORDER BY DEPARTMENT_ID NULLs Last
;

-- 집계쿼리 부서ID를 상수적용 11회반복실행
select '부서번호 10' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where DEPARTMENT_ID=10 ;
select '부서번호 20' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 20;
select '부서번호 30' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 30;
select '부서번호 40' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 40;
select '부서번호 50' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 50;
select '부서번호 60' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 60;
select '부서번호 70' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 70;
select '부서번호 80' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 80;
select '부서번호 90' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 90;
select '부서번호100' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id=100;
select '부서번호110' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id=110;

--주) 부서번호가 없는 NULL 조회 (임시 부서 번호 999 적용)
select '부서번호999' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id IS NULL ;

-- Union All로 한번에 실행 후 취합
select '부서번호 10' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 10
UNION ALL
select '부서번호 20' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 20
UNION ALL
select '부서번호 30' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 30
UNION ALL
select '부서번호 40' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 40
UNION ALL
select '부서번호 50' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 50
UNION ALL
select '부서번호 60' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 60
UNION ALL
select '부서번호 70' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 70
UNION ALL
select '부서번호 80' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 80
UNION ALL
select '부서번호 90' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 90
UNION ALL
select '부서번호100' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id=100
UNION ALL
select '부서번호110' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id=110
UNION ALL
select '부서번호999' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id IS NULL
ORDER BY 평균 DESC
;

select *
from 
(
	select '부서번호 10' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 10
	UNION ALL
	select '부서번호 20' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 20
	UNION ALL
	select '부서번호 30' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 30
	UNION ALL
	select '부서번호 40' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 40
	UNION ALL
	select '부서번호 50' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 50
	UNION ALL
	select '부서번호 60' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 60
	UNION ALL
	select '부서번호 70' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 70
	UNION ALL
	select '부서번호 80' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 80
	UNION ALL
	select '부서번호 90' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id= 90
	UNION ALL
	select '부서번호100' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id=100
	UNION ALL
	select '부서번호110' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id=110
	UNION ALL
	select '부서번호999' AS 부서번호 , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , round(avg(salary)) AS 평균 from employees where department_id IS NULL
	ORDER BY 평균 DESC
)
where 평균 >= 7000; 

-- Group by절 사용(Select절의 Alias "부서번호" 사용불가)
select DEPARTMENT_ID AS 부서번호 , SUM(SALARY) AS 소계 , COUNT(SALARY) AS 인원수 , ROUND(AVG(SALARY)) AS 평균

from employees
GROUP BY DEPARTMENT_ID
;

--주) Group by절 누락시 ORA-00937 오류 발생
select DEPARTMENT_ID , COUNT(SALARY) AS 인원수 , SUM(SALARY) AS 소계 , ROUND(AVG(SALARY)) AS 평균
from employees ;

-- Having절에 컬럼과 함수 적용 쿼리 완성.(Alias "평균" 사용 불가)
select DEPARTMENT_ID AS 부서, SUM(SALARY) AS 소계 , COUNT(SALARY) AS 인원수 , ROUND(AVG(SALARY)) AS 평균
from employees
GROUP BY DEPARTMENT_ID
HAVING  ROUND(AVG(SALARY)) >= 7000
ORDER BY 평균
;

-- InLineView처리 후 Where절 사용 ( Alias "평균" 사용 가능함...!!! )
SELECT  부서, 소계, 인원수, 평균
FROM  (
  select DEPARTMENT_ID AS 부서, SUM(SALARY) AS 소계 , COUNT(SALARY) AS 인원수 , ROUND(AVG(SALARY)) AS 평균
  from employees
  GROUP BY DEPARTMENT_ID

--HAVING  ROUND(AVG(SALARY)) >= 7000
--ORDER BY 평균
)
WHERE 평균 >= 7000
ORDER BY 평균
;

-- Employees테이블을 이용한 부서별 급여 분석
SELECT DEPARTMENT_ID AS 부서번호 
		, (
			SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
		) AS 부서명 
        , SUM(SALARY) AS 소계
        , COUNT(SALARY) AS 인원수
        , ROUND(AVG(SALARY)) AS 평균
FROM EMPLOYEES E
GROUP BY DEPARTMENT_ID
HAVING  ROUND(AVG(SALARY)) >= 7000
ORDER BY 평균
;

-- 테이블 및 컬럼에 Alias적용
select  E.DEPARTMENT_ID         AS 부서
        , ( select D.DEPARTMENT_NAME from DEPARTMENTS D where D.DEPARTMENT_ID=E.DEPARTMENT_ID ) As 부서명
        , SUM(E.SALARY)             AS 소계
        , COUNT(E.SALARY)          AS 인원수
        , ROUND(AVG(E.SALARY)) AS 평균
from employees  E
GROUP BY E.DEPARTMENT_ID
HAVING  ROUND(AVG(E.SALARY)) >= 7000
ORDER BY 평균
;
--주) 중요한 규칙은 Scalar SubQuery는 Outer Join의 결과를 확인, SSQ를 작성시 MQ는 상대적 대량, SQ는 상대적 소량의 집합이 오도록 작성해야 성능 효과 볼수 있음, 만약 반대로 구성시 성능저하 발생하며 이때는 Outer JOIN으로 변경하여 성능을 개선 할 수 있음

-- SSQ의 Where절과 조건을 MQ로 이동
select  E.DEPARTMENT_ID				AS 부서
        , D.DEPARTMENT_NAME 		As 부서명
        , SUM(E.SALARY)				AS 소계 
        , COUNT(E.SALARY)			AS 인원수
        , ROUND(AVG(E.SALARY))   	AS 평균 
from employees  E , DEPARTMENTS D
WHERE D.DEPARTMENT_ID(+)=E.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME
HAVING  ROUND(AVG(E.SALARY)) >= 7000
ORDER BY 평균
;

-- ANSI 표준
select  E.DEPARTMENT_ID				AS 부서
        , D.DEPARTMENT_NAME 		As 부서명
        , SUM(E.SALARY)				AS 소계 
        , COUNT(E.SALARY)			AS 인원수
        , ROUND(AVG(E.SALARY))   	AS 평균 
from employees  E left \
 join DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME
HAVING  ROUND(AVG(E.SALARY)) >= 7000
ORDER BY 평균
;

-- EMPLOYEE_ID FRIMARY_KEY임으로 전체가 표시됨. 
SELECT DISTINCT * FROM employees;

--사칙 연산자
SELECT salary,salary * 100 FROM employees;
SELECT salary,salary * 100 ,salary / 100 ,salary + 100 ,salary - 100 FROM employees;

--SYSDATE, ROUND 적용
SELECT employee_id ,SYSDATE ,hire_date ,ROUND(ROUND(sysdate-hire_date)/365, 1) as 근무년수 
FROM  EMPLOYEES 
; 

--연결연산자(Pipe기호) 적용, 두개 컬럼을 "하나의 컬럼"으로 ...
SELECT employee_id , SYSDATE ||  hire_date FROM  EMPLOYEES ;

--연결연산자에 문자열(가상컬럼)을 적용, 두개의 컬럼을 구분
SELECT employee_id , SYSDATE || ' / ' || hire_date as 날짜비교 FROM  EMPLOYEES ;

--1. Dummy컬럼(문자열)사용(행갯수 확인)
select 1, 'x' from Employees ;

--3.주석(Comments)사용
Select job_id /* Manager_ID */ From Employees;

--4.힌트(Hint)사용
Select /*+First_Rows(10)*/ job_id, Manager_ID
From Employees
;

-- 문자열 'KING' 대문자 입력 조회
SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE UPPER(last_name) = 'KING'
;

/*
SQL문 3대 원칙 
1. 부정 연산자를 쓰지마라.
2. null값이 없이 사용해라.
3. 좌변변형을 사용하지마라. 
*/

-- 부정 연산자 <> 사용예
select DeptNO, DName, Loc
From DEPT
WHERE DName <> 'SALES'
;

--주) ASCII 찾는 쿼리 
select ascii('A') ascii from dual ;
select ascii('z') ascii from dual ;

select 1, 'x' from Employees where 1 = 1;

-- NLS_Date_Format 조회
select   * 
from    NLS_SESSION_PARAMETERS
where  parameter = 'NLS_DATE_FORMAT'
;

--Between 9000 ~ 10000
select employee_id,last_name ,job_id, salary
from employees
where salary BETWEEN 9000 AND 10000
;

-- IN조건(문자)
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE last_name IN ( 'King','Abel','Jones')
;

--J뒤에 %를 통한 문자열 매칭, 결과추출
SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE  'J%'
;
--J뒤의 4개 문자만 매칭
SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE  'J____'
;
-- J뒤 1개 문자만 매칭
SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE  'J_'
;

-- 부정 연산자 <> 사용예
select DeptNO, DName, Loc
From DEPT
WHERE DName <> 'SALES'
;
-- 부정 연산자 ^= 사용예
select DeptNO, DName, Loc
From DEPT
WHERE DName ^= 'SALES'
;
-- 부정 연산자 != 사용예
select DeptNO, DName, Loc
From DEPT
WHERE DName != 'SALES'
;
-- 논리 부정 NOT 사용예
select DeptNO, DName, Loc
From DEPT
WHERE NOT DName ='SALES'
 ;


--NOT In 으로 처리
select   d1.DeptNO,  d1.DName,   d1.Loc
From    DEPT   D1
WHERE D1.DeptNO  NOT IN ( select D2.DeptNO
                      From   DEPT D2
	   WHERE  DName = 'SALES'
	                      )
;

--Not Exists연산자 적용
select DeptNO, DName, Loc
From DEPT   D1
WHERE NOT Exists (select   'x'
                           From    DEPT D2
	        WHERE  DName = 'SALES'
	            and  D1.DeptNO = D2.DeptNO)
;

--With구문 처리 후 부정
 With d2 as (select deptno 
          from dept d2 
          where dname = 'sales'  ) d2 
Select d1.Deptno,  d1.Dname, d1.Loc  
 from dept d1 , d2 
where d1.Deptno <> d2.Deptno
 ;

--Outer Join에 Rowid 를 Null로 조회
select  d1.DeptNO,  d1.DName,   d1.Loc ,
From DEPT D1 ,  DEPT D2 
 WHERE D1.DeptNO    = D2.DeptNO(+)
      and D2.DName(+) = 'SALES'
      and D2.rowid is null 
;

--InLineView 처리 후 부정 조건 적용
select   d1.DeptNO,  d1.DName,   d1.Loc
From DEPT D1 ,
         ( Select   DeptNO 
           From    DEPT D2 
           WHERE DName = 'SALES'
         ) D2 
 WHERE  D1.DeptNO <> D2.DeptNO 
;


--InLineView 처리 후 Outer Join을 Null으로 조회
select x.deptno, x.dname, x.loc
from        ( Select  d1.DeptNO,  d1.DName,   d1.Loc  
          From DEPT D1 ,  DEPT D2 
       WHERE D1.DeptNO = D2.DeptNO(+)
            and D2.DName(+) = 'SALES'
      ) x
where  x.d2_deptno is null
;

--Where 절에 AND 사용 결과
SELECT employee_id,last_name ,job_id, salary
FROM employees
WHERE job_id = 'IT_PROG' AND salary = 9000
;

--Where 절에  || 사용 결과
SELECT employee_id,last_name ,job_id, salary
 FROM employees
WHERE job_id || salary =  'IT_PROG' || 9000
;

--UNION
select employee_id,last_name
          ,job_id, salary
from employees
where job_id like 'IT_%'  
UNION
select employee_id,last_name
          ,job_id, salary
from employees
where salary=6000
; 


--UNION ALL
select employee_id,last_name
          ,job_id, salary
from employees
where job_id like 'IT_%'  
UNION ALL
select employee_id,last_name
          ,job_id, salary
from employees
where salary=6000
; 

--UNION
SELECT  employee_id , last_name , job_id , salary
FROM   employees
WHERE  job_id LIKE 'IT_%'  
UNION
SELECT  employee_id , last_name , job_id , salary
FROM   employees
WHERE  salary = 6000
;

--UNIN ALL + DISTINCT
SELECT DISTINCT employee_id  ,last_name ,job_id  ,salary
FROM
(   SELECT employee_id,last_name ,job_id, salary
    FROM   employees
    WHERE  job_id LIKE 'IT_%'  
    UNION ALL
    SELECT employee_id,last_name ,job_id, salary
    FROM   employees
    WHERE  salary = 6000 
) 
;

-- Select절의 Alias 를 Order by에 내림차순 적용
SELECT last_name,job_id, salary as "급여"
FROM employees
ORDER BY 급여 DESC
 ;
 
-- Select절의 좌측 3번째 컬럼 Order by 내림차순 적용
SELECT last_name , job_id , salary
FROM employees
ORDER BY 3 DESC
;

-- 문자 속성 컬럼에 대한 Order by에 적용
SELECT  employee_id , last_name as 이름 , job_id,salary
FROM   employees
ORDER BY last_name ASC
;
-- 날짜 속성 컬럼에 Order by에 적용
SELECT   employee_id , last_name , salary , hire_date as 입사일
FROM    employees
ORDER BY hire_date DESC
;

--주) ASCII 찾는 쿼리 
select ascii(' ') from dual ;  

-- Null "속성" 확인. (붉은색 박스)
desc TB_NULL_TEST ;

-- Null "속성" 확인. (붉은색 박스)
Select  Owner, Table_Name, Column_Name, Data_Type, Data_length, Nullable From   All_Tab_Columns
Where Owner        = 'SCOTT'
  AND Table_Name = 'TB_NULL_TEST'
 ;

-- 실험 테이블 생성 및 데이터 입력
Drop Table TB_Null_Test Purge ;
Create Table TB_Null_Test
( id      number(4)    primary key
, vlu     varchar2(10)
, ins_dt  date           NOT NULL
)
;
Insert into tb_null_test (id,      ins_dt) values (1,                sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (2 , ''            ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (3, null         ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (4, NULL       ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (5, (null)        ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (6, (NULL)      ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (101, ' '         ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (102, 0          ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (103, 'null'      ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (104, 'NULL'    ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (105, '(null)'    ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (106, '(NULL)'  ,sysdate );
Insert into tb_null_test (id, vlu, ins_dt) values (107, '??'        ,sysdate );

Commit;

select * from tb_null_test where VLU is Null;

select NVL(vlu, '?????') from tb_null_test where VLU is Null;

-- Count 불가능
select count(vlu) from tb_null_test  ;

-- MAX, MIN 불가능
select MIN(vlu) , MAX(vlu) from tb_null_test ;

-- 사칙연산 불가능
select vlu, vlu+1 from tb_null_test  where vlu is null  ;

--정렬 불가능
select * from tb_null_test order by vlu;

--* 사용시 Count 가능
select count(NVL(vlu,'널인값다')) from tb_null_test ;
select count(*) from tb_null_test ;

--NVL사용시 MAX, MIN 가능
select MAX(NVL(vlu,'널인값다'))  from tb_null_test ;
select MAX(NVL(vlu,9999)) from tb_null_test where vlu is null;

--NVL사용시 사칙연산 가능
select vlu, NVL(vlu, 999 ) +1 from tb_null_test ;
select (NVL(vlu,9999))+1 from tb_null_test  where vlu is null  ;

--정렬 불가능 => 정렬시 NVL 또는 NULL First, Last 사용
select * from tb_null_test order by vlu NULLS First ;
select * from tb_null_test order by vlu NULLS Last ;
select * from tb_null_test  order by NVL(vlu,'홍길동');

--Null 포함 컬럼은 Distinct 가능.
select           DISTINCT VLU from tb_null_test ;
select count (DISTINCT VLU) from tb_null_test ;
