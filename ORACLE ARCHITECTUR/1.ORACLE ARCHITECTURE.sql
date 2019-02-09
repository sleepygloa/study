dhsmf z-- 1��
-- ���� ���� Ȯ��
-- [1-1]
SELECT SID, SERIAL#, PROGRAM, USERNAME, TYPE FROM V$SESSION;

-- ���ǰ� ���� ���μ��� Ȯ��
-- [1-2]
SELECT S.SID, S.SERIAL#, S.USERNAME, S.PROGRAM "PROGRAM(Client)", p.pid, p.spid, p.program "PROGRAM(Oracle)"
  FROM V$SESSION S, V$PROCESS P
 WHERE S.PADDR = P.ADDR
   AND p.background IS NULL;

-- ���̺� �����̽� Ȯ��(CONTENTS:����, UNDO, TEMP ����)
-- [1-3]
SELECT TABLESPACE_NAME, CONTENTS FROM DBA_TABLESPACES;

-- ����, UNDO ���̺� �����̽��� ������ ���� Ȯ��
-- TABLESPACE_NAME : ���� ���̺� �����̽���
-- FILE_NAME       : �����̸�
-- [1-4]
SELECT T.TABLESPACE_NAME, F.FILE_NAME
  FROM DBA_TABLESPACES T, DBA_DATA_FILES F
 WHERE T.TABLESPACE_NAME = F.TABLESPACE_NAME;

-- �ӽ� ���̺� �����̽� ������ ���� Ȯ��
-- [1-5]
SELECT T.TABLESPACE_NAME, F.FILE_NAME
  FROM DBA_TABLESPACES T, DBA_TEMP_FILES F
 WHERE T.TABLESPACE_NAME = F.TABLESPACE_NAME;

-- SGA�� �������� Ȯ��
-- �����ͺ��̽� ���� ĳ�� Ȯ��
-- Database Buffers Ȯ��
-- [1-6]
-- ����ĳ�� ũ�Ⱑ ũ��? --> ��ٷȴٰ� �ѹ��� ó���ϰԵ�(��� ����Ƚ�� �� ���(ó��)�ϰ� �Ǵ� Ƚ���� ������) --> �������
-- ����ĳ�� ũ�Ⱑ �۴�? --> ���� �̷��� ��������
SELECT * FROM V$SGA;

-- SGA�� ������ Ȯ��
-- buffer_cache ũ��
-- [1-7]
SELECT * FROM V$SGASTAT;

-- REDO TABLE ���� LGWR�� REDO �α� ������ �����͸� �ѹ��� REDO �α� ���Ϸ� �����´�.
-- LWGR --> REDO ��� ����
--- Ʈ������ Ŀ��
--- DBWn �� REDO ������ ���⸦ ��û�� �� (������  ���Ͽ� ����� ����� ����� �� ��)
--- 3�ʸ���
--- REDO �α� ������ �뷮�� ������ ���
--- ��������������� REDO �����Ͱ�  REDO �α� ���� ��ü ũ���� 1/3�� ����
-- REDO ���� ó�� ���� : �α� ���۰� �������� ����

-- REDO ������ �׷�ȭ�Ͽ� ������ �� �ִ�.
-- group# �αױ׷� ��ȣ, status ����, sequence ��������ȣ, members ���Ե� �����?
-- [1-8]
SELECT group#, status, sequence#, members FROM V$LOG;

-- �α�����Ȯ��
-- [1-9]
SELECT   V$LOG.group#, V$LOGFILE.member
FROM     V$LOG, V$LOGFILE
WHERE    V$LOG.group# = V$LOGFILE.group#
ORDER BY group#;

-- �������� �α׽���ġ �߻�
-- [1-10]
ALTER SYSTEM SWITCH LOGFILE;

-- ��ī�̺� �α� ��� Ȯ��
-- �����ͺ��̽��� REDO �����͸� ���� ���� ���� REDO �����͸� '��ī�̺� REDO �α� ����'�� ������ ����� REDO �����͸� �����ϴ� �۵����
-- ��� ���� �����ؾ��ϴ� ���� �߻���, ������� ��ī�̺� REDO �α� ������ �����ϴ� ������ �߻� �������� ���� �� �� ����.
-- [1-11]
ARCHIVE LOG LIST

-- ��ī�̺� �α� ��� Ȯ��2
-- name : �����ͺ��̽��̸�, log_mode : ARCHIVELOG/NOARCHIVELOG
SELECT name, log_mode FROM V$DATABASE;

-- ��ī�̺� �α� ���� ��ȯ
-- ORA-01126 �����ͺ��̽��� �� �ν��Ͻ����� ����Ʈ�Ǿ�� �ϰ� �ٸ� �ν��Ͻ����� ������ �ȵ�
--           database must be mounted in this instance and not open in any instance
-- [1-12]
ALTER DATABASE ARCHIVELOG;

ALTER DATABASE NOARCHIVELOG;

-- ��ī�̺� �α׸�� ��ȯ ����
-- [1-13]
SHUTDOWN IMMEDIATE;

STARTUP MOUNT;

ALTER DATABASE OPEN;

ARCHIVE LOG LIST;

SELECT name, log_mode FROM V$DATABASE;
-- ���� ��

-- ���� �ʱ� �Ķ���� Ȯ��
SHOW PARAMETERS buffer;

-- name : �ʱ�ȭ �Ķ���� ��Ī
-- type : �ʱ�ȭ �Ķ���� �� ����(Boolean, String, Integer, Parameter file, Reserved, Big Integer
-- value : ���� ����� ������
-- isdefault : �������� �⺻���϶�
-- isses_modifiable : ALTER SESSION ������ ���氡�� ��/�� --> true/false
-- issys_modifiable : �������� ��ú����Ҽ������� immediate
-- ���� ���ǿ� ����� �ʱ�ȭ �Ķ������ �� ����
SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$PARAMETER;

-- ���� �ν��Ͻ��� ����� �ʱ�ȭ �Ķ������ �� ����
SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$SYSTEM_PARAMETER;

SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$PARAMETER WHERE name LIKE '%buffer%';

SELECT  name, type, value, isdefault ISDEF,
        isses_modifiable SESMOD, issys_modifiable SYSMOD
FROM    V$SYSTEM_PARAMETER WHERE name LIKE '%buffer%';

-- ��Ʈ������
SELECT name FROM V$CONTROLFILE;

-- Ư�� ���μ������� ����ϴ� �޸𸮿���  : PGA(Program Global Area)
-- ���ΰԽ� ���� �����ϴ� �޸� ����    : SGA(System Global Area)

-- PGA�� PGA �� ������������
-- PGA�� SGA �� ������.

-- ���μ����� PGAȮ��
-- pid            : ����Ŭ ���ο��� �����ϴ� ���μ��� ID
-- spid           : OS������ ���μ��� ID
-- program        : ���α׷���Ī(���μ�����Ī)
-- background     : ������ ���� �������϶� 1
-- PGA_ALLOC_MEM  : ���μ����� ���� �Ҵ�� PGA�� ũ��
-- SGA : �������μ���(���� ���μ���)
-- [1-14]
SELECT pid, spid, program, background, pga_alloc_mem FROM V$PROCESS;

-- [1-15]
-- SGA ���� �����ʹ� ��� ���� ���μ��� �� ��׶��� ���μ����� ����
--     �ν��Ͻ��⵿�� Ȯ����
-- ����Ǯ : 3�� ĳ�� (LIBRARY ĳ��, DICTIONARY ĳ��, RESULT ĳ��)
-- ����Ǯ : ���μ����� ����� �ʿ��� Ư�� ó������ �ʿ��� �޸� ����
-- �ڹ�Ǯ : ����Ŭ JVM ���࿡ �ʿ��� ������ �����ϴ� �޸𸮿���
-- ��Ʈ�� Ǯ : STREAMS �� �����ϴµ� �ʿ��� ������ �����ϴ� �޸𸮿���
-- �����ͺ��̽� ���� ĳ�� : ����� �����ϴ� �޸� ���� ��Ͽ� ���� ĳ��, ���ۿ��ҵ� ��
-- REDO �α� ���� : REDO �α����Ͽ� ����������� �����͸� �����ϴ� ����

-- ����Ǯ : ������ ��� �̿��� ���� ������ �����͸� �ӽ÷� �����ϱ� ���� �޸� ����
--- ���� ������ LRU �� ���� ������.
--- ����Ǯ�� ���۴� ������ ����� �����ϳ� �̿��� �����͸� �����ϳ���
---- LIBRARY ĳ��    : �Ľ��� SQL����, �����ϵ� PL/SQL �ڵ�
---- DICTIONARY ĳ�� : ������ ��ųʸ����� ��ȸ�� ������(???)
---- RESULT ĳ��     : ������ ����� PL/SQL �Լ��� ���

--- LIBRARY ĳ�� : ù��° ����� SQL������ �Ľ��ϰ�, �ι�° ����� ���ʹ� �Ľ������ʰ� ó���ϰ� �ο츦 �����´�.(???) �Ľ̵Ǵ� ������?
--- DICTIONARY ĳ�� : (???) SYSTEM ���̺� �����̽��� �����, ���̺� �����̽��� ����Ǵ� DICTIONARY ������ DICTIONARY ĳ�ÿ� �����ϸ� �׼��� �� ���� �� �ִ�.(???) �����?
--- RESULT ĳ�� : 11G ���� ����, QUERY ����� ĳ�� �ϱ� ���ؼ��� 'PARAMETER:RESULT_CACHE_MODE:MANUAL' �����ϰ� SQL��Ʈ���� 'result cache' ��� �ϰų� �Ǵ� 'PARAMETER:RESULT_CACHE_MODE:AUTO' �� ����
 
-- ����Ǯ : ũ�Ⱑ ū �����͸� �ְ������ �̿��ϴ� �޸� ����
--- ���� ������ ����� ���� ���� �ٷ� ������. LRU ���� ����.
--- ���� ���� ���ӽ� ���� ���� ���μ����� ��� ó��
--- ���� ���� ����� QUERY COORDINATOR PROCESS�� PARALLEL SLAVE PROCESS ���� ��� ó��
--- RMAN �� ����� ���/������� ó�������� I/O SLAVE PROCESS���� ��� ó��

-- �ڹ�Ǯ : ����Ŭ JVM�� ������ �� ���
--- �ڹ����ν����� �����ϱ� ����

-- ��Ʈ�� Ǯ : ORACLE STREAMS, �޼��� ����� �����ϱ� ���� �޸� ����

-- [1-16]
-- �޸� ���� ���
--- AMM(Automatic Memory Management) : 11g ����, SGA, PGA �հ谡 'PARAMETER:MEMORY_TARGET' ���� ���� �ڵ� ������.
--- ASMM(Automatic Shared Memory Management) : 10g ����, �����ͺ��̽� ���� ĳ�ó� ����Ǯ ���� ũ�⸦ �ڵ�����.'PARAMETER:SGA_START' ���� ������ �ڵ�����.
---- ��� : ����Ǯ, ����Ǯ, �ڹ�Ǯ, �����ͺ��̽� ���� ĳ��, ��Ʈ��Ǯ(10g R2 ����)
---- �ʱ��Ķ���������� (SPFILE, PFILE) �̳Ŀ� ���� ������� ��⵿�� ����, �ʱ�ȭ ��
--- APMM(Automatic PGA Memory Management) : 9g ����, 'PARAMETER:WORKAREA_SIZE_POLICY:AUTO, PGA_AGGREGATE_TARGET' ���� ���� �ڵ�������.
---- �����Ǵ� PGA �� WORKAREA �� ������ ������ ���� �ȵǱ⶧���� TARGET SIZE���� Ŀ�����ִ�.

-- �����޸� ����
--- SQL Work Areas�� xxxx_AREA_SIZE�� �����ϴ� ���
--- �ִ�� �����ϰ������ WORKAREA_SIZE_POLICY:MANUAL, SORT_AREA_SIZE:1M ���� ����

-- [1-17]
-- SMON(System Monitor)
--- ���������� �ν��Ͻ��� ���¸� �����ϰ� �����ͺ��̽��� ���Ἲ�� ����, �����ϴ� ��׶��� ���μ���
---- �ν��Ͻ� �⵿ �� ������ �ʿ��ϸ� �ν��Ͻ� ���� ����
---- �� ����� �ӽ� ���׸�Ʈ�� ����(????) ���׸�Ʈ?
---- UNDO ���׸�Ʈ�� ���� ũ�Ⱑ Ŀ�� UNDO ��ũ��Ʈ�� ���

-- PMON(Process Monitor)
--- ���������� ���μ����� ���¸� �����ϰ� ���μ��� ó���� ���õ� ������ ���̽��� ���Ἲ�� ����, �����ϴ� ��׶��� ���μ���
---- Ŭ���̾�Ʈ ���ø����̼��� ������ ���� ������ ó�� �� �̾��� �� �����͸� �����ϰ� ����
---- ����ó ���μ����� ���� ���μ����� ���¸� ���������� üũ�ϰ� ������ ������ ���� ���νý��� �ִٸ� ��⵿
---- �ν��Ͻ� �� ����ó ���μ����� ���� ������ �����ʿ� ���

-- CKPT(Check Point)
--- �̺�Ʈ�� ���õ� ������ �� ���Ͽ� ����ϴ� ��׶��� ���μ���
---- üũ ����Ʈ�� �߻��ϸ� �����ͺ��̽��� ��� ������ ���ϰ� ��Ʈ�� ���Ͽ� üũ ����Ʈ�� ������ ���
---- ��Ʈ�� ���Ͽ� 3�ʸ��� REDO �α� ������ üũ ����Ʈ ��ġ�� ���� ������ ���.

-- ��׶��� ���μ��� Ȯ��
-- [1-18]
SELECT pid, spid, PROGRAM, background, pga_alloc_mem
FROM   V$PROCESS WHERE BACKGROUND = 1;

-- ��׶��� ���μ����� ������ ����
-- [1-19]
SELECT name, description FROM V$BGPROCESS;

-- �н����� ����
-- [1-20]
--- �н����� ���� ���� �̶� �Ҹ��� ���� ����� ����� �� �ʿ��� ���� �����͸� �����ϴ� ����
--- **. ������ ��ųʸ� ������ ���������� �����ͺ��̽����� �������⶧���� �ν��Ͻ� �⵿�� ���������� ����� �� ����.
--- **. SYSDBA ������ DBA������ �ν��Ͻ� �⵿�̵������� ���¿����� ����ó���ؾߵǹǷ�, �н�������������, OS������ ����� �� �ֵ��� �Ǿ��ִ�.
--- ���н�/������   : <ORACLE_HOME/dbs/orapw/<SID>
--- ������� ����Ŭ : <ORACLE_HOME>\database\pwd<SID>.ora

-- �α�����
-- [1-21]
-- ������ ����¸� Ȯ���Ҷ� �α� ���Ͽ� ��ϵ� ������ Ȯ�� �� ��� �м�

--- ALERT �α�
---- �����ͺ��̽� � �߿� �߻��ϴ� �ɰ��� �����Ӿƴ϶�, �⵿, ���� ���� ���� �۾��� ���� �߿��� ������ ��µǴ� �ؽ�Ʈ ������ �α�����
---- ���ϸ� : alert_<ORACLE_SID>.log
---- ��ġ  : 10g - �ʱ��Ķ���� 'PARAMETER:BACKGROUND_DUMP_DEST'
---- ��ġ  : 11g - ADR_HOME �Ʒ� TRACE�� ���
---- ����
----- �ν��Ͻ��� �⵿�� ���� �帧�� �⺻���� �ƴ� �ʱ�ȭ �Ķ���Ͱ�
----- �ν��Ͻ��� ������ ���� �帧
----- �߻��� ��� ORA-00600����, ��ϰ� ���õ� ORA-1578���� �� deadlock ���� ORA-00060 ����, �� ���� �ɰ��� ����
----- ������ ���̽��� ���� ���� ��ɾ�� ���� ���(SQL���� CREATE/ALTER/DROP DATABASE/TABLESPACE ��ARCHIVE LOG�� ���, ���� ó����)
----- materialized view �� �ڵ� ���Ž� �߻��ϴ� ����
----- (????) cat �̳� tail�� Ȱ���� �ý��� �м� Ȱ�뿡 �����Ű���

--- Ʈ���̽� ����
---- Ʈ���̽� ������ ���� ���μ����� ��׶��� ���μ��� �� ���� ���νý��� ���� ������ ���� ���� ������ ��µǴ� �ؽ�Ʈ����
---- �ɰ��� ���� �߻� ��, ALERT �α׿� ���� ��ȣ, ���ÿ� Ʈ���̽����Ͽ� ���� ��µ�(���μ��� ��Ī, ���μ��� PID)
---- ��ġ  : 10g - ����      ���μ����� Ʈ���̽� ������ �ʱ��Ķ���� 'PARAMETER:USER_DUMP_DEST' �� ������ ���丮�� ���
----              ��׶��� ���μ����� Ʈ���̽� ������ �ʱ��Ķ���� 'PARAMETER:BACKGROUND_DUMP_DEST' �� ������ ���丮�� ���
---- ��ġ  : 11g - ����, ��׶��� ��� ADR_HOME �Ʒ� trace ���͸� Ʈ���̽� ������ ���

--- Net Services ���� �α�
---- ��Ʈ��ũ�� ���� �ν��Ͻ��� �����Ҷ� Net Services SW�� ����ϴµ� ���� ��� ���� ������ �м��Ҷ� �α�����

-- [1-22]
-- ������ ��ųʸ� ��� ���� ���� ��
--- ������ ��ųʸ� �� : ����Ŭ ������ ���� ������ �����ϴ� Ư���� �б� ���� ��
--- SYS ���� ����
--- ���ʿ� ��ųʸ� ���̺� ���� ���� ���� ���ѿ��� �Ժη� ������ �� ����, �Ŵ���������� ����

-- [1-23]
-- ���� ���� ��
--- ����Ŭ�� ���� ���¿����� ������ ���������� ���ϴ� ���� ��������� ���ۻ��¸� Ȯ�� �� �� �ִ� ��ȸ ���� ��
---- ���� �������
---- ���μ���, ���� �޷θ� ������ ����
---- �� �� ����Ŭ�� ���� ���¿� ���� ����


-- [2]
-- ������ ����

-- [2-1]
-- ��Ű�� : ������ �����ϴ� ���̺��̳� �ε��� ���� ������Ʈ�� �����ϴ� ������ �����̳�
-- �������� ��� : ������ ��ųʸ��� ����ǹǷ� ����� �� ������, ���������� ����� DDL �̳� DBMS_METADATA ��Ű���� ����� DDL ����
-- ���� �Ӽ�
--- DEFAULT ���̺� �����̽� : ������Ʈ�� ���� �� �� ������ ���̺� �����̽��� �������� �ʾ����� ����Ǵ� ���̺� �����̽�
--- DEFAULT �ӽ� ���̺� �����̽� : SQL ���� �� �ӽ� ���׸�Ʈ�� �ʿ��� �� �ӽ� ���׸�Ʈ�� Ȯ���ϱ� ���� ���̺� �����̽�(????) ���׸�Ʈ
--- ���� : Ư�� ������ ���� �� �� �ִ� �Ǹ�
--- �� : ���� ���� ������ ��� �� ��
--- QUOTA(���̺� �����̽��� �Ҵ� ����) : ���̺� �����̽� �ȿ��� �ش� ������ ����� �� �ִ� ������ ���Ѱ�, Ư�� ������ ���̺� �����̽��� ������ ������ ��Ȳ�� ����
--- ���� �������� : ������ ��� �� �� �ִ� �ڿ��� ����, �н������� ���� ��å�� ����
---- SESSION_PER_USER : ���ÿ� ������ �� �ִ� ���� �� : ���Ӽ�
----  CONNECT_TIME :  ������ �ִ� ���� ��� �ð� : ��
---- IDLE_TIME : ���ǿ��� ���Ǵ� �ִ� idle �ð� : ��
---- CPU_PER_SESSION : �� ������ ��� �Ҽ� �ִ� �ִ� CPU �ð� : 1/100��
---- CPU_PER_CALL : �� SQL �� ��� �� �� �ִ� �ִ� CPU �ð� : 1/100��
---- LOGICAL_READS_PER_SESSION : �� ������ �о� �� �� �ִ� �ִ� �� ����� �� : ���
---- LOGICAL_READS_PER_CALL : �� ȣ��� �о� �� �� �ִ� �ִ� �� ����� �� : ���
---- PRIVATE_SGA : ���� ���� �������� �� ������ ���������� Ȯ���ϴ� �޸� ����(SGA ���� Ǯ ��)�� ũ�� : ����Ʈ
---- FAILED_LOGIN_ATTEMPTS : �α��� ���� ��� Ƚ��, �ʰ��ϸ� ���� ��� : Ƚ��
---- PASSWORD_LIFE_TIME : �н����带 �������� �ʰ� ����� �� �ִ� �Ⱓ : ��
---- PASSWORD_REUSE_TIME : ���� ����ϰ� �ִ� �н����带 ������ �ٽ� ����� �� ���� �������� �Ⱓ : ��
---- PASSWORD_REUSE_MAX : ���� ����ϰ� �ִ� �н����带 ������ �ٽ� ����� �� ������������ Ƚ�� : Ƚ��
---- PASSWORD_LOCK_TIME : �α����� �� �������� ��ȣ�� Ʋ�� ��� ������ ��� �Ⱓ : ��
---- PASSWORD_GRACE_TIME : �н������� ��� ������ ���� �Ŀ� �־����� �н����� ��� ���� �Ⱓ, ���� �Ⱓ�� ���� �Ŀ� �н����带 �������� ������ �α��� �� �� ����
---- PASSWORD_VERIF_FUNCTION : �н������� �������� �����ϴ� ��ũ��Ʈ : ��ũ��Ʈ��

-- [2-2]
-- ���� Ȯ��
SELECT USERNAME, ACCOUNT_STATUS ACCOUNT, DEFAULT_TABLESPACE DEFAULT_TS,
       TEMPORARY_TABLESPACE TEMP_TS, PROFILE
FROM   DBA_USERS;

-- [2-3]
-- QUOTA Ȯ��
SELECT tablespace_name, userName, max_bytes
FROM   DBA_TS_QUOTAS;
--WHERE  username = '������';
--- username : QUOTA �� �Ҵ�� ������
--- max_bytes : ������ �Ҵ�� QUOTA �� ũ��, ������ �϶��� '-1'
--- ����: ������ QUOTA�� 10M �Ҵ�Ǿ�������
--- connect test/test
--- CREATE TABLE test1 (n varchar2(10)) STORAGE (INITIAL 10M);
--- CREATE TABLE test0 (n varchar2(10)) STORAGE (INITIAL 10M); --> ���� �߻� ORA-1536

-- [2-4]
-- ���� �������� Ȯ��
-- RESOURCE_TYPE : �����Ҷ��� KERNEL, �н����� �����å ���� PASSWORD
SELECT profile, resource_name, resource_type, limit
FROM   DBA_PROFILES;

-- [2-5]
-- ���� Ȯ�� : ������Ʈ ��ȯ �� �ý��� ����
--- ������Ʈ ���� : Ư�� ������Ʈ�� ���� ����
-- ��� ������Ʈ�� ���� Ȯ��
SELECT grantee, owner, table_name, grantor, privilege, grantable
FROM   DBA_TAB_PRIVS;
-- ������ ������Ʈ�� ���� Ȯ��
SELECT grantee, owner, table_name, grantor, privilege, grantable
FROM   USER_TAB_PRIVS;

-- �ý��� ����
--- ��� �ý��� ���� Ȯ��
SELECT grantee, privilege, admin_option FROM DBA_SYS_PRIVS;

--- ������ ���� �Ҵ�� �ִ� �ý��� ������ Ȯ��
SELECT username, privilege, admin_option FROM USER_SYS_PRIVS;

--- ������ �Ҵ�� ��� �ý��� ����
SELECT privilege FROM SESSION_PRIVS;

-- �Ϲ� ����� �������� SYSDBA ������ �ټ��� ������, AS SYSDBA, AS SYSOPER �� �����ؾ��ϸ�, ������ SYS, PUBLIC ���� ������ �Ǿ� ������ �����ϴ� ������ �ٸ��� �ȴ�.

-- ��
-- [2-6] �� Ȯ��
SELECT role FROM DBA_ROLES;

-- [2-7]
-- ���� �Ǵ� �ѿ� ���� �ο��� �� Ȯ��
-- grantee : granted_role (��) �� �ο��� ������� ��
-- admin_option :  ���� WITH ADMIN �ɼ����� �ο��� ����
SELECT grantee, granted_role, admin_option FROM DBA_ROLE_PRIVS;

-- [2-8]
-- ���� ������ ���������� �ο��� �� Ȯ��
SELECT username, granted_role, admin_option FROM USER_ROLE_PRIVS;

-- [2-9]
-- ���� ������ �ο��� �ִ� ��� �� Ȯ��
SELECT role FROM SESSION_ROLES;



-- [2-10] ���̺� ����
-- ���� �ο츦 '���� ���̺� �����̽�' �� ��Ͽ� �����Ѵ�.
-- ��Ͽ� ������ ���� �ϴ� ���� ä������, PCTFREE, PCTUSED �� ���� �Ǵ�
-- PCTFREE : ��� ��� �ο츦 ���� �ϴ� ����
-- PCTUSED : ��� �� �ο� �� ��������� �ٽ� ���� �ϴ� ����(����)

