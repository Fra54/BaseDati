#Fase di importazione
from sqlalchemy import Column, Integer, String, Date, FLOAT, Table, MetaData, ForeignKey
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import and_, or_, func
import sys


def trycommit():
    try:
        session.commit()
    except:
        session.rollback()
        e = sys.exc_info()
        print("C'è stato un errore ")
        print(e)


###################################### CONNESSIONE #########################################

engine = create_engine('mysql+mysqlconnector://root:afras21306@127.0.0.1:3306/autonoleggi',  isolation_level='READ COMMITTED') 
conn = engine.connect()

metadata = MetaData()
metadata.reflect(engine)

Session = sessionmaker(bind = engine)
session = Session()

Base = declarative_base()

################################# DICHIARAZIONE TABELLE NEL DATABASE ####################################

class Autonoleggio(Base):
        __tablename__ = 'autonoleggio'
        IdAutonoleggio = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        Nome = Column(String(length=40))
        Indirizzo = Column(String(length=60))
        Città = Column(String(length=30))
        Telefono = Column(String(length=15))
        #relazioni
        impiegati = relationship("Impiegati", back_populates="autonoleggio")
        servizio = relationship("Servizio", back_populates="autonoleggio")
        veicoli = relationship("Veicoli", back_populates="autonoleggio")

class Carica(Base):
        __tablename__ = 'carica'
        IdCarica = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        Carica = Column(String(length=50))
        #relazioni
        impiegati = relationship("Impiegati", back_populates="carica")

class Impiegati(Base):
        __tablename__ = 'impiegati'
        CodFiscale = Column(String(length=16), primary_key=True, nullable=False)
        Cognome = Column(String(length=30))
        Nome = Column(String(length=30))
        Recapito = Column(String(length=15))
        IdCarica =Column(Integer, ForeignKey('carica.IdCarica'))
        IdAutonoleggio =Column(Integer, ForeignKey('autonoleggio.IdAutonoleggio'))
        #relazioni
        carica = relationship("Carica", back_populates="impiegati")
        autonoleggio = relationship("Autonoleggio", back_populates="impiegati")
        servizio = relationship("Servizio", back_populates="impiegati")


class Servizio(Base):
        __tablename__ = 'servizio'
        IdServizio = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        DataInizio = Column(Date) 
        DataFine = Column(Date) 
        Impiegato =Column(String(length=16), ForeignKey('impiegati.CodFiscale'))
        IdAutonoleggio =Column(Integer, ForeignKey('autonoleggio.IdAutonoleggio'))
        #relazioni
        impiegati = relationship("Impiegati", back_populates="servizio")
        autonoleggio = relationship("Autonoleggio", back_populates="servizio")


class Categoria(Base):
        __tablename__ = 'categoria'
        IdCategoria = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        Categoria = Column(String(length=30))
        #relazioni
        veicoli = relationship("Veicoli", back_populates="categoria")

class Costo(Base):
        __tablename__ = 'costo'
        IdCosto = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        Costo = Column(FLOAT)
        #relazioni
        veicoli = relationship("Veicoli", back_populates="costo")

class Veicoli(Base):
        __tablename__ = 'veicoli'
        IdVeicolo = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        Targa = Column(String(length=10))
        IdCategoria =Column(Integer, ForeignKey('categoria.IdCategoria'))
        Nome = Column(String(length=50))
        Posti = Column(Integer)
        IdCostoNoleggioGiornaliero =Column(Integer, ForeignKey('costo.IdCosto'))
        IdAutonoleggio =Column(Integer, ForeignKey('autonoleggio.IdAutonoleggio'))
        #relazioni
        autonoleggio = relationship("Autonoleggio", back_populates="veicoli")
        categoria = relationship("Categoria", back_populates="veicoli")
        costo = relationship("Costo", back_populates="veicoli")
        noleggio = relationship("Noleggio", back_populates="veicoli")
        fornitura = relationship("Fornitura", back_populates="veicoli")

class Noleggio(Base):
        __tablename__ = 'noleggio'
        IdNoleggio = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        DataInizioNoleggio = Column(Date) 
        DataFineNoleggio = Column(Date) 
        CostoTotaleNoleggio = Column(FLOAT)
        IdVeicolo =Column(Integer, ForeignKey('veicoli.IdVeicolo'))
        #relazioni
        veicoli = relationship("Veicoli", back_populates="noleggio")
        clienti = relationship("Clienti", back_populates="noleggio")

class Clienti(Base):
        __tablename__ = 'clienti'
        CodFiscale = Column(String(length=16), primary_key=True, nullable=False)
        Cognome = Column(String(length=30))
        Nome = Column(String(length=30))
        IdNoleggio =Column(Integer, ForeignKey('noleggio.IdNoleggio'))
        #relazioni
        noleggio = relationship("Noleggio", back_populates="clienti")

class AziendaFornitrice(Base):
        __tablename__ = 'aziendafornitrice'
        IdAzienda = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        Nome = Column(String(length=50))
        Indirizzo = Column(String(length=60))
        Città = Column(String(length=30))
        Telefono = Column(String(length=15))
        #relazioni
        fornitura = relationship("Fornitura", back_populates="aziendafornitrice")

class Fornitura(Base):
        __tablename__ = 'fornitura'
        IdFornitura = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
        CostoMensile = Column(FLOAT)
        IdVeicolo =Column(Integer, ForeignKey('veicoli.IdVeicolo'))
        IdAzienda =Column(Integer, ForeignKey('aziendafornitrice.IdAzienda'))
        #relazioni
        veicoli = relationship("Veicoli", back_populates="fornitura")
        aziendafornitrice = relationship("AziendaFornitrice", back_populates="fornitura")

Base.metadata.create_all(engine)


############################# INSERIMENTO DATI NELLE TABELLE ################################


#inserimento dati in AziendaFornitrice
rows = [
      AziendaFornitrice(
                     Nome = 'Ford', 
                     Indirizzo = 'Via Garibaldi',
                     Città ='Torino',
                     Telefono = '3276889005'),

      AziendaFornitrice(
                     Nome = 'Hyundai', 
                     Indirizzo = 'Via Dardanelli', 
                     Città ='Genova', 
                     Telefono = '3228400116'),

      AziendaFornitrice(
                     Nome = 'Nissan', 
                     Indirizzo = 'Via Sottoriva', 
                     Città ='Verona', 
                     Telefono = '3403259996')
     
 ]
session.add_all(rows)
trycommit()


#inserimento dati in Categoria

I1 = Categoria(Categoria = 'Direttore')

session.add(I1)
trycommit()

I2 = Categoria(Categoria = 'Gestore sito web')

session.add(I2)
trycommit()


#Inserimento dati in clienti e noleggio
C1 = Clienti(
           CodFiscale = 'MNTGPP79C14D862N', 
           Cognome = 'Monteleone', 
           Nome = 'Giuseppe', 
           IdNoleggio = 9)
C1.noleggio = Noleggio(
                  IdNoleggio = 9, 
                  DataInizioNoleggio = '2023-03-04', 
                  DataFineNoleggio = '2023-03-05', 
                  CostoTotaleNoleggio = 60, 
                  IdVeicolo = 6)

session.add(C1)                
trycommit()


##################################### AGGIORNAMENTO DATI #############################################

#Aggiornamento riga
session.query(AziendaFornitrice).filter(AziendaFornitrice.Indirizzo == 'Via Piave').update({AziendaFornitrice.Indirizzo: 'Via Sardegna'})

session.query(Clienti).filter(Clienti.Cognome == 'Mura').update({Clienti.Cognome: 'Girola'})

session.query(Autonoleggio).filter(Autonoleggio.Telefono == '3313295671').update({Autonoleggio.Telefono: '3403080556'})

session.query(Categoria).filter(Categoria.Categoria == 'Automobile').update({Categoria.Categoria: 'Auto'})

session.query(Autonoleggio).filter(Autonoleggio.IdAutonoleggio == 5).update({Autonoleggio.Indirizzo: 'Via Ravenna', Autonoleggio.Città: 'Pescara'})

trycommit()


#################################### ELIMINAZIONE DATI ################################################


# Eliminazione tuple in Fornitura in base al valore della chiave primaria
session.query(Fornitura).filter(Fornitura.IdFornitura >= 10).delete()

session.commit()



#Eliminazione tuble in Veicoli in base al valore del nome auto
query = session.query(Veicoli).filter(Veicoli.Nome == 'Fiat 500')
data = query.all()
print(data)
for item in range(len(data)):
            session.delete(data[item])
trycommit()



#Eliminazione riga in Servizio
query = session.query(Servizio).filter( and_ (Servizio.DataInizio == '2023-02-22', Servizio.DataFine == '2023-05-31'))
data = query.all()
for item in range(len(data)):
            session.delete(data[item])
            print(data[item].DataInizio)


################################## QUERY ########################################


#1° Query - Veicoli che hanno 4 posti

query = session.query(Veicoli).filter(Veicoli.Posti == 4)
rows = query.all()
#Visualizza la query
for item in range(len(rows)):
    print(rows[item].Nome, rows[item].Posti)




#2° Query - Il nome e il cognome di tutti gli impiegati che svolgono la carica di venditore

NCV = session.query(Impiegati, Carica).filter(and_ ((Impiegati.Cognome),
                                                      (Impiegati.Nome),
                                                      (Impiegati.IdCarica == Carica.IdCarica),
                                                      (Carica.Carica == 'Venditore')))
rows = NCV.all()
#Visualizza query
for item in range(len(rows)):
        print(rows[item].Cognome,rows[item].Nome, rows[item].Carica)




#3° Query - Conta quanti veicoli costano piu di 20 euro per essere noleggiati

CVN = session.query(Veicoli, Costo).filter(and_(func.count(Veicoli.IdCostoNoleggioGiornaliero == Costo.IdCosto)),
                                                 (Costo.IdCosto > 20)).all()
#Visualizza query
for item in CVN:
        print(CVN[item].IdCostoNoleggioGiornaliero)





#4° Query - Somma quanto hanno fatturato in totale gli autonoleggi dal noleggio dei veicoli

SAN = session.query(Noleggio).filter(func.sum(Noleggio.CostoTotaleNoleggio)).all() 
#Visualizza query
for item in SAN:
        print(SAN[item].CostoTotaleNoleggio)





#5° Query - IL nome e il cognome dei clienti che hanno spreso piu di 150 euro per il noleggio dei veicoli e il nome del veicolo

NCC = session.query(Clienti, Noleggio, Veicoli).filter(and_(Clienti.Cognome),
                                                              (Clienti.Nome),
                                                              (Veicoli.Nome),
                                                              (Veicoli.IdVeicolo == Noleggio.IdVeicolo),
                                                              (Clienti.IdNoleggio == Noleggio.IdNoleggio),
                                                              (Noleggio.CostoTotaleNoleggio >= 150)).all()

#Visualizza query
for result in NCC:
        print(result.Cognome, result.Nome, result.CostoTotaleNoleggio) 





#6° Query - Il nome, la categoria e i posti di tutti i veicoli forniti dalla Bmw o dalla ALfa Romeo 

NCP = session.query(Veicoli, Categoria, Fornitura, AziendaFornitrice).filter(and_(Veicoli.Nome),
                                                                                    (Categoria.Categoria),
                                                                                    (Veicoli.Posti),
                                                                                    (Veicoli.IdCategoria == Categoria.IdCategoria),
                                                                                    (Veicoli.IdVeicolo == Fornitura.IdVeicolo),
                                                                                    (Fornitura.IdAzienda == AziendaFornitrice.IdAzienda),
                                                                                    (or_(AziendaFornitrice == 'Bmw',AziendaFornitrice == 'Alfa Romeo')),
                                                                                    (AziendaFornitrice.Nome)).all()
#Visualizza query
for result in NCP:
        print(result.Nome, result.Categoria, result.Posti)



########################################## FINE ###################################################
