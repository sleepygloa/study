DECLARE
  v_empno emp.empno%TYPE := 9000;
BEGIN
  DELETE FROM emp
   WHERE empno = v_empno;
  DBMS_OUTPUT.PUT_LINE('INSERT �Ǽ�:' ||SQL%ROWCOUNT); --����� �Ǽ� ���
  COMMIT;
END;