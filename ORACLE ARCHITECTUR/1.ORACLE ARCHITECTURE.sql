-- 1장
-- 세션 정보 확인
-- [1-1]
SELECT SID, SERIAL#, PROGRAM, USERNAME, TYPE FROM V$SESSION;

-- 세션과 서버 프로세스 확인
-- [1-2]
SELECT S.SID, S.SERIAL#, S.USERNAME, S.PROGRAM "PROGRAM(Client)", p.pid, p.spid, p.program "PROGRAM(Oracle)"
  FROM V$SESSION S, V$PROCESS P
 WHERE S.PADDR = P.ADDR
   AND p.background IS NULL;

-- 테이블 스페이스 확인(CONTENTS:영구, UNDO, TEMP 유무)
-- [1-3]
SELECT TABLESPACE_NAME, CONTENTS FROM DBA_TABLESPACES;

-- 영구, UNDO 테이블 스페이스의 데이터 파일 확인
-- TABLESPACE_NAME : 속한 테이블 스페이스명
-- FILE_NAME       : 파일이름
-- [1-4]
SELECT T.TABLESPACE_NAME, F.FILE_NAME
  FROM DBA_TABLESPACES T, DBA_DATA_FILES F
 WHERE T.TABLESPACE_NAME = F.TABLESPACE_NAME;

-- 임시 테이블 스페이스 데이터 파일 확인
-- [1-5]
SELECT T.TABLESPACE_NAME, F.FILE_NAME
  FROM DBA_TABLESPACES T, DBA_TEMP_FILES F
 WHERE T.TABLESPACE_NAME = F.TABLESPACE_NAME;

-- SGA의 통합정보 확인
-- 데이터베이스 버퍼 캐시 확인
-- Database Buffers 확인
-- [1-6]
-- 버퍼캐시 크기가 크다? --> 기다렸다가 한번에 처리하게됨(블록 변경횟수 당 기록(처리)하게 되는 횟수가 적어짐) --> 성능향상
-- 버퍼캐시 크기가 작다? --> 같은 이류로 성능저하
SELECT * FROM V$SGA;

-- SGA의 상세정보 확인
-- buffer_cache 크기
-- [1-7]
SELECT * FROM V$SGASTAT;

-- REDO TABLE 관련 LGWR은 REDO 로그 버퍼의 데이터를 한번에 REDO 로그 파일로 가져온다.
-- LWGR --> REDO 기록 시점
--- 트랜젝션 커밋
--- DBWn 가 REDO 데이터 쓰기를 요청할 때 (데이터  ㅏ일에 변경된 블록을 기록할 때 등)
--- 3초마다
--- REDO 로그 버퍼의 용량이 부족한 경우
--- 아직기록하지못한 REDO 데이터가  REDO 로그 버퍼 전체 크기의 1/3에 도달
-- REDO 변경 처리 정지 : 로그 버퍼가 가득차면 멈춤

-- REDO 파일을 그룹화하여 관리할 수 있다.
-- group# 로그그룹 번호, status 상태, sequence 시퀀스번호, members 포함된 멤버수?
-- [1-8]
SELECT group#, status, sequence#, members FROM V$LOG;

-- 로그파일확인
-- [1-9]
SELECT   V$LOG.group#, V$LOGFILE.member
FROM     V$LOG, V$LOGFILE
WHERE    V$LOG.group# = V$LOGFILE.group#
ORDER BY group#;

-- 수동으로 로그스위치 발생
-- [1-10]
ALTER SYSTEM SWITCH LOGFILE;

-- 아카이브 로그 모드 확인
-- 데이터베이스가 REDO 데이터를 덮어 쓰기 전에 REDO 데이터를 '아카이브 REDO 로그 파일'로 복사해 운영중인 REDO 데이터를 저장하는 작동방식
-- 백업 파일 복구해야하는 에러 발생시, 백업본에 아카이브 REDO 로그 파일을 적용하는 것으로 발생 시점까지 복구 할 수 있음.
-- [1-11]
ARCHIVE LOG LIST

-- 아카이브 로그 모드 확인2
-- name : 데이터베이스이름, log_mode : ARCHIVELOG/NOARCHIVELOG
SELECT name, log_mode FROM V$DATABASE;

-- 아카이브 로그 모드로 전환
-- ORA-01126 데이터베이스는 이 인스턴스에서 마운트되어야 하고 다른 인스턴스에서 열리면 안됨
--           database must be mounted in this instance and not open in any instance
-- [1-12]
ALTER DATABASE ARCHIVELOG;

ALTER DATABASE NOARCHIVELOG;

-- 아카이브 로그모드 전환 예제
-- [1-13]
SHUTDOWN IMMEDIATE;

STARTUP MOUNT;

ALTER DATABASE OPEN;

ARCHIVE LOG LIST;

SELECT name, log_mode FROM V$DATABASE;
-- 예제 끝

-- 서버 초기 파라미터 확인
SHOW PARAMETERS buffer;

-- name : 초기화 파라미터 명칭
-- type : 초기화 파라미터 값 종류(Boolean, String, Integer, Parameter file, Reserved, Big Integer
-- value : 현재 적용된 설정값
-- isdefault : 설정값이 기본값일때
-- isses_modifiable : ALTER SESSION 문으로 변경가능 유/무 --> true/false
-- issys_modifiable : 설정값을 즉시변경할수있을때 immediate
-- 현재 세션에 적용된 초기화 파라미터의 상세 정보
SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$PARAMETER;

-- 현재 인스턴스에 적용된 초기화 파라미터의 상세 정보
SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$SYSTEM_PARAMETER;

SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$PARAMETER WHERE name LIKE '%buffer%';

SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$SYSTEM_PARAMETER WHERE name LIKE '%buffer%';

-- 컨트롤파일
SELECT name FROM V$CONTROLFILE;

-- 특정 프로세스만이 사용하는 메모리영역  : PGA(Program Global Area)
-- 프로게스 간에 공유하는 메모리 영역    : SGA(System Global Area)

-- PGA는 PGA 간 공유하지않음
-- PGA는 SGA 와 공유함.

-- 프로세스와 PGA확인
-- pid            : 오라클 내부에서 관리하는 프로세스 ID
-- spid           : OS레벨의 프로세스 ID
-- program        : 프로그램명칭(프로세스명칭)
-- background     : 가동중 여부 가동중일때 1
-- PGA_ALLOC_MEM  : 프로세스에 현재 할당된 PGA의 크기
-- SGA : 서버프로세스(섀도 프로세스)
-- [1-14]
SELECT pid, spid, program, background, pga_alloc_mem FROM V$PROCESS;

-- [1-15]
-- SGA 보관 데이터는 모든 서버 프로세스 및 백그라운드 프로세스에 공유
--     인스턴스기동시 확보됨
-- 공유풀 : 3개 캐시 (LIBRARY 캐시, DICTIONARY 캐시, RESULT 캐시)
-- 라지풀 : 프로세스간 통신이 필요한 특정 처리에서 필요한 메모리 영역
-- 자바풀 : 오라클 JVM 실행에 필요항 정보를 보관하는 메모리영역
-- 스트림 풀 : STREAMS 를 실행하는데 필요한 정보를 보관하는 메모리영역
-- 데이터베이스 버퍼 캐시 : 블록을 보관하는 메모리 영역 블록에 대한 캐시, 버퍼역할도 함
-- REDO 로그 버퍼 : REDO 로그파일에 기록하지않은 데이터를 보관하는 영역

-- 공유풀 : 데이터 블록 이외의 공유 가능한 데이터를 임시로 보관하기 위한 메모리 영역
--- 삭제 시점은 LRU 에 의해 관리됨.
--- 공유풀과 버퍼는 데이터 블록을 공유하냐 이외의 데이터를 공유하냐임
---- LIBRARY 캐시    : 파싱한 SQL정보, 컴파일된 PL/SQL 코드
---- DICTIONARY 캐시 : 데이터 딕셔너리에서 조회한 데이터(???)
---- RESULT 캐시     : 쿼리의 결과와 PL/SQL 함수의 결과

--- LIBRARY 캐시 : 첫번째 실행시 SQL정보를 파싱하고, 두번째 실행시 부터는 파싱하지않고 처리하고 로우를 가져온다.(???) 파싱되는 시점은?
--- DICTIONARY 캐시 : (???) SYSTEM 테이블 스페이스에 저장됨, 테이블 스페이스에 저장되는 DICTIONARY 정보를 DICTIONARY 캐시에 저장하면 액세스 를 줄일 수 있다.(???) 방법은?
--- RESULT 캐시 : 11G 부터 지원, QUERY 결과를 캐시 하기 위해서는 'PARAMETER:RESULT_CACHE_MODE:MANUAL' 설정하고 SQL힌트절에 'result cache' 명시 하거나 또는 'PARAMETER:RESULT_CACHE_MODE:AUTO' 로 지정
 
-- 자유풀 : 크기가 큰 데이터를 주고받을때 이용하는 메모리 영역
--- 삭제 시점은 사용이 끝난 순간 바로 삭제됨. LRU 관리 안함.
--- 공유 서버 접속시 공유 서버 프로세스간 통신 처리
--- 병렬 쿼리 등에서의 QUERY COORDINATOR PROCESS와 PARALLEL SLAVE PROCESS 간의 통신 처리
--- RMAN 을 사용한 백업/리스토어 처리에서의 I/O SLAVE PROCESS와의 통신 처리

-- 자바풀 : 오라클 JVM을 실행할 때 사용
--- 자바프로시저를 실행하기 위함

-- 스트림 풀 : ORACLE STREAMS, 메세지 기능을 구현하기 위한 메모리 영역

-- [1-16]
-- 메모리 관리 방식
--- AMM(Automatic Memory Management) : 11g 이후, SGA, PGA 합계가 'PARAMETER:MEMORY_TARGET' 보다 낮게 자동 조절됨.
--- ASMM(Automatic Shared Memory Management) : 10g 이후, 데이터베이스 버퍼 캐시나 공유풀 등의 크기를 자동조절.'PARAMETER:SGA_START' 보다 낮도록 자동조절.
---- 대상 : 공유풀, 라지풀, 자바풀, 데이터베이스 버퍼 캐시, 스트림풀(10g R2 이후)
---- 초기파라미터파일이 (SPFILE, PFILE) 이냐에 따라 순서대로 재기동시 유지, 초기화 됨
--- APMM(Automatic PGA Memory Management) : 9g 이후, 'PARAMETER:WORKAREA_SIZE_POLICY:AUTO, PGA_AGGREGATE_TARGET' 보다 낮게 자동조절함.
---- 관리되는 PGA 내 WORKAREA 를 제외한 영역은 관리 안되기때문에 TARGET SIZE보다 커질수있다.

-- 수동메모리 관리
--- SQL Work Areas의 xxxx_AREA_SIZE를 제어하는 방식
--- 최대로 설정하고싶을땐 WORKAREA_SIZE_POLICY:MANUAL, SORT_AREA_SIZE:1M 으로 설정

-- [1-17]
-- SMON(System Monitor)
--- 정기적으로 인스턴스의 상태를 감시하고 데이터베이스의 무결성을 유지, 관리하는 백그라운드 프로세스
---- 인스턴스 기동 시 복구가 필요하면 인스턴스 복구 수행
---- 다 사용한 임시 세그먼트를 정리(????) 세그먼트?
---- UNDO 세그먼트를 관리 크기가 커진 UNDO 세크먼트의 축소

-- PMON(Process Monitor)
--- 정기적으로 프로세스의 상태를 감시하고 프로세스 처리에 관련된 데이터 베이스의 무결성을 유지, 관리하는 백그라운드 프로세스
---- 클라이언트 애플리케이션이 비정상 종료 됐을때 처리 중 이었던 각 데이터를 복구하고 정리
---- 디스패처 프로세스와 서버 프로세스의 상태를 정기적으로 체크하고 실행이 정지된 서버 프로시스가 있다면 재기동
---- 인스턴스 및 디스패처 프로세스에 관한 정보를 리스너에 등록

-- CKPT(Check Point)
--- 이벤트에 관련된 정보를 각 파일에 기록하는 백그라운드 프로세스
---- 체크 포인트가 발생하면 데이터베이스의 모든 데이터 파일과 컨트롤 파일에 체크 포인트의 정보를 기록
---- 컨트롤 파일에 3초마다 REDO 로그 파일의 체크 포인트 위치에 관한 정보를 기록.

-- 백그라운드 프로세스 확인
-- [1-18]
SELECT pid, spid, PROGRAM, background, pga_alloc_mem
FROM   V$PROCESS WHERE BACKGROUND = 1;

-- 백그라운드 프로세스의 간단한 설명
-- [1-19]
SELECT name, description FROM V$BGPROCESS;

-- 패스워드 파일
-- [1-20]
--- 패스워드 파일 인증 이라 불리는 인증 방식을 사용할 때 필요한 인증 데이터를 보관하는 파일
--- **. 데이터 딕셔너리 인증은 인증정보를 데이터베이스에서 가져오기때문에 인스턴스 기동이 되지않으면 사용할 수 없다.
--- **. SYSDBA 권한의 DBA계정은 인스턴스 기동이되지않은 상태에서도 인증처리해야되므로, 패스워드파일인증, OS인증을 사용할 수 있도록 되어있다.
--- 유닉스/리눅스   : <ORACLE_HOME/dbs/orapw/<SID>
--- 윈도우용 오라클 : <ORACLE_HOME>\database\pwd<SID>.ora

-- 로그파일
-- [1-21]
-- 과거의 운영상태를 확인할때 로그 파일에 기록된 정보를 확인 및 장애 분석

--- ALERT 로그
---- 데이터베이스 운영 중에 발생하는 심각한 에러뿐아니라, 기동, 종료 등의 관리 작업에 관한 중요한 정보가 출력되는 텍스트 형식의 로그파일
---- 파일명 : alert_<ORACLE_SID>.log
---- 위치  : 10g - 초기파라미터 'PARAMETER:BACKGROUND_DUMP_DEST'
---- 위치  : 11g - ADR_HOME 아래 TRACE에 출력
---- 내용
----- 인스턴스가 기동될 때의 흐름과 기본값이 아닌 초기화 파라미터값
----- 인스턴스를 종료할 때의 흐름
----- 발생한 모든 ORA-00600에러, 블록과 관련된 ORA-1578에러 및 deadlock 관련 ORA-00060 에러, 그 밖의 심각한 에러
----- 데이터 베이스의 관리 조작 명령어와 실행 결과(SQL문의 CREATE/ALTER/DROP DATABASE/TABLESPACE 및ARCHIVE LOG의 출력, 복구 처리등)
----- materialized view 의 자동 갱신시 발생하는 에러
----- (????) cat 이나 tail을 활용한 시스템 분석 활용에 좋을거같음

--- 트레이스 파일
---- 트레이스 파일은 서버 프로세스나 백그라운드 프로세스 등 각종 프로시스의 에러 정보나 상세한 진단 정보가 출력되는 텍스트파일
---- 심각한 에러 발생 시, ALERT 로그에 에러 번호, 동시에 트레이스파일에 정보 출력됨(프로세스 명칭, 프로세스 PID)
---- 위치  : 10g - 서버      프로세스의 트레이스 파일은 초기파라미터 'PARAMETER:USER_DUMP_DEST' 에 설정된 디렉토리에 출력
----              백그라운드 프로세스의 트레이스 파일은 초기파라미터 'PARAMETER:BACKGROUND_DUMP_DEST' 에 설정된 디렉토리에 출력
---- 위치  : 11g - 서버, 백그라운드 모두 ADR_HOME 아래 trace 디렉터리 트레이스 파일이 출력

--- Net Services 관련 로그
---- 네트워크를 통해 인스턴스를 접속할때 Net Services SW를 사용하는데 접속 장애 등의 문제를 분석할때 로그파일

-- [1-22]
-- 데이터 딕셔너리 뷰와 동적 성능 뷰
--- 데이터 딕셔너리 뷰 : 오라클 내부의 구성 정보를 제공하는 특수한 읽기 전용 뷰
--- SYS 계정 소유
--- 애초에 딕셔너리 테이블 수가 많고 유저 권한에서 함부로 수정할 수 없어, 매뉴얼공개되지 않음

-- [1-23]
-- 동적 성능 뷰
--- 오라클의 동적 상태에따라 내용이 지속적으로 변하는 각종 통계정보나 동작상태를 확인 할 수 있는 조회 전용 뷰
---- 각종 통계정보
---- 프로세스, 세션 메로리 영역의 상태
---- 그 외 오라클의 동작 상태에 관한 정보


-- [2]
-- 계정과 권한

-- [2-1]
-- 스키마 : 계정이 소유하는 테이블이나 인덱스 등의 오브젝트를 포함하는 논리적인 콘테이너
-- 계정정보 백업 : 데이터 딕셔너리에 저장되므로 백업할 수 없으나, 계정생성시 사용한 DDL 이나 DBMS_METADATA 패키지를 사용해 DDL 추출
-- 계정 속성
--- DEFAULT 테이블 스페이스 : 오브젝트를 생성 할 때 저장할 테이브 스페이스를 지정하지 않았을때 저장되는 테이블 스페이스
--- DEFAULT 임시 테이블 스페이스 : SQL 실행 시 임시 세그먼트가 필요할 때 임시 세그먼트를 확보하기 위한 테이블 스페이스(????) 세그먼트
--- 권한 : 특정 조작을 수행 할 수 있는 권리
--- 롤 : 여러 개의 권한을 모아 둔 것
--- QUOTA(테이블 스페이스의 할당 제한) : 테이블 스페이스 안에서 해당 계정이 사용할 수 있는 공간의 상한값, 특정 계정이 테이블 스페이스를 독점해 버리는 상황을 방지
--- 계정 프로파일 : 계정이 사용 할 수 있는 자원을 제한, 패스워드의 관리 정책을 규정
---- SESSION_PER_USER : 동시에 접속할 수 있는 세션 수 : 접속수
----  CONNECT_TIME :  세션의 최대 접속 허용 시간 : 분
---- IDLE_TIME : 세션에서 허용되는 최대 idle 시간 : 분
---- CPU_PER_SESSION : 한 세션이 사용 할수 있는 최대 CPU 시간 : 1/100초
---- CPU_PER_CALL : 한 SQL 이 사용 할 수 있는 최대 CPU 시간 : 1/100초
---- LOGICAL_READS_PER_SESSION : 한 세션이 읽어 올 수 있는 최대 논리 블록의 수 : 블록
---- LOGICAL_READS_PER_CALL : 한 호출당 읽어 올 수 있는 최대 논리 블록의 수 : 블록
---- PRIVATE_SGA : 공유 서버 구성에서 한 세션이 개별적으로 확보하는 메모리 영역(SGA 공유 풀 내)의 크기 : 바이트
---- FAILED_LOGIN_ATTEMPTS : 로그인 실패 허용 횟수, 초과하면 계정 잠김 : 횟수
---- PASSWORD_LIFE_TIME : 패스워드를 변경하지 않고 사용할 수 있는 기간 : 일
---- PASSWORD_REUSE_TIME : 현재 사용하고 있는 패스워드를 다음에 다시 사용할 수 있을 때까지의 기간 : 일
---- PASSWORD_REUSE_MAX : 현재 사용하고 있는 패스워드를 다음에 다시 사용할 수 있을때까지의 횟수 : 횟수
---- PASSWORD_LOCK_TIME : 로그인할 때 연속으로 암호가 틀릴 경우 계정을 잠금 기간 : 일
---- PASSWORD_GRACE_TIME : 패스워드의 사용 기한이 끝난 후에 주어지는 패스워드 사용 유예 기간, 유예 기간이 지난 후에 패스워드를 변경하지 않으면 로그인 할 수 없음
---- PASSWORD_VERIF_FUNCTION : 패스워드의 복잡함을 검증하는 스크립트 : 스크립트명

-- [2-2]
-- 계정 확인
SELECT USERNAME, ACCOUNT_STATUS ACCOUNT, DEFAULT_TABLESPACE DEFAULT_TS,
       TEMPORARY_TABLESPACE TEMP_TS, PROFILE
FROM   DBA_USERS;

-- [2-3]
-- QUOTA 확인
SELECT tablespace_name, userName, max_bytes
FROM   DBA_TS_QUOTAS;
--WHERE  username = '계정명';
--- username : QUOTA 가 할당된 계정명
--- max_bytes : 계정에 할당된 QUOTA 의 크기, 무제한 일때는 '-1'
--- 예제: 계정에 QUOTA가 10M 할당되어있을때
--- connect test/test
--- CREATE TABLE test1 (n varchar2(10)) STORAGE (INITIAL 10M);
--- CREATE TABLE test0 (n varchar2(10)) STORAGE (INITIAL 10M); --> 에러 발생 ORA-1536

-- [2-4]
-- 계정 프로파일 확인
-- RESOURCE_TYPE : 제한할때는 KERNEL, 패스워드 운용정책 때는 PASSWORD
SELECT profile, resource_name, resource_type, limit
FROM   DBA_PROFILES;

-- [2-5]
-- 권한 확인 : 오브젝트 권환 과 시스템 권한
--- 오브젝트 권한 : 특정 오브젝트에 관한 권한
-- 모든 오브젝트의 권한 확인
SELECT grantee, owner, table_name, grantor, privilege, grantable
FROM   DBA_TAB_PRIVS;
-- 계정의 오브젝트의 권한 확인
SELECT grantee, owner, table_name, grantor, privilege, grantable
FROM   USER_TAB_PRIVS;

-- 시스템 권한
--- 모든 시스테 권한 확인
SELECT grantee, privilege, admin_option FROM DBA_SYS_PRIVS;

--- 계정에 직접 할당돼 있는 시스템 권한을 확인
SELECT username, privilege, admin_option FROM USER_SYS_PRIVS;

--- 계정에 할당된 모든 시스템 권한
SELECT privilege FROM SESSION_PRIVS;

-- 일반 사용자 계정에도 SYSDBA 권한을 줄수는 있지만, AS SYSDBA, AS SYSOPER 로 접속해야하며, 접속후 SYS, PUBLIC 으로 변경이 되어 실제로 접속하는 계정이 다르게 된다.

-- 롤
-- [2-6] 롤 확인
SELECT role FROM DBA_ROLES;

-- [2-7]
-- 계정 또는 롤에 직업 부여된 롤 확인
-- grantee : granted_role (롤) 이 부여된 계정명과 롤
-- admin_option :  롤이 WITH ADMIN 옵션으로 부여됨 유무
SELECT grantee, granted_role, admin_option FROM DBA_ROLE_PRIVS;

-- [2-8]
-- 현재 계정에 직접적으로 부여된 롤 확인
SELECT username, granted_role, admin_option FROM USER_ROLE_PRIVS;

-- [2-9]
-- 현재 계정에 부여되 있는 모든 룰 확인
SELECT role FROM SESSION_ROLES;



-- [2-10] 테이블 관리
-- 여러 로우를 '영구 테이블 스페이스' 내 블록에 저장한다.
-- 블록에 저장은 가장 하단 부터 채워지며, PCTFREE, PCTUSED 에 의해 판단
-- PCTFREE : 블록 대비 로우를 저장 하는 비율
-- 세그먼트 공간 관리 방식 과 PCTUSED : 블록 내 로우 가 변경됬을때 다시 저장 하는 비율(정도)
-- 세그먼트 빈 공간 관리 방식 종류 FLM(Free List Management), ASSM(Automatic Segment Space Management)
--- FLM : PCTUSED 를 설정하고 사용률이 이 아래로 내려갈 때 데이터를 입력가능하게 한다. 수동, 10g2 미만, 'PARAMETER:SEGMENT SPACE MANAGEMENT:MANUAL'
--- ASSM : 자동으로 판단하고, 10gR2 이후 방식, 'PARAMETER:SEGMENT SPACE MANAGEMENT:AUTO'
SELECT tablespace_name, segment_space_management FROM DBA_TABLESPACES;

-- [2-11] 로우 마이그레이션과 로우 체이닝
-- SELECT table_name, chain_cnt FROM USER_TABLES WHERE table_name = <테이블명>;
-- 로우 마이그레이션
--- 세그만트 공간관리방식과 PCTUSED 에 의핸 빈공간은 블록 내 로우의 UPDATE 로 인한 데이터 크기거 커졌을때를 대비하기 위한 공간인데
--- 실제로 공간이 커졌을때, 다른 블록으로 로우를 이동시키면서 원래 로우에 이동시켜진 블록의 로우의 위치를 저장한 포인터를 저장한다. 
--- 읽어들일땐, 포인터를 가진 블록과 로우가 존재하는 블록을 읽어야하기때문에 마이그레이션이 자주발생하는 경우 속도가 느려진다.

-- 로우 체이닝
--- 로우의 크기가 블록의 크기보다 클때, 여러 블록에 나누어서 저장되는 형식이다. 
--- 이 때, 세그먼트 공간관리방식과 로우 마이그레이션의 방식이 적용된다.
--- PCTFREE 만큼 저장되고 다른블록으로 저장이될때, 포인터가 저장된다.

-- 세그먼트 공간 관리 방식 확인
SELECT table_name, chain_cnt FROM USER_TABLES;

-- 로우 마이그레이션과 로우 체이닝 확인
-- ANALYZE <테이블명>  COMPUTE STATISTICS;
-- SELECT table_name, chain_cnt FROM USER_TABLES WHERE table_name = <테이블명>;

-- 로우 마이그레이션 / 로우 체이닝이 발생한 로우를 확인
SELECT owner_name, table_name, head_rowid FROM chained_rows;

SELECT rowid, empno, ename FROM emp;

-- [2-11]
-- 로우 저장 블록은 저장 순서가 있는게 아니라 임의대로 저장된다. 그렇기 때문에 select 하면 정렬되지 않은 데이터가 보여진다.
-- rowid : 로우의 물리적인 위치를 표시하는 특수 식별자임
-- rowid = 파일번호 + 블록번호+로우번호+보조정보
-- SELECT rowid FROM <테이블명>;
-- rowid 를 이용한 검색이 가장빠르다

-- [2-12] 문자 세트 확인
SELECT * FROM V$NLS_PARAMETERS WHERE parameter LIKE '%CHARACTERSET';


-- [2-13] 테이블 확인
SELECT owner, table_name, tablespace_name, pct_free, pct_used FROM DBA_TABLES;

SELECT table_name, tablespace_name, pct_free, pct_used FROM USER_TABLES;

-- [2-14] 모든 컬럼에 관한 정보 확인
SELECT owner, table_name, column_name data_type, data_length, data_precision, data_scale, nullable, char_length, char_used
  FROM DBA_TAB_COLUMNS;
  
-- [2-15] 접속한 계정이 소유하는 테이블의 칼럼에 관한 정보 확인
-- data_precision 정밀도, data_scale 스케일, char_used 칼럼 길이를 지정하는 단위(바이트B, 문자C)
SELECT table_name, column_name data_type, data_length, data_precision, data_scale, nullable, char_length, char_used
  FROM USER_TAB_COLUMNS;
  
-- [2-16] 데이터베이스에 존재하는 제약 확인
SELECT owner, constraint_name, constraint_type, table_name, r_owner, r_constraint_name, index_owner, index_name
  FROM DBA_CONSTRAINTS;
  
-- [2-17] 접속한 계정이 소유한 제약 확인
-- constraint_type(C:heck, P:rimary key, U:nique key, R:Foreign key)
SELECT constraint_name, constraint_type, table_name, r_owner, r_constraint_name, index_owner, index_name
  FROM USER_CONSTRAINTS;
  
-- [2-18] 인덱스 [???]
--- 인덱스종류
--- NORMAL : B 트리 인덱스
--- BITMAP : 비트맵 인덱스
--- NORMAL/REV : 리버스 키 인덱스
--- FUNCTION-BASED NORMAL : B 트리 인덱스로 만들어진 함수 기반 인덱스
--- FUNCTION-BASED BITMAP : 비트맵 인덱스로 만들어진 함수 기반 인덱스
--- FUNCTION-BASED NORMAL/REV : 리버스 키 인덱스로 만들어진 함수 기반 인덱스
-- 데이터베이스 내에 존재하는 인덱스 확인
SELECT owner, index_name, index_type, uniqueness, table_owner, table_name, tablespace_name
  FROM DBA_INDEXES;
  
-- 접속한 계정이 소유하고 있는 인덱스 확인
SELECT index_name, index_type, uniqueness, table_owner, table_name
  FROM USER_INDEXES;
  
-- B 트리 인덱스가 생성된 칼럼의 확인
SELECT index_owner, index_name, table_name, column_name
  FROM DBA_IND_COLUMNS;
  
-- [2-19] OLTP 환경(OnLine Transaction Processing)
-- 실시간으로 데이터를 변경하는 트랜젝션을 여러 사용자가 동시에 수행함. 트랜젝션 데이터양은 비교적 적다.
-- 은행 거래 시스템, 항공 예약 시스템

-- [2-20] DW 환경(Data Warehouse)
-- 대량으로 축적된 데이터를 분석하는 쿼리가 수행. 실시간반영이 매우 적고, 주로 야간에 일괄처리를 함.
-- OLTP 에서 쌓인 데이터를 분석하기 위한 용으로 많이 사용

-- [3-1] 그 밖의 오브젝트


-- [3-2] 뷰
-- 데이터베이스 안의 뷰 확인
SELECT owner, view_name, text FROM DBA_VIEWS;

-- 접속한 계정이 소유한 뷰 확인
SELECT view_name, text FROM USER_VIEWS;

-- [3-3] MATERIALIZED VIEW 구체화된 뷰
--- 뷰와 다르게 자기자신이 조회한 데이터를 가지고있다. 그 테이블을 '디테일 테이블(마스터 테이블)' 이라함.
--- 보안성과 쿼리 간결화의 이점이있지만, MATERIALIZED VIEW 의 결과를 실제 테이블에 반영하기 위해선 리프레시를 해야한다.
--- ON COMMIT : 매번 커밋되는 점에서 성능이 저하될수있다.
--- ON DEMAND : 성능 저하는 없지만, 일일이 커밋해야 결과가 반영된다.

-- MATERIALIED VIEW 확인
SELECT owner, mview_name, query, refresh_mode FROM DBA_MVIEWS;

-- [3-4] SEQUENCE 시퀀스
--- 대량의 테이블데이터 시퀀스를 생성할때는 테이블에 LOCK 걸릴 수 있어 성능에 좋지 않다.

-- 시퀀스 확인
SELECT sequence_owner, sequence_name, min_value, increment_by
  FROM DBA_SEQUENCES;

-- [3-5] SYNONYM 시노님
-- 오브젝트의 별칭
-- 테이블이나 뷰, 시퀀스, 프로시저, 패키지등 여러가지를 시노님으로 정의할수있다.
-- 보아성과 조작성이 향상된다.

-- 시노님 확인
SELECT owner, synonym_name, table_owner, table_name FROM DBA_SYNONYMS;

-- [3-6] 오브젝트 저장 방시과 저장공간
-- 논리적인 공간에 일대일로 저장하는 세그먼트는 테이블과 인덱스와 일대일로존재하고
-- 테이블이있으면 세그먼트도 있다고보면된다.

-- [3-7]  데이터베이스 내의 세그먼트 정보 확인
SELECT owner, segment_name, segment_type, tablespace_name, bytes, blocks
  FROM DBA_SEGMENTS;
  
-- 접속한 계정이 소유한 세그먼트 정보 확인
SELECT segment_name, segment_type, tablespace_name, bytes, blocks
  FROM USER_SEGMENTS;
  
-- [3-8] 익스텐트 : 특정 데이터 파일안에 연속된 블록의 집합, 묶어 관리하는 것.
-- 데이터베이스 내의 익스텐트 확인
SELECT owner, segment_name, segment_type, tablespace_name, extent_id
  FROM DBA_EXTENTS;
  
-- 접속한 계정이 소유한 세그먼트의 익스텐트 정보확인
SELECT segment_name, segment_type, tablespace_name, extent_id
  FROM USER_EXTENTS;
  
-- [3-9] 익스텐트 자동관리방식
-- UNIFORM : 테이블 스페이스 내의 모든 익스텐트를 같는 크기로 관리하는 방식
-- AUTOALLOCATE , 초기 익스텐트 개수와 크기를 무시하며, 내부 알고리즘에 따라 자동으로 결정됨
-- 익스텐트 관리방식은 테이블 스페이스를 생성할 때 지정하고, 오브젝트를 생성할 때 사용자가 지정할 수 없다

-- [3-10] 익스텐트 추가할당
-- 오브젝트에 저장된 데이터가 많아 새로운 데이터를 세그먼트에 저장 할 수 없을때, 자동으로 익스텐트를 추가 할당해 세그먼트를 확장한다

-- [3-11] 익스텐트 할당 해제
-- 원칙적으로 한번 세그먼트에 할당되면 해당 세그먼트의 오브젝트를 제거할 때까지 테이블 스페이스에 반환하지 않지만,

-- TRUNCATE TABLE : 테이블 내의 모든 데이터가 삭제되며, 테이블을 생성했던 때의 최초 익스텐트 할당 상태로 줄어든다.
-- ALTER TABLE DEALLOCATE UNUSED : HWM 을 넘어서는 사용하지 ㅇ낳는 익스텐트를 해제한다.
-- ALTER TABLE SHRINK SPACE : 세그먼트 단편화를 해소하고 HM 을 낮추는 것으로 사용하지 않는 익스텐트를 해제함

-- [3-12] 세그먼트의 HWM : 이후의 블록은 모두 포맷되지 않은 DBA 
-- 세그먼트에 할당된 블록은 포맷된 블록과 비포맷 블록으로 나뉘고, 포맷된 블록에만 데이터가 저장된다.

-- [3-13] TRUNCATE TABLE 문
-- 테이블의 모든 데이터를 삭제하는 SQL문, 실행시 HWM 은 첫 번째 익스텐트의 시작 블록으로 이동하기 때문에 최초할당상태로 돌아간다

-- [3-14] ALTER TABLE DEALLOCATE UNUSED 문
-- HWM 을 넘어가는 포맷되지 않은 블록을 해제하는 SQL문
-- 로컬관리 테이블 스페이스의 경우(?????), 테이블 스페이스의 설정에 따라 오라클의 익스텐트 크기를 자동 관리하기 때문에 HWM을 넘어가는 모든 블록이 해제되는 것은 아니다.
-- HWM 을 넘어가는 익스텐트 중 모든 블록이 포맷되지 않은 익스텐트만 해제됨

-- [3-15] ALTER TABLE SHRINK SPACE 문
-- 세그먼트의 단편화를 해소하고 HWM 을 낮추며 HWM 이후의 사용되지 않은 익스텐트를 해제하는 SQL 문이다. 
-- 1. 세그먼트의 단편화를 해소하는 처리
-- 2. HWM 을 낮추고 사용되지 않은 익스텐트를 해제하는 처리





-- [4] SQL 처리 
-- [4-1] SQL 처리 절차
-- 1. 공유 풀 확인 -> SQL 검증 -> 실행 계획 생성 -> 분석된 SQL문을 공유 풀에 보관
-- 2. SQL 처리의 실행
-- 3. 데이터베이스 버퍼 캐시의 블록에서 로우를 가져옴

-- 옵티마이저 통계수집을 수동, 자동, 임시수집 방법으로 한다.
-- 테이블, 인덱스에서 통계를 내고 CBO, 예상비용을 산출한다.

-- [4-2] 분석이 끝난 SQL 정보 저장
-- 실행 가능한 SQL 과 실행 계획을 포함한 분석된 SQL 정보를 SGA 의 공유 풀 내부의 라이브러리 캐시에 저장
-- 대소문자, 띄어쓰기를 주의해야 한다.

-- [4-3] SQL실행 
-- INSERT, UPDATE, DELETE 는 데이터베이스 버퍼 캐시 의 블록이 실제로 변경
-- SELECT 는 로우를 마킹 처리만하고 로우 가져오기에서 수행함

-- [4-4] 로우 검색
-- SELECT 에서 마킹한 로우 데이터를 가져온다.
-- 일괄로 가져오는게 아니라 로우를 분할하여 가져온다. ORDER BY 를 수행

-- [4-5] 실행 계획 확인
-- 실행 계획 확인하기 SQL*PLUS AUTOTRACE 기능을 이용함.
-- SCOTT 세팅
-- EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS('SCOTT');
-- 실행 계획 표시하기 : SET AUTOTRACE ON EXPLAIN;
-- SELECT * FROM EMP0;

-- [4-6] 분석된 SQL 정보의 보관과 공유하기
-- SQL을 분석할 때 실행 계획인 만들어지고, 공유 풀에 저장된다. 확인해 보자
-- 실행 계획 관리
ALTER SYSTEM FLUSH SHARED_POOL; -- 공유풀 메모리 삭제
-- 공유 풀 내의 분석된 SQL의 정보 확인
SELECT sql_text FROM V$SQL WHERE sql_text = 'SELECT * FROM EMP0';

-- SQL문을 실행하여 하드 파싱 발생하기
-- 위에 EXECUTION PLAN 이 없는 것을 확인하고 다시 SQL 문을 실행해봅시다
SELECT * FROM EMP0;

-- [4-7] 데이터베이스 버퍼 캐시의 역할과 효과
-- 실행계획을 실행해 로우로 읽으려면 데이터 파일에서 블록을 가져와야한다.
-- SGA 의 데이터베이스 버퍼 캐시

-- 1. 최초 실행시
-- SELECT 실행 -> 블록 존재 유무 확인 -> 데이터 파일에서 블록을 가져와 블록을 데이터베이스 버퍼캐시에 저장
-- -> 버퍼 캐시에서 해당 블록을 읽음 -> 블록에서 로우를 졸비해 클라이언트 어플리케이션으로 전송

-- 2. 두번째 이후
-- 같은 SELECT 문 실행 -> 데이터베이스 버퍼 캐시에 필요한 블록이 존재하는지 확인 -> 읽음 -> 클라이언트로 전송

-- 여기서 두번째 이후로는 데이터베이스 파일에서 읽는 것보다 메모리에서 읽는 것이 빠르기 때문에,
-- 메모리의 크기를 높이는 것으로 성능을 향상 시킬수 잇다. 
-- 동일한 블록은 여러번 읽는건 한정되어있기 때문에 무작정 크기를 늘리는것은 방법이아니다
-- 계산해보기
--- 데이터전송속도 1.5Gb/S (약 190MB/s)
--- 회전수 7,200 RPM
--- 평균 탐색 시간 약 9ms
-- 8KB 데이터를 읽어 오는 시간은 ? 
--- 데이터 전송시간(8KB / 190MB/s = 43us) + 회전 대기 시간 (60초/ 7,200RPM / 2 = 4ms) + 평균 탐색시간
--- = 약 13ms
-- 일반적인 메모리의 8KB 전송 시간
--- 8KB / 19.2GB = 약0.4us(0.0004ms) 
-- 데이터 파일을 읽는 것과 메모리를 읽는 것은 약 30배 차이가 난다.

-- 데이터가 많아진 SQL SELECT 문을 실행해 통계를 보자
SELECT * FROM EMP1;
-- 2번 실행해보면 physical reads 부분이 0으로 줄어든 것을 볼 수 있다.


-- [4-8] 인덱스 효과
SET AUTOTRACE ON;
SELECT * FROM EMP1 WHERE EMPNO = '3';
-- * 표시와 Predicate Information 항목이 추가되었다.
-- B-TREE 인덱스가 적합하다.
-- 4-7과 4-8 에서는 CONSISTENT GETS 을 비교해보면, 87과 2 로 블록을 읽어오는 수가 감소했다.

-- [4-9] 정렬 수행과 PGA, 임시 테이블 스페이스
-- 회신하기전에 ORDER BY 로 정렬해야 할 때가 있다.

-- PGA와 임시 테이블 스페이스
-- 서버 프로세스는 정렬 작업을 수행 하는 경우 SQL Work Areas 또는 임시 테이블 스페이스를 사용한다.
-- SQL Work Areas 가 SQL 작업 수행에 필요한 크기보다 작을때 임시 테이블 스페이스가 사용된다.
-- 하지만 매우느리다.

-- SQL Work Areas 와 임시 테이블 스페이스와 차이점
-- 1. 정렬이 발생하지 않는 쿼리 (ORDER BY 절 없음)
SET AUTOTRACE TRACEONLY
SET TIMING ON
SELECT * FROM EMP1;
-- 0 sorts (memory), 0 sorts (disk) 로 정렬이 되지 않았다.

-- 2. 정렬 처리가 발생하는 쿼리 (메모리에서만 정렬)
SET AUTOTRACE TRACEONLY
SET TIMING ON
SELECT * FROM EMP1 ORDER BY ENAME;
-- 먼저 테이블 스캔 실행 후 정렬이 되었다(SORT ORDER BY)
-- 1 sorts (memory) 인 것으로보아 메모리(PGA)에서 정렬이 되었다.

-- 3. 정렬 처리가 발생하는 쿼리 (디스크에서 정렬)
-- PGA 크기를 초과하는 데이터 정렬을 할 때 디스크를 사용합니다.
-- PGA 는 오라클에서 자동으로 조정한다.
ALTER SESSION SET WORKAREA_SIZE_POLICY = MANUAL;
ALTER SESSION SET SORT_AREA_SIZE = 51200;
SET AUTOTRACE TRACEONLY;
SET TIMING ON;
SELECT * FROM EMP1 ORDER BY ENAME;
-- 실행계획에 SORT ORDER BY, 1 sorts (disk) 확인가능하다.