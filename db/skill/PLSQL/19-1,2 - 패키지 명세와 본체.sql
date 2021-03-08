-- ��Ű�� ��
CREATE OR REPLACE PACKAGE pkg_emp
IS
  -- ���� Ÿ�� ����
  TYPE emp_type IS TABLE OF emp%ROWTYPE;

  -- ���� ��� ����
  c_deptno_accounting CONSTANT NUMBER := 10;
  c_deptno_research   CONSTANT NUMBER := 20;
  c_deptno_sales      CONSTANT NUMBER := 30;
  c_deptno_operations CONSTANT NUMBER := 40;
  
  -- ���� ���� ����
   v_last_wage NUMBER;
   
   -- ���� ���� ���α׷� ����
   FUNCTION   get_wage    (a_empno NUMBER) RETURN NUMBER;
   PROCEDURE  raise_bonus (a_empno NUMBER, a_amt NUMBER);
END;
-- ��Ű�� ��ü
CREATE OR REPLACE PACKAGE BODY pkg_emp
IS
  -----------------------------------------------
  -- ���� ��� ����
  -----------------------------------------------
  c_null_commission     CONSTANT NUMBER :=  0;
  c_failed_return_wage  CONSTANT NUMBER := -1;
  
  -----------------------------------------------
  -- ���� Ŀ�� ����
  -----------------------------------------------
  CURSOR emp_cursor(a_empno NUMBER) IS
    -- ����� a_empno �� ����� �޿��� Ŀ�̼��� ���� ��ȸ
    SELECT sal + NVL(comm, c_null_commission) comm
      FROM emp
     WHERE empno = a_empno;
     
  -----------------------------------------------
  -- ���� �������α׷� ����
  -----------------------------------------------
  FUNCTION get_wage(a_empno NUMBER) RETURN NUMBER
  -- ����� �޿��� Ŀ�̼��� ���� ��ȯ�ϴ� �Լ�
  IS
  BEGIN
    FOR rec IN emp_cursor(a_empno)
    LOOP
      -- ����� �����ϴ� ��� �޿��� ��ȯ
      v_last_wage := rec.comm;
      return rec.comm;
      end loop;
      -- ����� �������� ���� ��� -1 �� ��ȯ
      RETURN c_failed_return_wage;
    END;
    
    PROCEDURE raise_bonus(a_empno NUMBER, a_amt NUMBER)
    -- ���̺� bonus �� ����� Ŀ�̼� ���� �λ��ϴ� ���ν���
    IS
      v_ename emp.ename%TYPE;
    BEGIN
      -- ����� �̸��� ��´�.
      BEGIN
        SELECT ename
          INTO v_ename
          FROM emp
         WHERE empno = a_empno;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          -- ����� �������� ���� ���� ������ �ߴ��ϰ� ����
          -- ��ȯ ���� ���� ���� �Լ��� �ٸ� ���̴�.
          RETURN;
      END;
      
      -- ���ʽ��� �λ�
      IF a_amt IS NOT NULL
      THEN
        MERGE INTO bonus
        USING DUAL
           ON (bonus.ename = v_ename)
         WHEN MATCHED THEN -- ���� ���ʽ��� �ִ� ��� �λ��� ���� ����
          UPDATE SET comm = comm + a_amt
         WHEN NOT MATCHED THEN -- �������ʽ��� ���� ���� �� �ο츦 �߰�
          INSERT (ename, comm)
          VALUES (v_ename, a_amt);
        END IF;
      END;

BEGIN --��Ű�� �ʱ�ȭ��
  v_last_wage := -1;
END;
