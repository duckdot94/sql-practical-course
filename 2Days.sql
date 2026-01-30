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
Insert into tb_null_test (id, vlu, ins_dt) values (107, '널'        ,sysdate );

Commit;

select * from TB_Null_Test;

select DISTINCT VLU from TB_NULL_TEST;

select count(*) from TB_NULL_TEST where VLU is null;

-- RowID update, delete, merge에서 사용 가능
-- 하나의 행에 대한 유일한 값 중복될 수 없음
-- PK로 사용할 수 없음(재사용될 수 있음)

--  RowID조회 
select ROWID,  A.* from TB_Null_Test A;

--SQLTools에서 사용 명령
select ROWID as Rid, A.*  from TB_Null_Test A;

-- Rid 리네임하는 순간 시스템ID에서 사용자 ID가 된다.

-- Rownum은 데이터 입력순서에 따라 부여된 rowid 순서와 동일함. 
select ROWID as Rid, ROWNUM, A.*  from TB_Null_Test A;

-- Rownum은 정렬 후에는 의미 없음.
select ROWID as Rid, ROWNUM, A.*  from TB_Null_Test A order by VLU;

select ROWID as Rid, ROWNUM, A.*  from TB_Null_Test A where ROWNUM = 1;
-- Rownum은 함수명으로 조회시 반드시 Rownum = 1이 존재할 수 있는 조건이어야 쿼리가 정상 동작한다.

select ROWID as Rid, ROWNUM, A.*  from TB_Null_Test A where ROWNUM = 2;

select ROWID as Rid, ROWNUM, A.*  from TB_Null_Test A where ROWNUM > 1 and ROWNUM <= 10;
select ROWID as Rid, ROWNUM, A.*  from TB_Null_Test A where ROWNUM > 0 and ROWNUM <= 10;

-- Rownum=1 조건이 만족되지 않으면 결과가 없다.(inLine view로 감싸야 함)
select
* 
from (
    select ROWID as Rid, ROWNUM as Rno, A.*  from TB_Null_Test A
)
where Rno > 1 and Rno <= 10;

select
ROWNUM, IV.* 
from (
    select ROWID as Rid, ROWNUM as Rno, A.*  from TB_Null_Test A order by Rno desc
) IV
where IV.Rno > 1 and IV.Rno <= 10;

-- dept 테이블을 Dept_1 테이블로 복사 
Drop Table Dept_1 Purge ;
create table Dept_1 as select * from dept;

select * from Dept_1;

--띄어쓰기 있는 공백으로 변경 (스페이스로 변경) - Space값 넣기
SELECT 'JACK and JUE', REPLACE('JACK and JUE' , 'JACK and JUE' , ' ')
FROM dual 
;   -- ASCII 함수로 증명

--띄어쓰기 없는 공백 즉 NULL 조건으로 컬럼 데이터 NULL로 변경
SELECT 'JACK and JUE', REPLACE('JACK and JUE' , 'JACK and JUE' , '')
FROM dual 
;  -- NVL함수로 증명

--띄어쓰기 없는 공백 즉 NULL 조건으로 한문자( A ) 삭제
SELECT 'JACK and JUE' , REPLACE('JACK and JUE' , 'A' , '' ) 
FROM dual
;

SELECT 'JACK and JUE' , REPLACE('JACK and JUE' , 'A' , ' ' ) 
FROM dual
;

-- 문자열의 길이 조회
SELECT LENGTH('HGD'), LENGTH('홍길동')
FROM dual
;

SELECT LENGTH('홍길동'), Vsize('홍길동')
FROM dual
;
-- dept 테이블의 Dname 컬럼의 문자열 길이 조회
select Dname, Length(Dname), Vsize(Dname) from dept;

-- 주어진 컬럼의 문자열 길이의 합계 조회
select sum(Length(Dname)), sum(Vsize(Dname)) from dept;

--강제 공백 제거
--1 MILLER의 좌우 5개의 공백 제거(검증위해 Length사용)
SELECT LENGTH('     MILLER     ')    as "처리전길이"
        , TRIM('     MILLER     ')   as "공백제거결과"
        , LENGTH(TRIM('     MILLER     '))   as "처리후길이"
FROM dual
;

-- 빈공간 NULL로 채움에 따라 해당 컬럼 NULL로 변경
select RPAD ( '홍길동' , 10   ,''  ) as Col from dual ;

select dname, instr(dname, 'A') from dept;

select dname, instr(dname, 'E') from dept;

select '홍길동' as 이름, instr('홍길동', '길') from dual;

-- Truc와 Round결과 비교
SELECT
    last_name,
    hire_date,
    trunc (months_between('2023-10-13', hire_date)) "근무월수",
    round (months_between('2023-10-13', hire_date)) "근무월수_1",
    trunc(trunc(months_between('2023-10-13', hire_date))/12) "근무년수",
    round(round(months_between('2023-10-13', hire_date))/12) "근무년수_1"
FROM employees
ORDER BY 3 desc
;

-- DBMS_RANDOM 패키지 사용 예제
SELECT DBMS_RANDOM.VALUE(1, 10) FROM dual;

SELECT SYSDATE, SYSDATE + 1 from dual;
SELECT SYSDATE, SYSDATE - 1 from dual;

SELECT       months_between('2025-05-30', to_date('2024-05-30'))  from dual;
SELECT       months_between('2025-05-30', to_date('2024-05-31'))  from dual;
SELECT round(months_between('2025-05-30', to_date('2024-05-31'))) from dual;
SELECT trunc(months_between('2025-05-30', to_date('2024-05-31'))) from dual;

-- 현재날짜의 전월, 차월 날짜 조회
SELECT
    sysdate                       as "현재",
    add_months(sysdate, 1)   as "다음달",
    add_months(sysdate, - 1) as "이전달"
FROM dual
;

--31일 기준으로 이전, 다음 달의 마지말 일자 확인
SELECT
    add_months('2025-0531', 1)   as "다음달_마지막일자",
     '2025-0531'                       as "기준일자",
    add_months('2025-0531', -1) as "이전달_마지막일자"
FROM dual
;

-- 년도 추출
select extract(year from sysdate) from dual
UNION ALL
-- 월 추출
select extract(month from sysdate) from dual
UNION ALL
-- 일 추출
select extract(day from sysdate) from dual;

select extract(year from sysdate) || chr(10) ||
       extract(month from sysdate) || chr(10) ||
       extract(day from sysdate) as "오늘날짜" from dual;


alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

select next_day(sysdate, 7) from dual;

--숫자 1000 을 문자로 변환
Select to_char(1000) from dual ;

--숫자 0001 을 문자로 변환
Select to_char(0001) from dual ;

-- 통화 단위 표시 방법
alter session set nls_currency='￦' ;

SELECT last_name, salary,
   TO_CHAR(salary, '$999,999') 달러,
   TO_CHAR(salary, 'L999,999') 원화
FROM employees
;

--현재 시간을 날짜시간 모든 옵션 포맷 적용한 사례
SELECT   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual ;
SELECT   TO_CHAR(SYSDATE, 'MM/DD/YYYY AM HH24:MI:SS') FROM dual ;

SELECT sysdate FROM dual;

-- 문자열로 2020년 08월02일 의미의 6자리 입력(작은따옴표)
SELECT TO_DATE( '200802' ) from dual;
-- ORA-01861: 리터럴이 형식 문자열과 일치하지 않음

-- 문자열로 2000년08월02일의미 6자리 엽력 (작은따옴표)
SELECT TO_DATE( '000802' ) from dual;
-- ORA-01861: 리터럴이 형식 문자열과 일치하지 않음

-- 숫자로 2020년 08월02일 의미의 6자리 입력
SELECT TO_DATE( 200802 ) from dual;
-- ORA-01861: 리터럴이 형식 문자열과 일치하지 않음

--숫자로 2000년08월02일의미 6자리 엽력(3자리의 0은 소거됨)
SELECT TO_DATE( 000802 ) from dual;
-- ORA-01840: 입력된 값의 길이가 날짜 형식에 비해 부족합니다

Alter session set nls_date_format='YY-MM-DD';

Select NULLIF ('aaa', 'aaa') result from dual ;

Select NVL(NULLIF ( 'aaa', 'aaa'),'Null 입니다.') result from dual ;

-- Coalesce 사용예
Select employee_id,
        commission_pct, coalesce(commission_pct, 0), commission_pct, nvl2(commission_pct, commission_pct, 1)
From   employees
;

-- Salary가 24000이면 20%, 17000이면 30%, 그외는 50% 적용.
SELECT last_name,salary,
         DECODE(salary, 24000, salary*0.2,
                              17000, salary*0.3,
                                       salary*0.5) as "보너스"
FROM employees
ORDER BY 2 desc
;

-- NVL : Oracle 전용 Null 대체 함수
-- NVL2 : Oracle 전용 Null 대체 함수
-- COALESCE : SQL 표준 함수

Select '부서번호' || 90 as "부서정보", count(*) as "사원수", SUM(salary) as "급여합계", Round(AVG(salary)) as "평균급여"
From employees;

SELECT 
    NVL(department_id, '999') AS "부서정보", 
    COUNT(*) AS "사원수", 
    SUM(salary) AS "급여합계", 
    ROUND(AVG(salary)) AS "평균급여"
FROM employees
GROUP BY NVL(department_id, '999');


