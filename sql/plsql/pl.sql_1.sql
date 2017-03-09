--wysy³anie maila

declare 
 v_connection UTL_SMTP.CONNECTION;
 v_reply  UTL_SMTP.REPLY;
Begin 
  v_connection := UTL_SMTP.OPEN_CONNECTION ('smtp.wit.edu.pl', 25);
  v_reply := UTL_SMTP.HELO(v_connection, 'smtp.wit.edu.pl');
  v_reply := UTL_SMTP.MAIL(v_connection, 'cwiekk@wit.edu.pl');
  v_reply := UTL_SMTP.RCPT(v_connection, 'gwiezdnychchlopak@op.pl');
  v_reply := UTL_SMTP.SUBJECT(v_connection, 'Hello, - Oracle')
  v_reply := UTL_SMTP.DATA(v_connection, 'Sent from pl/sql');
  v_reply := UTL_SMTP.QUIT(v_connection);
END;
/


-- kursor


declare
  v_nazwisko varchar2(20);
begin
  select nazwisko
    into v_nazwisko from pracowenicy
    where id = 7369;
  dbms_output.put_line('Nazwisko pracownika:' ||v_nazwisko);
exception
  when no_data_found
    then dbms_output.put_line('Brak pracownika!!!');
  when to_many_rows
    then dbms_output.put_line('Kilku pracownikow!!!');
End;
/


begin
  for c_prac in (select nazwisko from pracownicy) loop
    dbms_output.put_line('Nazwiko pracownika: ' || c_prac.nazwisko);
  end loop;
end;
/


--kursor jawny
declare 
  cursor c_prac return pracownicy%ROWTYPE
    is select * from pracownicy;
begin
  for wiersz in c_prac loop
    dbms_output.put_line('Nazwisko pracownika:' || wiersz.nazwisko);
  end loop;
end;  
/


--tabela pracownicy

DROP TABLE pracownicy CASCADE CONSTRAINTS;
CREATE TABLE pracownicy
( id                NUMBER(4),
  imie              VARCHAR2(15),
  nazwisko          VARCHAR2(20),
  stanowisko        VARCHAR2(15),
  kierownik_id      NUMBER(4),
  data_zatrudnienia DATE,
  placa             NUMBER(7,2),
  premia            NUMBER(7,2),
  departament_id    NUMBER(2)
);

INSERT INTO pracownicy	VALUES (7369,'STANISLAW' ,'KUDLATY'   ,'URZEDNIK'  ,7902,to_date('17-12-1980','dd-mm-yyyy'),800 ,NULL,20);
INSERT INTO pracownicy	VALUES (7499,'MIECZYSLAW','PRYSZCZATY','HANDLOWIEC',7698,to_date('20-2-1981','dd-mm-yyyy') ,1600,300 ,30);
INSERT INTO pracownicy	VALUES (7521,'GUSTAW'    ,'PIJACY'    ,'HANDLOWIEC',7698,to_date('22-2-1981','dd-mm-yyyy') ,1250,500 ,30);
INSERT INTO pracownicy	VALUES (7566,'BOLESLAW'  ,'PONURY'    ,'KIEROWNIK' ,7839,to_date('2-4-1981','dd-mm-yyyy')  ,2975,NULL,20);
INSERT INTO pracownicy	VALUES (7654,'FRANCISZEK','KULAWY'    ,'HANDLOWIEC',7698,to_date('28-9-1981','dd-mm-yyyy') ,1250,1400,30);
INSERT INTO pracownicy	VALUES (7698,'JAN'       ,'SAMOTNY'   ,'KIEROWNIK' ,7839,to_date('1-5-1981','dd-mm-yyyy')  ,2850,NULL,30);
INSERT INTO pracownicy	VALUES (7782,'BOGDAN'    ,'WESOLY'    ,'KIEROWNIK' ,7839,to_date('9-6-1981','dd-mm-yyyy')  ,2450,NULL,10);
INSERT INTO pracownicy	VALUES (7788,'WLADYSLAW' ,'NIJAKI'    ,'ANALITYK'  ,7566,to_date('13-06-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO pracownicy	VALUES (7839,'EULALIA'   ,'NIECALA'   ,'PREZES'    ,NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO pracownicy	VALUES (7844,'JADWIGA'   ,'ZAPASIONA' ,'HANDLOWIEC',7698,to_date('8-09-1981','dd-mm-yyyy') ,1500,0   ,30);
INSERT INTO pracownicy	VALUES (7876,'JOANNA'    ,'CZYSTA'    ,'URZEDNIK'  ,7788,to_date('13-06-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO pracownicy	VALUES (7900,'KAZIMIERA' ,'SMUTNA'    ,'URZEDNIK'  ,7698,to_date('3-12-1981','dd-mm-yyyy') ,950 ,NULL,30);
INSERT INTO pracownicy	VALUES (7902,'ZUZANNA'   ,'PORANNA'   ,'ANALITYK'  ,7566,to_date('3-12-1981','dd-mm-yyyy') ,3000,NULL,20);
INSERT INTO pracownicy	VALUES (7937,'EWA'       ,'ZALEKNIONA','URZEDNIK'  ,7782,to_date('23-1-1982','dd-mm-yyyy') ,1300,NULL,10);
INSERT INTO pracownicy	VALUES (7937,'MARIOLA'   ,'LENIWA'    ,'URZEDNIK'  ,7782,to_date('23-1-1982','dd-mm-yyyy') ,1300,NULL,50);



--kursor jawny - kolumny

declare
  v_nazwisko varchar2(20);
  cursor c_prac is
    select nazwisko
      from pracownicy
      where stanowisko = 'HANDLOWIEC';
begin
  open c_prac;
  loop
    fetch c_prac into v_nazwisko;
    exit when c_prac%notfound;
    dbms_output.put_line('Nazwisko pracownika: ' || v_nazwisko);
  end loop;
  close c_prac;
end;
/

-kursor jawny (rekord)
DECLARE
  CURSOR c_prac IS
   SELECT * 
     FROM pracownicy 
     WHERE stanowisko = 'HANDLOWIEC'; 
 r_pracownik c_prac%ROWTYPE;
BEGIN
  OPEN c_prac;
  LOOP
    FETCH c_prac INTO r_pracownik;
    EXIT WHEN c_prac%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(
      'Wiersz: '|| c_prac%ROWCOUNT ||
     '  Nazwisko pracownika:' || r_pracownik.nazwisko);
  END LOOP;
  CLOSE c_prac;
END;
/

--kursor przyk³ad bardziej praktyczny

declare
  f utl_file.file_type;
begin
  f:=utl_file.FOPEN('ETL_EXT_SOURCE','cwiekk.txt','W');
  for c_prac in (select nazwisko from pracownicy) loop
    utl_file.put_line (f, 'Nazwisko pracownika:' || c_prac.nazwisko);
end loop;
utl_file.FCLOSE(f);
end;
/
