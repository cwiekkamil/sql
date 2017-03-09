drop view studenci_zaliczenia;
create view studenci_zaliczenia
as select *
  from studenci_zaliczenia_lista;
  
select * from studenci_zaliczenia;

CREATE OR REPLACE TRIGGER stuzal_iiur 
INSTEAD OF INSERT OR UPDATE ON studenci_zaliczenia
FOR EACH ROW
DECLARE
  v_liczba NUMBER :=0;
BEGIN
  IF :NEW.ocena <>2 THEN
    SELECT COUNT(1) INTO v_liczba
      FROM studenci_zaliczenia_lista
      WHERE album = :NEW.album
        AND id_przedmiot = :NEW.id_przedmiot
        AND ocena <> 2;
    IF v_liczba >0 THEN
      raise_application_error(-20000, 'Student ju¿ zaliczy³');
    END IF;
  END IF;
  INSERT INTO studenci_zaliczenia_lista
         (album, datazal, id_przedmiot, ocena)
    VALUES(:NEW.album, :NEW.datazal, :NEW.id_przedmiot, :NEW.ocena); 
  IF :NEW.ocena<>2 THEN
    DELETE 
      FROM studenci_zaliczenia_lista 
      WHERE ocena = 2
        AND album = :NEW.album 
        AND id_przedmiot = :NEW.id_przedmiot;
  END IF;
END stuzal_iiur;
/
Show errors

insert into studenci_zaliczenia values (3, to_date('03/11/2007','DD/MM/YYYY'), 'PLSql',3);

insert into studenci_zaliczenia values (1, to_date('03/11/2007','DD/MM/YYYY'), 'PLSql',3);

insert into studenci_zaliczenia values (4, to_date('24/11/2007','DD/MM/YYYY'), 'PLSql',3);


Magazyn


drop table magazyn;
create table magazyn
(product_name varchar2(20) primary key
,last_delivery NUMBER(3)
,current_quantity NUMBER(3)
);

CREATE OR REPLACE TRIGGER curr_to_last
before insert on magazyn
FOR EACH ROW
begin
  if :NEW.current_quantity is null then
    :NEW.current_quantity := :New.last_delivery;
  end if;
END curr_to_last;
/
Show errors

Insert into magazyn (product_name,last_delivery) values ('fasola',8,);

Insert into magazyn values ('pieczywo',8,10);


select * from magazyn;



UPS

DROP TABLE kontener;

CREATE TABLE kontener
( id_przesylki VARCHAR2(10) NOT NULL PRIMARY KEY
 ,waga_przesylki NUMBER NOT NULL
);

create or replace package errors is
--Ustalona maksymalna waga kontenera
  waga_max constant number :=1000;
-- Ustalone wartoœci sygnalizujace b³¹d
  waga_exceed constant integer := -20001;
  waga_exceed_txt constant varchar2(100) := 'Waga przekroczy³a maksimum';
end errors;
/
Show errors

create or replace trigger kontener_aius
after insert or update of waga_przesylki on kontener
declare
 v_waga_sum number :=0;
begin
  select sum(waga_przesylki) into v_waga_sum from kontener;
  if v_waga_sum > errors.waga_max then
    raise_application_error
      (errors.waga_exceed, errors.waga_exceed_txt);
  end if;
end kontener_aius;
/
Show errors
drop table zaladunek;
CREATE TABLE zaladunek as select *from kontener where 1=2;
insert into zaladunek values(31,100);
insert into zaladunek values(32,500);
insert into zaladunek values(33,200);
commit;

insert into kontener values (10,100);
insert into kontener values (20,300);
insert into kontener (select * from zaladunek);
commit;

drop table kontener;


select * from kontener;
select * from zaladunek;


Funkcje

create or replace function czy_parzysta
(in_wartosc in number)
return varchar2 
is 
begin 
  if mod(in_wartosc,2)=0 then
    return ('parzysta');
  else 
    return ('nieparzysta');
  end if;
end czy_parzysta;
/
show errors

select czy_parzysta(4) from dual;


select czy_parzysta('bubel') from dual;


create or replace package paciefun as
--pakiet ciekawych funkcji
function czy_parzysta( in_wartosc in number)
  return varchar2;

function czy_parzysta( in_wartosc in varchar2)
  return varchar2;
end paciefun;
/

create or replace package body paciefun as
function czy_parzysta(in_wartosc in number)
return varchar2 
is 
begin 
  if mod(in_wartosc,2)=0 then
    return ('parzysta');
  else 
    return ('nieparzysta');
  end if;
end czy_parzysta;
--A teraz coœ weso³ego
function czy_parzysta(in_wartosc in varchar2)
  return varchar2 is
begin 
  return 'Argument nie jest liczb¹ !?!';
end czy_parzysta;
end paciefun;
/
show errors

select paciefun.czy_parzysta('bubel') from dual;