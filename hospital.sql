create database hosp2;
use hosp2;
drop table doctor;

create table doctor(
doc_id int(5),
doc_name varchar(100),
speciality varchar(50),
doc_age int(3),
doc_gender varchar(1),
doc_address varchar(100),
doc_ph_no int (15),
primary key(doc_id)
);

insert into doctor values(10001,"Dr. Vansh Jain", "Cardiology", 18, "M","BITS",123456);
insert into doctor values(10002,"Dr. Ashwin Shibu", "Pediatrics", 20, "M","Deira",438893);
insert into doctor values(10003,"Dr. Siddharth Choudary", "Orthopedics", 19, "M","IC",583962);
insert into doctor values(10004,"Dr. Aayush Kapoor", "Radiology", 20, "M","Jumeirah",247057);
insert into doctor values(10005,"Dr. Pramod Gaur", "Neurology", 40, "M","Deira",927059);
insert into doctor values(10006,"Dr. R.K Mishra", "Emergency", 35, "M","BITS",270585);
insert into doctor values(10007,"Dr. Sapna Sadhwani","Internal Medicine", 34, "F","Silicon Oasis",964794);
insert into doctor values(10008,"Dr. Tamizharasan Periyasamy","Pediatrics", 43, "M","Jumeirah",4562279);
insert into doctor values(10009,"Dr. Aamina Taskeen", "Paediatrics", 20, "F","BITS",871354);
insert into doctor values(10010,"Dr. Agrim Jain", "Cardiology", 19, "M","Silicon Oasis",053522);

create table patient(
pat_id int(5),
pat_name varchar(100),
diagnosis varchar(200),
pat_age int(3),
pat_gender varchar(1),
pat_height int(3),
pat_weight int(3),
pat_dob date,
pat_address varchar(100),
pat_ph_no int (15),
doc_id int,
primary key(pat_id)
);

alter table patient
add foreign key(doc_id) references doctor(doc_id) );

insert into patient values(20001,"Dr. Agrim Jain", "COVID", 19, "M",178,72,12/04/2003,"Silicon Oasis",053522);
insert into patient values(20002,"Jay Parida", "Stomach ache", 21, "M",178,72,12/04/2000,"BITS",469859);
insert into patient values(20003,"Utkarsh Som", "polio", 20, "M",178,72,12/04/2003,"Jumeirah",754861);
insert into patient values(20004,"Harsh Vegad", "COVID", 25, "M",178,72,12/04/2003,"IC",745962);
insert into patient values(20005,"Ashutosh Pandey", "Ebola", 30, "M",178,72,12/04/2003,"BITS",459762);
insert into patient values(20006,"Harshit Nair", "Knee Fracture ", 36, "M",178,72,12/04/2003,"Silicon Oasis",485621);
insert into patient values(20007,"Arshdeep Singh","Skull Fracture" , 50, "M",178,72,12/04/2003,"IC",745698);
insert into patient values(20008,"Dr. Pramod Gaur", "Common Cold", 40, "M",178,72,12/04/2003,"Deira",130866);
insert into patient values(20009,"Gitanshu Karangale", "AIDS", 62, "M",178,72,12/04/2003,"Jumeirah",080464);
insert into patient values(200010,"Protik Mitra", "lung cancer", 55, "M",178,72,12/04/2003,"BITS",550910);

create table staff(
staff_id int(5),
staff_name varchar(100),
staff_role varchar(50),
staff_age int(3),
staff_gender varchar(1),
staff_address varchar(100),
staff_ph_no int (15),
primary key(staff_id)
);

insert into staff values(30001,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30002,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30003,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30004,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30005,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30006,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30007,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30008,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30009,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);
insert into staff values(30010,"Jagdish Nayak", "nurse", 50, "M","BITS",052132);

drop table staff;

create table room(
room_no int(3),
room_name varchar(20),
available boolean,
primary key (room_no),
pat_id int ,
doc_id int
);

alter table room 
add foreign key (pat_id) references patient(pat_id);

alter table room 
add foreign key (doc_id) references doc(doc_id);


insert into room values(101,"Ward", false);
insert into room values(102,"Ward", false);
insert into room values(103,"Ward", false);
insert into room values(104,"Ward", false);
insert into room values(105,"Ward", false);
insert into room values(106,"Ward", false);
insert into room values(107,"Ward", false);
insert into room values(108,"Ward", false);
insert into room values(109,"Ward", false);
insert into room values(210,"Ward", false);
insert into room values(201,"Ward", false);
insert into room values(202,"Ward", false);
insert into room values(203,"Ward", false);
insert into room values(204,"Ward", false);
insert into room values(205,"Ward", false);
insert into room values(206,"Ward", false);
insert into room values(207,"Ward", false);
insert into room values(208,"Ward", false);
insert into room values(209,"Ward", false);
insert into room values(210,"Ward", false);

###################################################################################

#List all doctors 
select * from doctor;

#List all patients 
select * from patient;

#List all staff 
select * from staff;

#List all available wards 
select * from room 
where available is false;

