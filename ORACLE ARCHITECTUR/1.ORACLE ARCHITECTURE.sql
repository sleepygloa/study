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
