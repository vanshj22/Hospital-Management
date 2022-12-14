create database hosp3;
use hosp3;


CREATE TABLE Doctor (
  EmployeeID INTEGER NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Position VARCHAR(30) NOT NULL,
  SSN INTEGER NOT NULL,
  CONSTRAINT pk_Doctor PRIMARY KEY(EmployeeID)
); 


CREATE TABLE Department (
  DepartmentID INTEGER NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Head INTEGER NOT NULL,
  CONSTRAINT pk_Department PRIMARY KEY(DepartmentID),
  CONSTRAINT fk_Department_Doctor_EmployeeID FOREIGN KEY(Head) REFERENCES Doctor(EmployeeID)
);



CREATE TABLE Affiliated_With (
  Doctor INTEGER NOT NULL,
  Department INTEGER NOT NULL,
  PrimaryAffiliation BIT NOT NULL,
  CONSTRAINT fk_Affiliated_With_Doctor_EmployeeID FOREIGN KEY(Doctor) REFERENCES Doctor(EmployeeID),
  CONSTRAINT fk_Affiliated_With_Department_DepartmentID FOREIGN KEY(Department) REFERENCES Department(DepartmentID),
  PRIMARY KEY(Doctor, Department)
);


CREATE TABLE Procedures (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Cost REAL NOT NULL
);



CREATE TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Address VARCHAR(30) NOT NULL,
  Phone VARCHAR(30) NOT NULL,
  InsuranceID INTEGER NOT NULL,
  PCP INTEGER NOT NULL,
  CONSTRAINT fk_Patient_Doctor_EmployeeID FOREIGN KEY(PCP) REFERENCES Doctor(EmployeeID)
);

CREATE TABLE Nurse (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Position VARCHAR(30) NOT NULL,
  Registered BIT NOT NULL,
  SSN INTEGER NOT NULL
);


CREATE TABLE Appointment (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,    
  PrepNurse INTEGER,
  Doctor INTEGER NOT NULL,
  Starto DATETIME NOT NULL,
  Endo DATETIME NOT NULL,
  ExaminationRoom TEXT NOT NULL,
  CONSTRAINT fk_Appointment_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Appointment_Nurse_EmployeeID FOREIGN KEY(PrepNurse) REFERENCES Nurse(EmployeeID),
  CONSTRAINT fk_Appointment_Doctor_EmployeeID FOREIGN KEY(Doctor) REFERENCES Doctor(EmployeeID)
);



CREATE TABLE Medication (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Brand VARCHAR(30) NOT NULL,
  Description VARCHAR(30) NOT NULL
);



CREATE TABLE Prescribes (
  Doctor INTEGER NOT NULL,
  Patient INTEGER NOT NULL, 
  Medication INTEGER NOT NULL, 
  Date DATETIME NOT NULL,
  Appointment INTEGER,  
  Dose VARCHAR(30) NOT NULL,
  PRIMARY KEY(Doctor, Patient, Medication, Date),
  CONSTRAINT fk_Prescribes_Doctor_EmployeeID FOREIGN KEY(Doctor) REFERENCES Doctor(EmployeeID),
  CONSTRAINT fk_Prescribes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Prescribes_Medication_Code FOREIGN KEY(Medication) REFERENCES Medication(Code),
  CONSTRAINT fk_Prescribes_Appointment_AppointmentID FOREIGN KEY(Appointment) REFERENCES Appointment(AppointmentID)
);


CREATE TABLE Block (
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  PRIMARY KEY(BlockFloor, BlockCode)
); 


CREATE TABLE Room (
  RoomNumber INTEGER PRIMARY KEY NOT NULL,
  RoomType VARCHAR(30) NOT NULL,
  BlockFloor INTEGER NOT NULL,  
  BlockCode INTEGER NOT NULL,  
  Unavailable BIT NOT NULL,
  CONSTRAINT fk_Room_Block_PK FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode)
);


CREATE TABLE On_Call (
  Nurse INTEGER NOT NULL,
  BlockFloor INTEGER NOT NULL, 
  BlockCode INTEGER NOT NULL,
  OnCallStart DATETIME NOT NULL,
  OnCallEnd DATETIME NOT NULL,
  PRIMARY KEY(Nurse, BlockFloor, BlockCode, OnCallStart, OnCallEnd),
  CONSTRAINT fk_OnCall_Nurse_EmployeeID FOREIGN KEY(Nurse) REFERENCES Nurse(EmployeeID),
  CONSTRAINT fk_OnCall_Block_Floor FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode) 
);


CREATE TABLE Stay (
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
  Room INTEGER NOT NULL,
  StayStart DATETIME NOT NULL,
  StayEnd DATETIME NOT NULL,
  CONSTRAINT fk_Stay_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Stay_Room_Number FOREIGN KEY(Room) REFERENCES Room(RoomNumber)
);


CREATE TABLE Undergoes (
  Patient INTEGER NOT NULL,
  Procedures INTEGER NOT NULL,
  Stay INTEGER NOT NULL,
  DateUndergoes DATETIME NOT NULL,
  Doctor INTEGER NOT NULL,
  AssistingNurse INTEGER,
  PRIMARY KEY(Patient, Procedures, Stay, DateUndergoes),
  CONSTRAINT fk_Undergoes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Undergoes_Procedures_Code FOREIGN KEY(Procedures) REFERENCES Procedures(Code),
  CONSTRAINT fk_Undergoes_Stay_StayID FOREIGN KEY(Stay) REFERENCES Stay(StayID),
  CONSTRAINT fk_Undergoes_Doctor_EmployeeID FOREIGN KEY(Doctor) REFERENCES Doctor(EmployeeID),
  CONSTRAINT fk_Undergoes_Nurse_EmployeeID FOREIGN KEY(AssistingNurse) REFERENCES Nurse(EmployeeID)
);
  
  
INSERT INTO Doctor VALUES(1,'Ashwin Shibu','Staff Internist',111111111);
INSERT INTO Doctor VALUES(2,'Aayush Kapoor','Attending Doctor',222222222);
INSERT INTO Doctor VALUES(3,'Siddharth Choudary','Surgical Attending Doctor',333333333);
INSERT INTO Doctor VALUES(4,'Vansh Jain','Senior Attending Doctor',444444444);
INSERT INTO Doctor VALUES(5,'Alok John','Head Chief of Medicine',555555555);
INSERT INTO Doctor VALUES(6,'Bruce Wayne','Surgical Attending Doctor',666666666);
INSERT INTO Doctor VALUES(7,'Tony Stark','Surgical Attending Doctor',777777777);
INSERT INTO Doctor VALUES(8,'Steven Strange','MD Resident',888888888);
INSERT INTO Doctor VALUES(9,'Peter Parker','Emergency Doctor',999999999);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Emergency',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'Hussain Baadshah','BITS','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Utkarsh Som','Jumeirah','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Agrim Jain','Deira','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Harsh Vegad','BITS','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Kaunain Fatima','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Garima Dodeja','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Sstuti Deepak','Nurse',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);


# WRITE A SQL QUERY TO FIND THOSE DOCTORS WHO ARE THE HEAD OF THE DEPARTMENT
SELECT d.name AS "Department",
       p.name AS "Doctor"
FROM department d,
     Doctor p
WHERE d.head=p.employeeid;


# WRITE A SQL QUERY TO COUNT THE NUMBER AVAILABLE ROOMS
SELECT count(*) "Number of available rooms"
FROM room
WHERE unavailable='false';


# WRITE A SQL QUERY TO FIND THE DOCTOR AND THE DEPARTMENTS THEY ARE AFFILIATED WITH
SELECT p.name AS "Doctor",
       d.name AS "Department"
FROM Doctor p,
     department d,
     affiliated_with a
WHERE p.employeeid=a.Doctor
  AND a.department=d.departmentid;


# WRITE A SQL QUERY TO FIND THE NAME OF THE NURSES AND THE ROOM SCHEDULED
SELECT DISTINCT n.name AS "Name of the Nurse",
       a.examinationroom AS "Room No."
FROM nurse n
JOIN appointment a ON a.prepnurse=n.employeeid;

# WRITE A SQL QUERY TO FIND THOSE PATIENTS WHO TAKEN THE APPOINTMENT ON THE 25TH OF APRIL AT 10 AM.
SELECT t.name AS "Name of the Patient",
       n.name AS "Name of the Nurse assisting the Doctor",
       p.name AS "Name of the Doctor",
       a.examinationroom AS "Room No.",
       a.starto
FROM Patient t
JOIN appointment a ON a.Patient=t.ssn
JOIN nurse n ON a.prepnurse=n.employeeid
JOIN Doctor p ON a.Doctor=p.employeeid
WHERE starto='2008-04-26 11:00:00';

#  WRITE A SQL QUERY TO FIND THOSE PATIENTS WHO DID NOT TAKE ANY APPOINTMENT
SELECT t.name AS "Patient",
       p.name AS "Doctor",
       m.name AS "Medication"
FROM Patient t
JOIN prescribes s ON s.Patient=t.ssn
JOIN Doctor p ON s.Doctor=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NULL;

# WRITE A SQL QUERY TO COUNT THE NUMBER OF AVAILABLE ROOMS IN EACH FLOOR
SELECT blockfloor AS "Floor",
       count(*) "Number of available rooms"
FROM room
WHERE unavailable='false'
GROUP BY blockfloor
ORDER BY blockfloor;

# WRITE A SQL QUERY TO FIND THE NAME OF THE PATIENTS, THEIR BLOCK, FLOOR, AND ROOM NUMBER WHERE THEY ADMITTED
SELECT p.name AS "Patient",
       s.room AS "Room",
       r.blockfloor AS "Floor",
       r.blockcode AS "Block"
FROM stay s
JOIN Patient p ON s.Patient=p.ssn
JOIN room r ON s.room=r.roomnumber;


# WRITE A SQL QUERY TO FIND THOSE PATIENTS WHO HAVE TAKEN AN ADVANCED APPOINTMENT
SELECT t.name AS "Patient",
       p.name AS "Doctor",
       m.name AS "Medication"
FROM Patient t
JOIN prescribes s ON s.Patient=t.ssn
JOIN Doctor p ON s.Doctor=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NOT NULL;


# CREATE A VIEW TO LIST SURGICAL ATTENDING DOCTORS
CREATE VIEW Doctor_info
AS SELECT 
	EmployeeID,
    Name
FROM Doctor
WHERE position ='Surgical Attending Doctor';

select * from Doctor_info;

# CREATE A VIEW TO LIST DOCTORS WHO ARE IN EMERGENCY
CREATE VIEW appointment_info
AS SELECT d.Name
FROM Department de, Doctor d, affiliated_with a
WHERE de.DepartmentID = a.Department
AND d.EmployeeID = a.Doctor
AND de.Name = 'Emergency';

select * from appointment_info;

#CREATE A PROCEDURE WHICH DISPLAYS THE NAMES OF ALL THE NURSES HAVING THEIR ON CALL END AT 19:00:00 
DELIMITER //
CREATE PROCEDURE onCallNurses()
BEGIN
	SELECT DISTINCT n.Name AS 'Nurses On Call' 
    FROM Nurse n, on_call o
    WHERE  o.OnCallEnd LIKE '%19:00:00'  
    AND n.EmployeeID = o.nurse;
END //

call onCallNurses();


#CREATE A PROCEDURE WHICH DISPLAYS THE NAMES OF ALL THE PATIENTS HAVING MEDICATION FROM X BRAND

DELIMITER //
CREATE PROCEDURE xPatients()
BEGIN
	SELECT p.name 
    FROM Patient p,prescribes pr, medication m
    WHERE m.brand = 'X' 
    AND pr.medication = m.code AND
    p.SSN = pr.Patient;
END //

call xPatients();



#CREATE A TRIGGER FOR DELETING OLDEST APPOINTMENT WHEN NEW APPOINTMENT IS INSERTED
DELIMITER //
CREATE TRIGGER appointment_AFTER_UPDATE AFTER INSERT ON appointment
FOR EACH ROW
BEGIN
DELETE FROM appointment 
WHERE Starto = '2008-04-24 10:00:00' AND Endo ='2008-04-24 11:00:00' ;
END//

INSERT INTO appointment VALUES(56746179,100000001,103,4,'2008-04-27 11:00:00','2008-04-27 12:00:00','A' );
