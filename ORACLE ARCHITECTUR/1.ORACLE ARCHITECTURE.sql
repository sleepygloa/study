dhsmf z-- 1장
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
-- PCTUSED : 블록 내 로우 가 변경됬을때 다시 저장 하는 비율(정도)

