DECLARE
  -- ������ �ε����� �ϴ� Nested Table
  TYPE city IS TABLE OF VARCHAR2(64);
  
  -- �� �÷��� ���� ����
  v_city    city;
  
  -- �÷��� ���� ����� ���ÿ� �÷���
  v_city2   city := city('����', '�λ�', '����', '����', '��õ');

BEGIN
  v_city := city(); -- ũ�� 0(Empty �÷���)���� �ʱ�ȭ
  -- ũ�⸦ ������Ű��, ���� �����Ѵ�.
  v_city.EXTEND ; v_city(1) := '����';
  v_city.EXTEND ; v_city(2) := '�λ�';
  v_city.EXTEND ; v_city(3) := '�뱸';
  v_city.EXTEND ; v_city(4) := '����';
  DBMS_OUTPUT.PUT_LINE('���� ���� : ' ||v_city.COUNT||'��');
  
  -- ��ȿ�� �÷��� ���� ���
  FOR i in v_city.FIRST .. v_city.LAST
  LOOP
    IF v_city.EXITS(i) THEN
      DBMS_OUTPUT.PUT_LINE(CHR(9)||'v_city(' || TO_CHAR(i)
  