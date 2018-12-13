CREATE OR REPLACE PACKAGE pkg_seq
IS
  v_seq NUMBER; -- ���� ��Ű�� ���� ����
  
  FUNCTION get_nextval RETURN NUMBER; -- ��Ű�� ������ ���� 1 ������Ű�� �� ���� ��ȯ
END;


CREATE OR REPLACE PACKAGE body pkg_seq
IS
  FUNCTION get_nextval RETURN NUMBER IS
  BEGIN
    v_seq := v_seq + 1;
    RETURN v_seq;
  END;
BEGIN
  v_seq := 0; -- ���� ��Ű�� ���� �ʱ�ȭ
END;

select pkg_seq.get_nextval from dual;