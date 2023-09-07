############################# CREAZIONE DATABASE ###############################

create database Autonoleggi;
use Autonoleggi;

############################# CREAZIONE TABELLE ###############################

#creazione tabella autonoleggio
create table if not exists Autonoleggio(
IdAutonoleggio int not null auto_increment primary key,
Nome char(40),
Indirizzo char(60),
Città char(30),
Telefono char(15)
)engine=InnoDB;

#creazione tabella carica
create table if not exists Carica(
IdCarica int not null auto_increment primary key,
Carica char(50)
)engine=InnoDB;

#creazione tabella impiegati
create table if not exists Impiegati(
CodFiscale char(16) not null primary key,
Cognome char(30),
Nome char(30),
Recapito char(15),
IdCarica int,
IdAutonoleggio int,
foreign key (IdCarica) references Carica(IdCarica)
                                 on update cascade
				                 on delete no action,
foreign key (IdAutonoleggio) references Autonoleggio(IdAutonoleggio)
									  on update cascade
				                      on delete no action
)engine=InnoDB;

#creazione tabella servizio
create table if not exists Servizio(
IdServizio int not null auto_increment primary key,
DataInizio date,
DataFine date,
Impiegato char(16),
IdAutonoleggio int,
foreign key (Impiegato) references Impiegati(CodFiscale)
                                 on update cascade
				                 on delete no action,
foreign key (IdAutonoleggio) references Autonoleggio(IdAutonoleggio)
									  on update cascade
				                      on delete no action
)engine=InnoDB;

#creazione tabella categoria
create table if not exists Categoria(
IdCategoria int not null auto_increment primary key,
Categoria char(30)
)engine=InnoDB;

#creazione tabella costo
create table if not exists Costo(
IdCosto int not null auto_increment primary key,
Costo double(10,2)
)engine=InnoDB;

#creazione tabella Veicoli
create table if not exists Veicoli(
IdVeicolo int not null auto_increment primary key,
Targa char(10),
IdCategoria int,
Nome char(50),
Posti int,
IdCostoNoleggioGiornaliero int,
IdAutonoleggio int,
foreign key (IdCategoria) references Categoria(IdCategoria)
                                   on update cascade
				                   on delete no action,
foreign key (IdCostoNoleggioGiornaliero) references Costo(IdCosto)
                                                  on update cascade
				                                  on delete no action,
foreign key (IdAutonoleggio) references Autonoleggio(IdAutonoleggio)
                                      on update cascade
				                      on delete no action
)engine=InnoDB;

#creazione tabella noleggio
create table if not exists Noleggio(
IdNoleggio int not null auto_increment primary key,
DataInizioNoleggio date,
DataFineNoleggio date,
CostoTotaleNoleggio double(10,2),
IdVeicolo int,
foreign key (IdVeicolo) references Veicoli(IdVeicolo)
                                 on update cascade
								 on delete no action
)engine=InnoDB;

#creazione tabella clienti
create table if not exists Clienti(
CodFiscale char(16) not null primary key,
Cognome char(30),
Nome char(30),
IdNoleggio int,
foreign key (IdNoleggio) references Noleggio(IdNoleggio)
                                  on update cascade
								  on delete no action
)engine=InnoDB;

#creazione tabella azienda fornitrice
create table if not exists AziendaFornitrice(
IdAzienda int not null auto_increment primary key,
Nome char(50),
Indirizzo char(60),
Città char(30),
Telefono char(15)
)engine=InnoDB;

#creazione tabella fornitura
create table if not exists Fornitura(
IdFornitura int not null auto_increment primary key,
CostoMensile double(10,2),
IdVeicolo int,
IdAzienda int,
foreign key (IdVeicolo) references Veicoli(IdVeicolo)
                                 on update cascade
								 on delete no action,
foreign key (IdAzienda) references AziendaFornitrice(IdAzienda)
                                 on update cascade
								 on delete no action
)engine=InnoDB;


############################# INSERIMENTO DATI ###############################


#inserimento dati nella tabella autonoleggio
INSERT INTO Autonoleggio(IdAutonoleggio,Nome,Indirizzo,Città,Telefono)values(1,"Andrea's Cars",'Via Terni','Roma','3296227864');
INSERT INTO Autonoleggio(IdAutonoleggio,Nome,Indirizzo,Città,Telefono)values(2,'Cars&Motorbike','Via S.Gregorio','Milano','3278901423');
INSERT INTO Autonoleggio(IdAutonoleggio,Nome,Indirizzo,Città,Telefono)values(3,'MacchinGo','Via Senese','Firenze','3334789012');
INSERT INTO Autonoleggio(IdAutonoleggio,Nome,Indirizzo,Città,Telefono)values(4,'Noleggio Expres','Via Amerigo Vespucci','Napoli','3313295671');
INSERT INTO Autonoleggio(IdAutonoleggio,Nome,Indirizzo,Città,Telefono)values(5,'SpeedCar','Via Baccina','Roma','3395442311');
INSERT INTO Autonoleggio(IdAutonoleggio,Nome,Indirizzo,Città,Telefono)values(6,'SuperNoleggio','Via Ugo Bassi','Bologna','3276395442');


#inserimento dati nella tabella carica
INSERT INTO Carica(IdCarica,Carica)values(1,'Venditore');
INSERT INTO Carica(IdCarica,Carica)values(2,'Meccanico');
INSERT INTO Carica(IdCarica,Carica)values(3,'Addetto alle pulizie');


#inserimento dati nella tabella impiegati
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('CSTDNL95A29M272U','Costa','Daniele','3276821440',1,1);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('GLNVNC94M50D862P','Giuliani','Veronica','3332660116',1,2);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('GRCLCU81L19A944X','Greco','Luca','3290032145',2,4);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('GRNMRC80C21M212T','Grande','Marco','3297855119',1,4);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('LNGMRA76E50A475P','Longo','Maria','3347908212',1,3);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('MNTLNR96H56E506H','Montefusco','Eleonora','3403251822',1,6);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('MRNMHL85H08F205W','Marino','Giuseppe','3803224511',2,2);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('PRRGTA72D59M212T','Perrone','Agata','3895087334',3,1);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('RSSGNN88S03F842A','Russo','Giovanni','3393442117',3,3);
INSERT INTO Impiegati(CodFiscale,Cognome,Nome,Recapito,IdCarica,IdAutonoleggio)values('RZZMNL78T12A944W','Rizzo','Emanuele','3406220711',2,5);


#inserimento dati nella tabella servizio
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(1,'2023-08-01','2023-08-31','GRCLCU81L19A944X',2);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(2,'2023-07-01','2023-08-31','LNGMRA76E50A475P',2);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(3,'2023-06-06','2023-06-20','PRRGTA72D59M212T',4);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(4,'2023-04-15','2023-06-15','GRNMRC80C21M212T',5);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(5,'2023-05-18','2023-06-19','RSSGNN88S03F842A',6);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(6,'2023-05-01','2023-07-30','MNTLNR96H56E506H',3);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(7,'2023-07-27','2023-08-09','MRNMHL85H08F205W',3);
INSERT INTO Servizio(IdServizio,DataInizio,DataFine,Impiegato,IdAutonoleggio)values(8,'2023-02-22','2023-05-31','GLNVNC94M50D862P',1);


#inserimento dati nella tabella categoria
INSERT INTO Categoria(IdCategoria,Categoria)values(1,'Automobile');
INSERT INTO Categoria(IdCategoria,Categoria)values(2,'Ciclomotore');


#inserimento dati nella tabella costo
INSERT INTO Costo(IdCosto,Costo)values(1,15.00);
INSERT INTO Costo(IdCosto,Costo)values(2,20.00);
INSERT INTO Costo(IdCosto,Costo)values(3,25.00);
INSERT INTO Costo(IdCosto,Costo)values(4,30.00);
INSERT INTO Costo(IdCosto,Costo)values(5,35.00);


#inserimento dati nella tabella veicoli
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(1,'AF678YY',1,'Audi Q2',4,5,2);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(2,'BG322FR',1,'BMW X5',5,3,3);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(3,'BV473SG',1,'Fiat 500',4,1,1);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(4,'CC816MN',1,'BMW 116',4,2,5);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(5,'ER303GH',1,'Audi A3',4,3,1);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(6,'GT311BB',1,'Mercedes-Benz B 160',4,4,3);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(7,'J406SY',2,'Yamaha T-Max',2,3,6);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(8,'JK755DL',1,'Fiat 500',4,1,4);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(9,'LP911VV',1,'Alfa Romeo MiTo',4,3,6);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(10,'SD233FF',1,'Alfa Romeo 159',5,1,5);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(11,'TY766SS',1,'Mercedes-Benz 180',4,3,3);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(12,'VV359JH',1,'Alfa Romeo Stelvio',5,5,6);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(13,'X248FL',2,'Yamaha X-Max250',2,2,2);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(14,'X5FDPJ',2,'Yamaha X-Max300',2,4,4);
INSERT INTO Veicoli(IdVeicolo,Targa,IdCategoria,Nome,Posti,IdCostoNoleggioGiornaliero,IdAutonoleggio)values(15,'X7RGHJ',2,'BMW C600sport',2,2,2);


#inserimento dati nella tabella noleggio
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(1,'2023-07-04','2023-07-14',385.00,12);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(2,'2023-05-18','2023-05-20',60.00,13);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(3,'2023-07-13','2023-07-18',150.00,5);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(4,'2023-06-16','2023-06-20',150.00,6);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(5,'2023-08-11','2023-08-17',175.00,5);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(6,'2023-08-08','2023-08-09',50.00,9);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(7,'2023-06-27','2023-06-30',100.00,11);
INSERT INTO Noleggio(IdNoleggio,DataInizioNoleggio,DataFineNoleggio,CostoTotaleNoleggio,IdVeicolo)values(8,'2023-05-25','2023-05-26',50.00,2);


#inserimento dati nella tabella clienti
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('CTLLNZ99S23A944N','Cataldi','Lorenzo',1);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('GFFMTT96R25D862F','Giaffreda','Matteo',2);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('GLLRRA00T48H501J','Galilei','Aurora',3);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('MNFSRA92L49A475V','Manfredi','Sara',4);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('MRULSS79D60M212Z','Mura','Alessia',5);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('RCCLRT89M06M272N','Rocca','Alberto',6);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('SRRNGL94R10F205E','Serra','angelo',7);
INSERT INTO Clienti(CodFiscale,Cognome,Nome,IdNoleggio)values('RSSSVT74H18F842U','Rosso','Salvatore',8);


#inserimento dati nella tabella azienda fornitrice
INSERT INTO AziendaFornitrice(IdAzienda,Nome,Indirizzo,Città,Telefono)values(1,'Alfa Romeo','Via Osti','Milano','3276885234');
INSERT INTO AziendaFornitrice(IdAzienda,Nome,Indirizzo,Città,Telefono)values(2,'Audi','Via Maria Vittoria','Torino','3338900722');
INSERT INTO AziendaFornitrice(IdAzienda,Nome,Indirizzo,Città,Telefono)values(3,'Bmw','Via Cardarola','Bari','833346752');
INSERT INTO AziendaFornitrice(IdAzienda,Nome,Indirizzo,Città,Telefono)values(4,'Fiat','Via Milazzo','Bergamo','3406414328');
INSERT INTO AziendaFornitrice(IdAzienda,Nome,Indirizzo,Città,Telefono)values(5,'Mercedes','Via Piave','Brescia','3276551721');
INSERT INTO AziendaFornitrice(IdAzienda,Nome,Indirizzo,Città,Telefono)values(6,'Yahama','Via Calabria','Lecce','3317889003');


#inserimento dati nella tabella fornizione
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(1,300.00,1,2);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(2,200.00,2,3);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(3,200.00,5,2);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(4,150.00,15,3);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(5,200.00,11,5);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(6,150.00,4,3);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(7,150.00,13,6);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(8,100.00,8,4);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(9,200.00,7,6);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(10,100.00,10,1);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(11,200.00,9,1);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(12,100.00,3,4);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(13,250.00,6,5);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(14,250.00,14,6);
INSERT INTO Fornitura(IdFornitura,CostoMensile,IdVeicolo,IdAzienda)values(15,300.00,12,1);


############################# VISUALIZZAZIONE TABELLE ###############################


#Visualizzazione Tabelle
SHOW TABLES; 
SELECT * FROM Autonoleggio;
SELECT * FROM Impiegati;
SELECT * FROM Carica;
SELECT * FROM Servizio;
SELECT * FROM Categoria;
SELECT * FROM Costo;
SELECT * FROM Veicoli;
SELECT * FROM Noleggio;
SELECT * FROM Clienti;
SELECT * FROM AziendaFornitrice;
SELECT * FROM Fornitura;


############################# CREAZIONE QUERY ###############################


#1° Query - Il nome e il cognome di tutti gli impiegati che lavorano come meccanici e addetti alle pulizie
SELECT Impiegati.Cognome, Impiegati.Nome, Carica.Carica
FROM Impiegati 
INNER JOIN Carica ON Impiegati.IdCarica = Carica.IdCarica
WHERE (((Carica.Carica)="Meccanico")) OR (((Carica.Carica)="Addetto alle pulizie"));


#2° Query - I nomi, ordinati alfabeticamente, di tutte le automobili il cui costo noleggio è superiore o uguale a 25 euro
SELECT Veicoli.Nome, Categoria.Categoria, Costo.Costo
FROM Costo 
INNER JOIN (Categoria INNER JOIN Veicoli ON Categoria.IdCategoria = Veicoli.IdCategoria) ON Costo.IdCosto = Veicoli.IdCostoNoleggioGiornaliero
WHERE (((Categoria.Categoria)="Automobile") AND ((Costo.Costo)>=25))
ORDER BY Veicoli.Nome;


#3° Query - Il nome, il cognome di tutti i clienti che hanno noleggiato un veicolo nei mesi di luglio e agosto, eil nome del veicolo noleggiato
SELECT Clienti.Cognome, Clienti.Nome, Noleggio.DataInizioNoleggio, Noleggio.DataFineNoleggio, Veicoli.Nome
FROM Veicoli 
INNER JOIN (Noleggio INNER JOIN Clienti ON Noleggio.IdNoleggio = Clienti.IdNoleggio) ON Veicoli.IdVeicolo = Noleggio.idVeicolo
WHERE (((Noleggio.DataInizioNoleggio)>='2023-07-01') And ((Noleggio.DataInizioNoleggio)<= '2023-08-31') And ((Noleggio.DataFineNoleggio) >='2023-07-01') And ((Noleggio.DataFineNoleggio) <= '2023-08-31'));


#4° Query - Il nome e la categoria dei veicoli di cui il costo di fornitura, in ordine crescente, è maggiore di 150 euro, l'azienda che gli fornisce 
SELECT Veicoli.Nome, Categoria.Categoria, Fornitura.CostoMensile, AziendaFornitrice.Nome
FROM Categoria 
INNER JOIN (Veicoli INNER JOIN (AziendaFornitrice INNER JOIN Fornitura ON AziendaFornitrice.IdAzienda = Fornitura.IdAzienda) ON Veicoli.IdVeicolo = Fornitura.IdVeicolo) ON Categoria.IdCategoria = Veicoli.IdCategoria
WHERE (((Fornitura.CostoMensile)>150))
ORDER BY Fornitura.CostoMensile;


#5° Query - Conteggio dei veicoli forniti da ogni azienda e somma totale della fornitura per ognuna
SELECT Count(Fornitura.IdFornitura) AS NumeroForniture, AziendaFornitrice.Nome, Sum(Fornitura.CostoMensile) AS TotaleCostoForniture
FROM AziendaFornitrice 
INNER JOIN Fornitura ON AziendaFornitrice.IdAzienda = Fornitura.IdAzienda
GROUP BY AziendaFornitrice.Nome;


#6° Query - Guadagno totale per le aziende che hanno effettuato i noleggi
SELECT Autonoleggio.Nome, Sum(Noleggio.CostoTotaleNoleggio) AS GuadagnoNoleggi
FROM (Autonoleggio 
INNER JOIN Veicoli ON Autonoleggio.IdAutonoleggio = Veicoli.idAutonoleggio) 
INNER JOIN Noleggio ON Veicoli.IdVeicolo = Noleggio.idVeicolo
GROUP BY Autonoleggio.Nome;


#7° Query - Elenco in ordine alfabetico di tutti gli impiegati conpreso di codice fiscale, recapito telefonico e la carica che ricropono
SELECT Impiegati.Cognome, Impiegati.Nome, Impiegati.CodFiscale, Impiegati.Recapito, Carica.Carica
FROM Impiegati 
INNER JOIN Carica ON Carica.IdCarica = Impiegati.IdCarica
ORDER BY Impiegati.Cognome;

######################################## FINE ###########################################










