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
