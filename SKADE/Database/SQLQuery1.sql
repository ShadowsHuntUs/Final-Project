Create Table logins -- data below
(
	id int IDENTITY(1,1),
	empID int NOT NULL unique,
	logUser varchar(20)  NOT NULL,
	logPass varchar(20)  NOT NULL,
	CONSTRAINT logins_pk_id PRIMARY KEY(id),
	CONSTRAINT logins_fk_empID FOREIGN KEY(empID) REFERENCES employee(id),
);

INSERT INTO logins (empID, logUser, logPass) VALUES (1,'ecarr' , 'pass');
INSERT INTO logins (empID, logUser, logPass) VALUES (2, 'sdelign', 'pass');
INSERT INTO logins (empID, logUser, logPass) VALUES (3,'edowney' , 'pass');
INSERT INTO logins (empID, logUser, logPass) VALUES (4, 'skendell', 'pass');
INSERT INTO logins (empID, logUser, logPass) VALUES (5, 'wtutti', 'pass');
INSERT INTO logins (empID, logUser, logPass) VALUES (6,'wdickey' , 'pass');
INSERT INTO logins (empID, logUser, logPass) VALUES (7, 'erosten', 'pass');

select logins.id, empID, logUser, logPass, employee.id, employee.empFirst + ' ' + employee.empLast AS 'Employee'  
from logins inner join employee on employee.id = logins.empID

