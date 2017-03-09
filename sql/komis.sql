drop table samochody
/
CREATE TABLE samochody
(
id_samochodu 		NUMBER (6) PRIMARY KEY,
id_marki	 	NUMBER (4) NOT NULL,
model	 		VARCHAR2 (20) NOT NULL,
pojemnosc_silnika       NUMBER (5),
moc			NUMBER (5),
cena			NUMBER (10),
data_produkcji 		DATE			
)
/
DROP SEQUENCE id_sam_auto
/
CREATE SEQUENCE id_sam_auto
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 1, 'Punto', 1100, 55, 15000, '1997/03/04')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 2, 'K', 1300, 60, 18000, '1998/04/05')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 3, 'W123', 2400, 65, 8000, '1978/10/01')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 3, 'W124', 3000, 100, 12000, '1990/03/01')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 4, '264', 2600, 80, 7000, '1964/12/24')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 1, 'Marea', 1600, 103, 25000, '1999/10/15')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 5, 'Kangoo', 1400, 75, 28000, '1999/01/05')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 6, 'Yaris', 1000, 68, 29000, '2000/04/15')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 7, 'Xara', 1400, 75, 20000, '1997/05/12')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 7, 'C3', 1100, 60, 35000, '2007/05/01')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 1, 'Uno', 900, 34, 15000, '2001/01/27')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 8, 'Concerto', 1500, 90, 12000, '1995/12/01')
/
INSERT INTO samochody 
VALUES (id_sam_auto.NEXTVAL, 8, 'Jazz', 1500, 95, 32000, '2006/03/10')
/

DROP TABLE marki
/
CREATE TABLE marki
(
id_marki 		NUMBER (4) PRIMARY KEY,
nazwa			VARCHAR2 (20) NOT NULL,
id_kraju_produkcji	NUMBER (4) NOT NULL
)
/
DROP SEQUENCE id_marki_auto
/
CREATE SEQUENCE id_marki_auto
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Fiat', 1)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Ford', 2)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Mercedes', 3)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Volvo', 4)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Renault', 5)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Toyota', 6)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Citroen', 5)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Honda', 6)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'Mazda', 6)
/
INSERT INTO marki 
VALUES (id_marki_auto.NEXTVAL, 'VW', 3)
/



DROP TABLE kraje
/
CREATE TABLE kraje
(
id_kraju 		NUMBER (4) PRIMARY KEY,
nazwa			VARCHAR2 (20) NOT NULL
)
/
DROP SEQUENCE id_kraju_auto
/
CREATE SEQUENCE id_kraju_auto
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'W³ochy')
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'USA')
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'Niemcy')
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'Szwecja')
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'Francja')
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'Japonia')
/
INSERT INTO kraje 
VALUES (id_kraju_auto.NEXTVAL, 'Chiny')
/

DROP TABLE koncerny
/
CREATE TABLE koncerny
(
id_marki 		NUMBER (4) PRIMARY KEY,
nazwa			VARCHAR2 (20) NOT NULL,
kooperacja		NUMBER (4)
)
/
INSERT INTO koncerny
VALUES (1, 'Renault' ,2)
/
INSERT INTO koncerny
VALUES (2, 'Nissan' ,1)
/
INSERT INTO koncerny
VALUES (3, 'Fiat' ,0)
/
INSERT INTO koncerny
VALUES (4, 'Alfa Romeo' ,3)
/
INSERT INTO koncerny
VALUES (5, 'Lancia' ,3)
/

DROP TABLE zainteresowani
/
CREATE TABLE zainteresowani
(
id 		NUMBER (4) PRIMARY KEY,
id_klienta	NUMBER (4),
id_samochodu	NUMBER (4),	
data		DATE,
uwagi		VARCHAR2 (100)
)
/
DROP SEQUENCE id_zainteresowani_auto
/
CREATE SEQUENCE id_zainteresowani_auto
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 1 , 3 , '2003/04/14', 'Targuje siê')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 2 , 5 , '2003/04/10', 'Ogl¹da³')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 5 , 1 , '2003/02/20', 'Da³ 15000')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 4 , 4 , '2003/03/21', 'Umówiony')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 3 , 2 , '2003/03/21', 'Rezygnacja')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 1 , 2 , '2003/03/21', 'Rezygnacja')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 5 , 2 , '2003/02/10', 'Wstêpnie zainteresowany')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 3 , 2 , '2003/03/12', 'powa¿nie zainteresowany')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 1 , 4 , '2003/03/21', 'Rezygnacja')
/
INSERT INTO zainteresowani
VALUES (id_zainteresowani_auto.NEXTVAL, 5 , 3 , '2003/04/20', 'Ogl¹da³')
/



DROP TABLE klienci
/
CREATE TABLE klienci
(
id_klienta 		NUMBER (4) PRIMARY KEY,
imie			VARCHAR2 (20) NOT NULL,
nazwisko		VARCHAR2 (20) NOT NULL,
wiek			NUMBER (4)
)
/
DROP SEQUENCE id_klienci_auto
/
CREATE SEQUENCE id_klienci_auto	
/
INSERT INTO klienci 
VALUES (id_klienci_auto.NEXTVAL, 'Franciszek' , 'Czapla' , 24)
/
INSERT INTO klienci 
VALUES (id_klienci_auto.NEXTVAL, 'Alfred' , 'Marmurek' , 50)
/
INSERT INTO klienci 
VALUES (id_klienci_auto.NEXTVAL, 'Gerard' , 'Czuma' , 35)
/
INSERT INTO klienci 
VALUES (id_klienci_auto.NEXTVAL, 'Anatol' , 'Potrzeba' , 24)
/
INSERT INTO klienci
VALUES (id_klienci_auto.NEXTVAL, 'Wies³awa' , 'Miœ' , 38)
/