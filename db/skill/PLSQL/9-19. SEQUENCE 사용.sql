REM ������ emp_seq ����
CREATE SEQUENCE emp_seq;

DECLARE
  v_seq_value NUMBER;
BEGIN
  -- SQL ���� �������� ���� ����ϴ� ���
  --v_seq_value := emp_seq.NEXTVAL;
  
  -- SQL�� ����Ͽ� ������ ���� ��� ��.
  -- 'v_seq_value := emp_seq.NEXTVAL' �� ���� ��ȿ������.
  SELECT emp_seq.NEXTVAL
    INTO v_seq_value
    FROM DUAL;
  
  DBMS_OUTPUT.PUT_LINE('������ ��: '|| TO_CHAR(v_seq_value));
END;

