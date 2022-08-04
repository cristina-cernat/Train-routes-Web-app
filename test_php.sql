set serveroutput on;

CREATE TABLE test_users (id_user NUMBER(10), username varchar2(20) NOT NULL, passwd varchar2(20) NOT NULL);

--SEQUENCES
CREATE SEQUENCE users_seq;
CREATE SEQUENCE event_seq;

DROP SEQUENCE event_seq;

--POPULATE
INSERT INTO test_users (id_user, username, passwd) VALUES (users_seq.nextval, 'anca', '1234');
INSERT INTO test_users (id_user, username, passwd) VALUES (users_seq.nextval, 'ana', '1234');

DROP TABLE test_users;
DROP table eventuri;

--keeping the events
--CREATE TABLE events (id_event NUMBER(10), id_user varchar2(20), type varchar2(20), time TIMESTAMP);
CREATE TABLE eventuri (id_event NUMBER(10), id_user number(20), username varchar2(20), passwd varchar2(20));


--LOGIN
CREATE OR REPLACE PROCEDURE Login (userr in varchar2, passs in varchar2, id_user out int, res_value out int) 
IS
v_id NUMBER(20);
begin
  begin
  SELECT id_user INTO v_id from test_users where test_users.username = userr and test_users.passwd = passs;
  EXCEPTION when no_data_found THEN
    res_value := 0;
     INSERT INTO eventuri (id_event, id_user, username, passwd) VALUES (0, 0, 'ceva', 'passwd');
    return;
  end;
  
  INSERT INTO eventuri (id_event, id_user, username, passwd) VALUES (5, v_id, userr, passs);
  id_user := v_id;
  res_value := 1;
  return;
end;
  

--SET SQLFORMAT csv
select /*csv*/* from test_users;


select * from eventuri;




CREATE OR REPLACE PROCEDURE myproc(p1 IN NUMBER, p2 OUT NUMBER) AS
  BEGIN
      p2 := p1 * 2;
      INSERT INTO events(id_event) values (12);
  END;