-- 1��
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
-- ���׸�Ʈ ���� ���� ��� �� PCTUSED : ��� �� �ο� �� ��������� �ٽ� ���� �ϴ� ����(����)
-- ���׸�Ʈ �� ���� ���� ��� ���� FLM(Free List Management), ASSM(Automatic Segment Space Management)
--- FLM : PCTUSED �� �����ϰ� ������ �� �Ʒ��� ������ �� �����͸� �Է°����ϰ� �Ѵ�. ����, 10g2 �̸�, 'PARAMETER:SEGMENT SPACE MANAGEMENT:MANUAL'
--- ASSM : �ڵ����� �Ǵ��ϰ�, 10gR2 ���� ���, 'PARAMETER:SEGMENT SPACE MANAGEMENT:AUTO'
SELECT tablespace_name, segment_space_management FROM DBA_TABLESPACES;

-- [2-11] �ο� ���̱׷��̼ǰ� �ο� ü�̴�
-- SELECT table_name, chain_cnt FROM USER_TABLES WHERE table_name = <���̺��>;
-- �ο� ���̱׷��̼�
--- ���׸�Ʈ ����������İ� PCTUSED �� ���� ������� ��� �� �ο��� UPDATE �� ���� ������ ũ��� Ŀ�������� ����ϱ� ���� �����ε�
--- ������ ������ Ŀ������, �ٸ� ������� �ο츦 �̵���Ű�鼭 ���� �ο쿡 �̵������� ����� �ο��� ��ġ�� ������ �����͸� �����Ѵ�. 
--- �о���϶�, �����͸� ���� ��ϰ� �ο찡 �����ϴ� ����� �о���ϱ⶧���� ���̱׷��̼��� ���ֹ߻��ϴ� ��� �ӵ��� ��������.

-- �ο� ü�̴�
--- �ο��� ũ�Ⱑ ����� ũ�⺸�� Ŭ��, ���� ��Ͽ� ����� ����Ǵ� �����̴�. 
--- �� ��, ���׸�Ʈ ����������İ� �ο� ���̱׷��̼��� ����� ����ȴ�.
--- PCTFREE ��ŭ ����ǰ� �ٸ�������� �����̵ɶ�, �����Ͱ� ����ȴ�.

-- ���׸�Ʈ ���� ���� ��� Ȯ��
SELECT table_name, chain_cnt FROM USER_TABLES;

-- �ο� ���̱׷��̼ǰ� �ο� ü�̴� Ȯ��
-- ANALYZE <���̺��>  COMPUTE STATISTICS;
-- SELECT table_name, chain_cnt FROM USER_TABLES WHERE table_name = <���̺��>;

-- �ο� ���̱׷��̼� / �ο� ü�̴��� �߻��� �ο츦 Ȯ��
SELECT owner_name, table_name, head_rowid FROM chained_rows;

SELECT rowid, empno, ename FROM emp;

-- [2-11]
-- �ο� ���� ����� ���� ������ �ִ°� �ƴ϶� ���Ǵ�� ����ȴ�. �׷��� ������ select �ϸ� ���ĵ��� ���� �����Ͱ� ��������.
-- rowid : �ο��� �������� ��ġ�� ǥ���ϴ� Ư�� �ĺ�����
-- rowid = ���Ϲ�ȣ + ��Ϲ�ȣ+�ο��ȣ+��������
-- SELECT rowid FROM <���̺��>;
-- rowid �� �̿��� �˻��� ���������

-- [2-12] ���� ��Ʈ Ȯ��
SELECT * FROM V$NLS_PARAMETERS WHERE parameter LIKE '%CHARACTERSET';


-- [2-13] ���̺� Ȯ��
SELECT owner, table_name, tablespace_name, pct_free, pct_used FROM DBA_TABLES;

SELECT table_name, tablespace_name, pct_free, pct_used FROM USER_TABLES;

-- [2-14] ��� �÷��� ���� ���� Ȯ��
SELECT owner, table_name, column_name data_type, data_length, data_precision, data_scale, nullable, char_length, char_used
  FROM DBA_TAB_COLUMNS;
  
-- [2-15] ������ ������ �����ϴ� ���̺��� Į���� ���� ���� Ȯ��
-- data_precision ���е�, data_scale ������, char_used Į�� ���̸� �����ϴ� ����(����ƮB, ����C)
SELECT table_name, column_name data_type, data_length, data_precision, data_scale, nullable, char_length, char_used
  FROM USER_TAB_COLUMNS;
  
-- [2-16] �����ͺ��̽��� �����ϴ� ���� Ȯ��
SELECT owner, constraint_name, constraint_type, table_name, r_owner, r_constraint_name, index_owner, index_name
  FROM DBA_CONSTRAINTS;
  
-- [2-17] ������ ������ ������ ���� Ȯ��
-- constraint_type(C:heck, P:rimary key, U:nique key, R:Foreign key)
SELECT constraint_name, constraint_type, table_name, r_owner, r_constraint_name, index_owner, index_name
  FROM USER_CONSTRAINTS;
  
-- [2-18] �ε��� [???]
--- �ε�������
--- NORMAL : B Ʈ�� �ε���
--- BITMAP : ��Ʈ�� �ε���
--- NORMAL/REV : ������ Ű �ε���
--- FUNCTION-BASED NORMAL : B Ʈ�� �ε����� ������� �Լ� ��� �ε���
--- FUNCTION-BASED BITMAP : ��Ʈ�� �ε����� ������� �Լ� ��� �ε���
--- FUNCTION-BASED NORMAL/REV : ������ Ű �ε����� ������� �Լ� ��� �ε���
-- �����ͺ��̽� ���� �����ϴ� �ε��� Ȯ��
SELECT owner, index_name, index_type, uniqueness, table_owner, table_name, tablespace_name
  FROM DBA_INDEXES;
  
-- ������ ������ �����ϰ� �ִ� �ε��� Ȯ��
SELECT index_name, index_type, uniqueness, table_owner, table_name
  FROM USER_INDEXES;
  
-- B Ʈ�� �ε����� ������ Į���� Ȯ��
SELECT index_owner, index_name, table_name, column_name
  FROM DBA_IND_COLUMNS;
  
-- [2-19] OLTP ȯ��(OnLine Transaction Processing)
-- �ǽð����� �����͸� �����ϴ� Ʈ�������� ���� ����ڰ� ���ÿ� ������. Ʈ������ �����;��� ���� ����.
-- ���� �ŷ� �ý���, �װ� ���� �ý���

-- [2-20] DW ȯ��(Data Warehouse)
-- �뷮���� ������ �����͸� �м��ϴ� ������ ����. �ǽð��ݿ��� �ſ� ����, �ַ� �߰��� �ϰ�ó���� ��.
-- OLTP ���� ���� �����͸� �м��ϱ� ���� ������ ���� ���

-- [3-1] �� ���� ������Ʈ


-- [3-2] ��
-- �����ͺ��̽� ���� �� Ȯ��
SELECT owner, view_name, text FROM DBA_VIEWS;

-- ������ ������ ������ �� Ȯ��
SELECT view_name, text FROM USER_VIEWS;

-- [3-3] MATERIALIZED VIEW ��üȭ�� ��
--- ��� �ٸ��� �ڱ��ڽ��� ��ȸ�� �����͸� �������ִ�. �� ���̺��� '������ ���̺�(������ ���̺�)' �̶���.
--- ���ȼ��� ���� ����ȭ�� ������������, MATERIALIZED VIEW �� ����� ���� ���̺� �ݿ��ϱ� ���ؼ� �������ø� �ؾ��Ѵ�.
--- ON COMMIT : �Ź� Ŀ�ԵǴ� ������ ������ ���ϵɼ��ִ�.
--- ON DEMAND : ���� ���ϴ� ������, ������ Ŀ���ؾ� ����� �ݿ��ȴ�.

-- MATERIALIED VIEW Ȯ��
SELECT owner, mview_name, query, refresh_mode FROM DBA_MVIEWS;

-- [3-4] SEQUENCE ������
--- �뷮�� ���̺����� �������� �����Ҷ��� ���̺� LOCK �ɸ� �� �־� ���ɿ� ���� �ʴ�.

-- ������ Ȯ��
SELECT sequence_owner, sequence_name, min_value, increment_by
  FROM DBA_SEQUENCES;

-- [3-5] SYNONYM �ó��
-- ������Ʈ�� ��Ī
-- ���̺��̳� ��, ������, ���ν���, ��Ű���� ���������� �ó������ �����Ҽ��ִ�.
-- ���Ƽ��� ���ۼ��� ���ȴ�.

-- �ó�� Ȯ��
SELECT owner, synonym_name, table_owner, table_name FROM DBA_SYNONYMS;

-- [3-6] ������Ʈ ���� ��ð� �������
-- ������ ������ �ϴ��Ϸ� �����ϴ� ���׸�Ʈ�� ���̺�� �ε����� �ϴ��Ϸ������ϰ�
-- ���̺��������� ���׸�Ʈ�� �ִٰ���ȴ�.

-- [3-7]  �����ͺ��̽� ���� ���׸�Ʈ ���� Ȯ��
SELECT owner, segment_name, segment_type, tablespace_name, bytes, blocks
  FROM DBA_SEGMENTS;
  
-- ������ ������ ������ ���׸�Ʈ ���� Ȯ��
SELECT segment_name, segment_type, tablespace_name, bytes, blocks
  FROM USER_SEGMENTS;
  
-- [3-8] �ͽ���Ʈ : Ư�� ������ ���Ͼȿ� ���ӵ� ����� ����, ���� �����ϴ� ��.
-- �����ͺ��̽� ���� �ͽ���Ʈ Ȯ��
SELECT owner, segment_name, segment_type, tablespace_name, extent_id
  FROM DBA_EXTENTS;
  
-- ������ ������ ������ ���׸�Ʈ�� �ͽ���Ʈ ����Ȯ��
SELECT segment_name, segment_type, tablespace_name, extent_id
  FROM USER_EXTENTS;
  
-- [3-9] �ͽ���Ʈ �ڵ��������
-- UNIFORM : ���̺� �����̽� ���� ��� �ͽ���Ʈ�� ���� ũ��� �����ϴ� ���
-- AUTOALLOCATE , �ʱ� �ͽ���Ʈ ������ ũ�⸦ �����ϸ�, ���� �˰��� ���� �ڵ����� ������
-- �ͽ���Ʈ ��������� ���̺� �����̽��� ������ �� �����ϰ�, ������Ʈ�� ������ �� ����ڰ� ������ �� ����

-- [3-10] �ͽ���Ʈ �߰��Ҵ�
-- ������Ʈ�� ����� �����Ͱ� ���� ���ο� �����͸� ���׸�Ʈ�� ���� �� �� ������, �ڵ����� �ͽ���Ʈ�� �߰� �Ҵ��� ���׸�Ʈ�� Ȯ���Ѵ�

-- [3-11] �ͽ���Ʈ �Ҵ� ����
-- ��Ģ������ �ѹ� ���׸�Ʈ�� �Ҵ�Ǹ� �ش� ���׸�Ʈ�� ������Ʈ�� ������ ������ ���̺� �����̽��� ��ȯ���� ������,

-- TRUNCATE TABLE : ���̺� ���� ��� �����Ͱ� �����Ǹ�, ���̺��� �����ߴ� ���� ���� �ͽ���Ʈ �Ҵ� ���·� �پ���.
-- ALTER TABLE DEALLOCATE UNUSED : HWM �� �Ѿ�� ������� ������ �ͽ���Ʈ�� �����Ѵ�.
-- ALTER TABLE SHRINK SPACE : ���׸�Ʈ ����ȭ�� �ؼ��ϰ� HM �� ���ߴ� ������ ������� �ʴ� �ͽ���Ʈ�� ������

-- [3-12] ���׸�Ʈ�� HWM : ������ ����� ��� ���˵��� ���� DBA 
-- ���׸�Ʈ�� �Ҵ�� ����� ���˵� ��ϰ� ������ ������� ������, ���˵� ��Ͽ��� �����Ͱ� ����ȴ�.

-- [3-13] TRUNCATE TABLE ��
-- ���̺��� ��� �����͸� �����ϴ� SQL��, ����� HWM �� ù ��° �ͽ���Ʈ�� ���� ������� �̵��ϱ� ������ �����Ҵ���·� ���ư���

-- [3-14] ALTER TABLE DEALLOCATE UNUSED ��
-- HWM �� �Ѿ�� ���˵��� ���� ����� �����ϴ� SQL��
-- ���ð��� ���̺� �����̽��� ���(?????), ���̺� �����̽��� ������ ���� ����Ŭ�� �ͽ���Ʈ ũ�⸦ �ڵ� �����ϱ� ������ HWM�� �Ѿ�� ��� ����� �����Ǵ� ���� �ƴϴ�.
-- HWM �� �Ѿ�� �ͽ���Ʈ �� ��� ����� ���˵��� ���� �ͽ���Ʈ�� ������

-- [3-15] ALTER TABLE SHRINK SPACE ��
-- ���׸�Ʈ�� ����ȭ�� �ؼ��ϰ� HWM �� ���߸� HWM ������ ������ ���� �ͽ���Ʈ�� �����ϴ� SQL ���̴�. 
-- 1. ���׸�Ʈ�� ����ȭ�� �ؼ��ϴ� ó��
-- 2. HWM �� ���߰� ������ ���� �ͽ���Ʈ�� �����ϴ� ó��





-- [4] SQL ó�� 
-- [4-1] SQL ó�� ����
-- 1. ���� Ǯ Ȯ�� -> SQL ���� -> ���� ��ȹ ���� -> �м��� SQL���� ���� Ǯ�� ����
-- 2. SQL ó���� ����
-- 3. �����ͺ��̽� ���� ĳ���� ��Ͽ��� �ο츦 ������

-- ��Ƽ������ �������� ����, �ڵ�, �ӽü��� ������� �Ѵ�.
-- ���̺�, �ε������� ��踦 ���� CBO, �������� �����Ѵ�.

-- [4-2] �м��� ���� SQL ���� ����
-- ���� ������ SQL �� ���� ��ȹ�� ������ �м��� SQL ������ SGA �� ���� Ǯ ������ ���̺귯�� ĳ�ÿ� ����
-- ��ҹ���, ���⸦ �����ؾ� �Ѵ�.

-- [4-3] SQL���� 
-- INSERT, UPDATE, DELETE �� �����ͺ��̽� ���� ĳ�� �� ����� ������ ����
-- SELECT �� �ο츦 ��ŷ ó�����ϰ� �ο� �������⿡�� ������

-- [4-4] �ο� �˻�
-- SELECT ���� ��ŷ�� �ο� �����͸� �����´�.
-- �ϰ��� �������°� �ƴ϶� �ο츦 �����Ͽ� �����´�. ORDER BY �� ����

-- [4-5] ���� ��ȹ Ȯ��
-- ���� ��ȹ Ȯ���ϱ� SQL*PLUS AUTOTRACE ����� �̿���.
-- SCOTT ����
-- EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS('SCOTT');
-- ���� ��ȹ ǥ���ϱ� : SET AUTOTRACE ON EXPLAIN;
-- SELECT * FROM EMP0;

-- [4-6] �м��� SQL ������ ������ �����ϱ�
-- SQL�� �м��� �� ���� ��ȹ�� ���������, ���� Ǯ�� ����ȴ�. Ȯ���� ����
-- ���� ��ȹ ����
ALTER SYSTEM FLUSH SHARED_POOL; -- ����Ǯ �޸� ����
-- ���� Ǯ ���� �м��� SQL�� ���� Ȯ��
SELECT sql_text FROM V$SQL WHERE sql_text = 'SELECT * FROM EMP0';

-- SQL���� �����Ͽ� �ϵ� �Ľ� �߻��ϱ�
-- ���� EXECUTION PLAN �� ���� ���� Ȯ���ϰ� �ٽ� SQL ���� �����غ��ô�
SELECT * FROM EMP0;

-- [4-7] �����ͺ��̽� ���� ĳ���� ���Ұ� ȿ��
-- �����ȹ�� ������ �ο�� �������� ������ ���Ͽ��� ����� �����;��Ѵ�.
-- SGA �� �����ͺ��̽� ���� ĳ��

-- 1. ���� �����
-- SELECT ���� -> ��� ���� ���� Ȯ�� -> ������ ���Ͽ��� ����� ������ ����� �����ͺ��̽� ����ĳ�ÿ� ����
-- -> ���� ĳ�ÿ��� �ش� ����� ���� -> ��Ͽ��� �ο츦 ������ Ŭ���̾�Ʈ ���ø����̼����� ����

-- 2. �ι�° ����
-- ���� SELECT �� ���� -> �����ͺ��̽� ���� ĳ�ÿ� �ʿ��� ����� �����ϴ��� Ȯ�� -> ���� -> Ŭ���̾�Ʈ�� ����

-- ���⼭ �ι�° ���ķδ� �����ͺ��̽� ���Ͽ��� �д� �ͺ��� �޸𸮿��� �д� ���� ������ ������,
-- �޸��� ũ�⸦ ���̴� ������ ������ ��� ��ų�� �մ�. 
-- ������ ����� ������ �д°� �����Ǿ��ֱ� ������ ������ ũ�⸦ �ø��°��� ����̾ƴϴ�
-- ����غ���
--- ���������ۼӵ� 1.5Gb/S (�� 190MB/s)
--- ȸ���� 7,200 RPM
--- ��� Ž�� �ð� �� 9ms
-- 8KB �����͸� �о� ���� �ð��� ? 
--- ������ ���۽ð�(8KB / 190MB/s = 43us) + ȸ�� ��� �ð� (60��/ 7,200RPM / 2 = 4ms) + ��� Ž���ð�
--- = �� 13ms
-- �Ϲ����� �޸��� 8KB ���� �ð�
--- 8KB / 19.2GB = ��0.4us(0.0004ms) 
-- ������ ������ �д� �Ͱ� �޸𸮸� �д� ���� �� 30�� ���̰� ����.

-- �����Ͱ� ������ SQL SELECT ���� ������ ��踦 ����
SELECT * FROM EMP1;
-- 2�� �����غ��� physical reads �κ��� 0���� �پ�� ���� �� �� �ִ�.


-- [4-8] �ε��� ȿ��
SET AUTOTRACE ON;
SELECT * FROM EMP1 WHERE EMPNO = '3';
-- * ǥ�ÿ� Predicate Information �׸��� �߰��Ǿ���.
-- B-TREE �ε����� �����ϴ�.
-- 4-7�� 4-8 ������ CONSISTENT GETS �� ���غ���, 87�� 2 �� ����� �о���� ���� �����ߴ�.

-- [4-9] ���� ����� PGA, �ӽ� ���̺� �����̽�
-- ȸ���ϱ����� ORDER BY �� �����ؾ� �� ���� �ִ�.

-- PGA�� �ӽ� ���̺� �����̽�
-- ���� ���μ����� ���� �۾��� ���� �ϴ� ��� SQL Work Areas �Ǵ� �ӽ� ���̺� �����̽��� ����Ѵ�.
-- SQL Work Areas �� SQL �۾� ���࿡ �ʿ��� ũ�⺸�� ������ �ӽ� ���̺� �����̽��� ���ȴ�.
-- ������ �ſ������.

-- SQL Work Areas �� �ӽ� ���̺� �����̽��� ������
-- 1. ������ �߻����� �ʴ� ���� (ORDER BY �� ����)
SET AUTOTRACE TRACEONLY
SET TIMING ON
SELECT * FROM EMP1;
-- 0 sorts (memory), 0 sorts (disk) �� ������ ���� �ʾҴ�.

-- 2. ���� ó���� �߻��ϴ� ���� (�޸𸮿����� ����)
SET AUTOTRACE TRACEONLY
SET TIMING ON
SELECT * FROM EMP1 ORDER BY ENAME;
-- ���� ���̺� ��ĵ ���� �� ������ �Ǿ���(SORT ORDER BY)
-- 1 sorts (memory) �� �����κ��� �޸�(PGA)���� ������ �Ǿ���.

-- 3. ���� ó���� �߻��ϴ� ���� (��ũ���� ����)
-- PGA ũ�⸦ �ʰ��ϴ� ������ ������ �� �� ��ũ�� ����մϴ�.
-- PGA �� ����Ŭ���� �ڵ����� �����Ѵ�.
ALTER SESSION SET WORKAREA_SIZE_POLICY = MANUAL;
ALTER SESSION SET SORT_AREA_SIZE = 51200;
SET AUTOTRACE TRACEONLY;
SET TIMING ON;
SELECT * FROM EMP1 ORDER BY ENAME;
-- �����ȹ�� SORT ORDER BY, 1 sorts (disk) Ȯ�ΰ����ϴ�.