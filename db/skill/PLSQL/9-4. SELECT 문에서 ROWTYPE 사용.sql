DECLARE
 v_emprec   emp%ROWTYPE; -- ���ڵ� ���� ����
BEGIN
 v_emprec.empno := 7788;
 SELECT *
   INTO v_emprec
   FROM emp
  WHERE empno = v_emprec.empno;
  DBMS_OUTPUT.PUT_LINE('�̸�    : '||v_emprec.ename);
  DBMS_OUTPUT.PUT_LINE('�μ���ȣ: '||v_emprec.deptno);
END;