insert into czubak.studenci(nazwisko, imie, semestr)
values ('aa','aa',4);
select * from studenci;
commit;
grant all on studenci_zaliczenia_lista to public;
drop table studenci_zaliczenia_lista;
create table studenci_zaliczenia_lista
(album number(5)
  ,datazal date
  ,id_przedmiot char(5)
  ,ocena number(2,1)
  ,constraint stu_zal_lista_ocen
    check (ocena in(2, 3, 3.5, 4, 4.5, 5))
  ,constraint stu_zal_lista_PK
    primary key (album, datazal, id_przedmiot)
  ,constraint stu_zal_lista_stu_lis_FK
    foreign key(album) references studenci_lista
    );
    
insert into wasikp0.studenci_zaliczenie_lista 
values (1, TO_DATE('10/08/2005','DD/MM/YYYY'), 'PlSql', 2); 
commit;
insert into studenci_zaliczenia_lista 
values (2, TO_DATE('10/08/2005','DD/MM/YYYY'), 'PlSql', 3); 

select * from studenci_zaliczenia_lista ;

create or replace trigger stuzallista_air
after insert on studenci_zaliczenia_lista
for each row 
when (new.ocena <>2)
begin 
  delete 
    from studenci_zaliczenia_lista
    where ocena = 2
      and album = :new.album
      and id_przedmiot = :NEW.id_przedmiot;
end stuzallista_air;
