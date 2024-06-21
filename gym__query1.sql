Create Database Vishal_pal_GYM_DBMS;

USE Vishal_pal_GYM_DBMS;

Create table Members(
MId int primary key identity(2011,1),
Name nvarchar(50),
joining_date nvarchar(30) ,
Contact_info nvarchar(15),
Supplement_opted BIT,
SFD int,
Training_opted BIT,
Trainer_id int 
foreign key(Trainer_id) references Trainers_Available(TID) ,
Gym_Price int);

alter table Members add foreign key (SFD) references Supplements_Available(SFD);
update Members set Gym_Price = 2000 where MId = 2013;
delete from Members where Name = 'Prashant Kumar';




Create table Trainers_Available(
TID int primary key identity(201,1),
Trainer_Name nvarchar(50),
Trainer_contact nvarchar(10),
Trainer_fee int);

drop table Members;
drop table Trainers_Available;
drop table Supplements_Available;

Create table Supplements_Available(
SFD int primary key identity(101,1),
BCAA_Price int,
Fish_Oil_Price int,
Whey_Protein_Price int ,
L_Glutamine_Price int,
Grand_Supplement_Total int
)

Select * from Supplements_Available;
Select * from Members;
Select * from Trainers_Available;

insert into Members values ('Raj Aryan Sinha','05MAY2023',7906869882,1,101,1,201,2000);
insert into Members values ('Vivek singh','01MAY2023',6986593214,0,NULL,1,202,3000);
insert into Members values ('Prashant Kumar','27April2023',8659324196,1,103,0,NULL,2000);





insert into Supplements_Available values(0,1500,2500,0,4000);
insert into Supplements_Available values(3000,1500,0,0,4500);
insert into Supplements_Available values(0,0,2500,3500,6000);








insert into Trainers_Available values('Yash',6869963232,5500);
insert into Trainers_Available values('Ramlal',9569963232,2500);
insert into Trainers_Available values('Tarun',9569947232,8500);








/*stored procedure for insert TABLE1*/

create proc spinsert
@MId int,
@Name nvarchar(50),
@joining_date nvarchar(30),
@Contact_info nvarchar(15),
@Supplement_opted BIT,
@SFD int,
@Training_opted BIT,
@Trainer_Id int,
@Gym_Price int
as 
begin
insert into Members values (@Name,@joining_date,@Contact_info,@Supplement_opted,@SFD,@Training_opted,@Trainer_Id,@Gym_Price)
end;


execute spinsert
@MId='2011',
@Name='Raj Aryan Sinha',
@joining_date='05MAY2023',
@Contact_info=7906869882,
@Supplement_opted=1,
@SFD=101,
@Training_opted=1,
@Trainer_Id=201,
@Gym_Price=2000;



SET IDENTITY_INSERT Members ON;


Drop procedure[spinsert];
Go

/*store procedure for update*/
CREATE PROCEDURE UpdateMember
  @MId int,
  @Supplement_opted bit,
  @SFD int
AS
BEGIN
  UPDATE Members
  SET Supplement_Opted = @Supplement_opted,
      SFD = @SFD
  WHERE MId = @MId;
END

EXEC UpdateMember
  @MId = 2011,  
  @Supplement_opted = 1,  
  @SFD = 15;  

/*delete using stored procedure*/
CREATE PROCEDURE DeleteMembers
  @MId int,
  @Joining_date nvarchar(30)
AS
BEGIN
  DELETE FROM Members
  WHERE MId = @MId OR joining_Date = @joining_date;
END

EXEC DeleteMembers
  @MId = 2011,  
  @joining_Date = '2023-01-01';


/*select using stored procedure*/
CREATE PROCEDURE GetMembers
AS
BEGIN
  SELECT * FROM Members;
END

EXEC GetMembers;


/*TRIGGER*/
CREATE TRIGGER UpdateGymPrice
ON Members
after update
as
begin
  IF update(Training_opted)
  BEGIN
    update M
    SET Gym_Price = CASE
                     when M.Training_opted = 1 then 200
                     else 150
                   end
    FROM Members M
    INNER JOIN inserted I ON M.MId = I.MId;
  end
end





















Select Members.Name,Members.Contact_info,
Members.joining_date,
Members.Gym_Price,
Trainers_Available.Trainer_Name,
Trainers_Available.Trainer_contact,
Trainers_Available.Trainer_fee,
Supplements_Available.BCAA_Price,
Supplements_Available.Fish_Oil_Price,
Supplements_Available.Whey_Protein_Price,
Supplements_Available.L_Glutamine_Price 
from Members Inner join Trainers_Available ON Members.Trainer_ID=Trainers_Available.TID
Inner join Supplements_Available ON Members.SFD=Supplements_Available.SFD;




Select Members.Name,Members.Contact_info,
Members.joining_date,
Members.Gym_Price,
Trainers_Available.Trainer_Name,
Trainers_Available.Trainer_contact,
Trainers_Available.Trainer_fee,
Supplements_Available.BCAA_Price,
Supplements_Available.Fish_Oil_Price,
Supplements_Available.Whey_Protein_Price,
Supplements_Available.L_Glutamine_Price,
Supplements_Available.Grand_Supplement_Total
from Members full join Trainers_Available ON Members.Trainer_ID=Trainers_Available.TID
full join Supplements_Available ON Members.SFD=Supplements_Available.SFD;












/*join using stored procedure*/
CREATE PROCEDURE GetMembersWithTrainers
AS
BEGIN
  SELECT M.Name,M.Contact_info,T.Trainer_Name
  FROM Members M
  INNER JOIN Trainers_Available T ON M.Trainer_id = T.TID;
END

EXEC GetMembersWithTrainers;






