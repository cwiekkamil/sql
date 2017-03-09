Nale�y zbudowa� fragment bazy danych dla obs�ugi Dziekanatu Uczelni.

1. W bazie ma by� dost�pna relacja STUDENCI
     album     NUMBER(5)     Klucz g��wny, Bez mo�liwo�ci zmiany
     nazwisko  VARCHAR2(20)  obowi�zkowe
     imie      VARCHAR2(20)  obowi�zkowe
     semestr   NUMBER(2)
     login     VARCHAR(20)   OBOWIAZKOWE
		
2. W bazie ma by� zrealizowany mechanizm ograniczaj�cy dost�p do danych w relacji STUDENCI:

    a) ka�dy u�ytkownik mo�e dowolnie wprowadza� dane,

    b) Wiersze kompletne s� widoczne dla wszystkich u�ytkownik�w, 

    c) u�ytkownik mo�e zmienia� zawarto�� tylko tych wierszy, kt�re wprowadzi�.

    d) wiersze bez numeru semestru s� widoczne tylko dla u�ytkownika, kt�ry je wprowadzi�.		


1

drop table studenci_lista;

create table studenci_lista
(album number(5) constraint stu_lis_PK PRIMARY KEY
, nazwisko Varchar2(20) NOT NULL
, imie Varchar2(20) NOT NULL
, semestr Number(2) 
, operator Varchar2(30)
);

drop sequence stu_lis_seq;

create sequence stu_lis_seq;


drop view studenci;

create view studenci
as select album
          , nazwisko
          , imie
          , semestr
from studenci_lista
where (semestr is not null)
or operator = (select user from dual)
with check option constraint studench_cht;

grant insert, update, delete on studenci to public;


CREATE OR REPLACE TRIGGER stulis_aiur
BEFORE INSERT OR UPDATE OR DELETE ON studenci_lista
FOR EACH ROW
DECLARE
  v_operator VARCHAR2(20);
BEGIN
IF INSERTING THEN
  SELECT stu_lis_seq.nextval, user
  INTO :new.album, :new.operator
  FROM DUAL;
END IF;
IF UPDATING THEN
  SELECT user INTO v_operator FROM DUAL;
  IF :old.operator <> v_operator THEN
    raise_application_error(-20000, 'Zmienia tylko autor');
  END IF;
  IF :new.album <> :old.album THEN
    raise_application_error(-20000, 'Album niezmienny');
  END IF;
END IF;
--IF DELETING THEN
  --
  --
--END IF;
END stulis_aiur;


2

--insert into studenci values (1,'Rafalski', 'Czesio',4);
--insert into studenci (nazwisko, imie) values ('Ponury', 'Rze�nik');
--commit;
select * from studenci_lista;

3

--select * from wasikp0.studenci;
update wasikp0.studenci set nazwisko='eeee' where album=5;
commit;
