DECLARE
 v_empno    emp.empno %TYPE;
 v_ename    emp.ename %TYPE;
 v_deptno   emp.deptno%TYPE;
 v_job      emp.job   %TYPE;
BEGIN
  SELECT EMPNO,   ENAME,   DEPTNO,   JOB
    INTO v_empno, v_ename, v_deptno, v_job --��� ������ ������ SELECT �Ǵ� �÷��� ���� ����.
    FROM emp
   WHERE empno = 7788;
END;