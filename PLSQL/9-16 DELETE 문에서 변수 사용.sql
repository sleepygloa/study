DECLARE
  v_empno emp.empno%TYPE := 9000;
BEGIN
  DELETE FROM emp
   WHERE empno = v_empno;
  DBMS_OUTPUT.PUT_LINE('INSERT 건수:' ||SQL%ROWCOUNT); --변경된 건수 출력
  COMMIT;
END;