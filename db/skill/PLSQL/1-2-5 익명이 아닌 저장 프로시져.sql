CREATE OR REPLACE PROCEDURE register_employee(
    a_empno         NUMBER,     -- �Էº��� : ����� ��� �Ű�����
    a_ename         VARCHAR2,   -- �Էº��� : ����� �̸� �Ű�����
    a_job           VARCHAR2,   -- �Էº��� : ����� ���� �Ű�����
    a_rsit_out  OUT BOOLEAN,    -- ��º��� : ó�� ���� ����
    a_msg_out   OUT VARCHAR2    -- ��º��� : ó�� ����� ��ȯ�ϴ� ����
)
IS
    -- ���
    c_default_deptno NUMBER := 20; -- DEFAULT �μ� �ڵ�
    
    -- ����
    v_cnt   NUMBER;     -- �Ǽ�
    
    BEGIN
        -- �־��� ����� ���� ���� Ȯ��
        -- v_cnt > 0 : ����
        --       = 0 : ����.
        
        SELECT  COUNT(*)
          INTO  v_cnt
          FROM  emp
         WHERE  empno   = a_empno;
         
        -- 1. �ش� ����� emp ���̺� �����ϸ�
        IF v_cnt > 0 THEN
            -- 1.1 (�����, ����)�� (v_name, v_job) ���� ����
            UPDATE  emp
               SET  ename   =   a_ename,
                    job     =   a_job
             WHERE  empno   =   a_empno;
             
            a_msg_out := '��� "' || a_ename || '"�� ������ ����Ǿ����ϴ�.';
        ELSE
            -- ���ο� ��� ������ ���̺� ���
            INSERT INTO emp (empno, ename, job, deptno)
            VALUES (a_empno, a_ename, a_job, c_default_deptno);
            
            a_msg_out := '���Ի�� "' || a_ename || '"��(��) ��ϵǾ����ϴ�.';
        END IF;
        a_rsit_out := TRUE;
        
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;   -- ��� ���� ���
        a_msg_out := '���� ���α׷� ���� �߻�' || CHR(10) || SQLERRM;
        a_rsit_out := FALSE;
     END;
     /