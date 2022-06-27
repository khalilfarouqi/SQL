Create database GESCOM

use GESCOM
-----------------------------Create-----------------------------
Create table CLIENT(
	CodeCli varchar(5) Primary key,
	NomC varchar(25),
	CatC int,
	VilC varchar(25)
)
Create table ARTICLE(
	CodeArt varchar(5) Primary key,
	NomA varchar(25),
	Couleur varchar(25),
	PrixAchat int,
	PrixVente int,
	Qte_Stk int
)
Create table COMMANDE(
	NumCom int Primary key,
	CodeCli varchar(5) references CLIENT(CodeCli),
	DateCom date
)
Create table DETAILCOM(
	NumCom int references COMMANDE(NumCom),
	CodeArt varchar(5) references ARTICLE(CodeArt),
	Qte_Com int,
	primary key (NumCom,CodeArt)
)
-----------------------------Insert-----------------------------
insert into CLIENT values ('C001','Martin',2,'Londres')
insert into CLIENT values ('C002','Dupont',1,'Paris')
insert into CLIENT values ('C003','Lebrave',3,'Londres')
insert into CLIENT values ('C004','Csimple',2,'Londres')
insert into CLIENT values ('C005','Martin',3,'Nice')
insert into CLIENT values ('C006','Lebon',1,'Genéve')
insert into CLIENT values ('C007','Dupin',1,'Paris')

insert into ARTICLE values ('A100','Jupe','Rouge',170,289,10)
insert into ARTICLE values ('A200','Robe','Rouge',180,329,15)
insert into ARTICLE values ('A300','Robe','Blanche',185,339,20)
insert into ARTICLE values ('A400','Chemise','Blanche',100,199,10)
insert into ARTICLE values ('A500','Chemise','Rouge',100,199,5)
insert into ARTICLE values ('A600','Veste','Bleue',245,399,7)

insert into COMMANDE values (970817,'C003','1997/08/04')
insert into COMMANDE values (970818,'C003','1997/08/05')
insert into COMMANDE values (970819,'C001','1997/08/20')
insert into COMMANDE values (970920,'C005','1997/09/05')
insert into COMMANDE values (970925,'C007','1997/09/07')
insert into COMMANDE values (970927,'C007','1997/09/17')
insert into COMMANDE values (970930,'C001','1997/09/20')
insert into COMMANDE values (970904,'C001','1997/10/04')

insert into DETAILCOM values (970817,'A100',1)
insert into DETAILCOM values (970817,'A200',5)
insert into DETAILCOM values (970817,'A300',2)
insert into DETAILCOM values (970817,'A500',2)
insert into DETAILCOM values (970818,'A500',8)
insert into DETAILCOM values (970818,'A600',2)
insert into DETAILCOM values (970819,'A100',3)
insert into DETAILCOM values (970819,'A500',7)
insert into DETAILCOM values (970819,'A600',2)
insert into DETAILCOM values (970925,'A200',7)
insert into DETAILCOM values (970925,'A500',7)
insert into DETAILCOM values (970927,'A600',6)
insert into DETAILCOM values (970927,'A500',1)
insert into DETAILCOM values (970927,'A200',8)
insert into DETAILCOM values (970930,'A500',8)
insert into DETAILCOM values (970904,'A100',3)
insert into DETAILCOM values (970904,'A500',8)
-----------------------------Question-----------------------------
--1
Select NomC from CLIENT
--2
Select CodeCli,CatC from CLIENT
--3
Select * from CLIENT where CatC = 3
--4
Select CodeCli from CLIENT where VilC = 'Paris'
--5
Select CodeCli from CLIENT where VilC = 'Paris' and CatC > 3
--6
Select NumCom,Qte_Com from DETAILCOM
--7
select CodeCli,NomC from CLIENT where CatC > 2
--8
Select * from ARTICLE where PrixVente >= (PrixAchat*2)
--9
Select * from ARTICLE where Couleur = 'Rouge' or PrixVente >= (PrixAchat*2)
--10
Select * from ARTICLE where Couleur <> 'Rouge' and PrixVente <= (PrixAchat*2)
--11
Select * from ARTICLE where (Couleur = 'Rouge' and PrixVente >= 250) or  Couleur = 'Bleue'
--12
Select * from ARTICLE where PrixAchat between 150 and 200 
--13
Select * from ARTICLE where Couleur in ('Bleue', 'Blanche', 'Rouge')
--14
Select * from ARTICLE where Couleur not in ('Bleue', 'Blanche', 'Rouge')
--15
Select * from CLIENT where NomC like 'BO%'
--16
Select * from CLIENT order by NomC
--17
Select * from ARTICLE where PrixAchat <= 200 order by Qte_Stk desc
--18
Select sum(PrixVente - PrixAchat) as Marge from ARTICLE
--19
Select *,PrixVente - PrixAchat as Marge from ARTICLE where PrixAchat > 100 order by Marge asc
--20
Select avg(Qte_Stk) as Moyenne from ARTICLE
--21
Select count(DISTINCT Couleur) from ARTICLE
--22
select top 1 * from ARTICLE order by PrixAchat asc
--23
select top 1 * from ARTICLE order by PrixAchat desc
--24
Select sum(Qte_Stk) from ARTICLE
--25
Select avg(Qte_Stk) from ARTICLE
Select max(PrixVente - PrixAchat) from ARTICLE
Select max(PrixVente - PrixAchat) from ARTICLE where Couleur = 'Rouge'
Select avg(Qte_Stk) as Moyenne, max(PrixVente - PrixAchat), max(PrixVente - PrixAchat) from ARTICLE where Couleur = 'Rouge'
--26
Select avg(PrixVente) from ARTICLE group by Couleur
--27
Select avg(PrixVente) from ARTICLE group by Couleur order by Couleur
--28
Select avg(PrixVente) from ARTICLE where PrixAchat >= 150 group by Couleur 
--29
Select COUNT(*) from CLIENT Group by CatC
--30
Select CodeArt, NomA from ARTICLE where Qte_Stk > (Select avg(Qte_Stk) from ARTICLE)
--31
Select * from ARTICLE as art1 where art1.Couleur in (select Couleur from ARTICLE group by Couleur having avg(PrixVente) > 200)
--32
Select NomC, Sum(Qte_Com * PrixVente) as [chiffre d'affaires] from CLIENT inner join COMMANDE inner join DETAILCOM inner join ARTICLE 
on ARTICLE.CodeArt = DETAILCOM.CodeArt on COMMANDE.NumCom = DETAILCOM.NumCom on CLIENT.CodeCli = COMMANDE.CodeCli group by NomC
--33
Select ARTICLE.CodeArt,Sum(Qte_Com) from ARTICLE inner join DETAILCOM on ARTICLE.CodeArt = DETAILCOM.CodeArt group by ARTICLE.CodeArt
Select NomA, Sum(Qte_Com) from ARTICLE inner join DETAILCOM on ARTICLE.CodeArt = DETAILCOM.CodeArt group by NomA
Select * from ARTICLE inner join DETAILCOM on ARTICLE.CodeArt = DETAILCOM.CodeArt