Create Table customer -- data below
(
	id int IDENTITY(1,1),
	custFirst varchar(30),
	custLast varchar(50),
	custPhone char(10),
	custAddress varchar(60),
	custCity varchar(50),
	custPostal char(6),
	custEmail varchar(30)
	CONSTRAINT customer_pk_id PRIMARY KEY(id)
);

Create Table position -- data below
(
	id int IDENTITY(1,1),
	posName varchar(30)
	CONSTRAINT position_pk_id PRIMARY KEY(id)
);

Create Table employee -- data below
(
	id int IDENTITY(1,1),
	empFirst varchar(30),
	empLast varchar(50),
	posID int NOT NULL
	CONSTRAINT employee_pk_id PRIMARY KEY(id),
	CONSTRAINT employee_fk_posID FOREIGN KEY(posID) REFERENCES position(id),
);

Create Table equip_type -- data below
(
	id int IDENTITY(1,1),
	eqtType varchar(30)
	CONSTRAINT equiptype_pk_id PRIMARY KEY(id)
);

Create Table manufacturer 
(
	id int IDENTITY(1,1),
	manName varchar(30)
	CONSTRAINT manufacturer_pk_id PRIMARY KEY(id)
);
	
Create Table equipment --data below
(
	id int IDENTITY(1,1),
	equModel varchar(50),
	equSerial varchar(30),
	custID int NOT NULL,
	equtypeID int NOT NULL,
	equManuID int NOT NULL
	CONSTRAINT equipment_pk_id PRIMARY KEY(id),
	CONSTRAINT equipment_fk_custID FOREIGN KEY(custID) REFERENCES customer(id),
	CONSTRAINT equipment_fk_equtypeID FOREIGN KEY(equtypeID) REFERENCES equip_type(id),
	CONSTRAINT equipment_fk_equManuID FOREIGN KEY(equManuID) REFERENCES manufacturer(id)
);

Create Table payment --data below
(
	id int IDENTITY(1,1),
	payType varchar(20)
	CONSTRAINT payment_pk_id PRIMARY KEY(id)
);

Create Table receipt --data below
(
	id int IDENTITY(1,1),
	ordNumber varchar(20),
	ordDate Date,
	ordPaid bit default 0,
	paymentID int NOT NULL,
	custID int NOT NULL,
	empID int NOT NULL
	CONSTRAINT receipt_pk_id PRIMARY KEY(id),
	CONSTRAINT receipt_fk_paymentID FOREIGN KEY(paymentID) REFERENCES payment(id),
	CONSTRAINT receipt_fk_custID FOREIGN KEY(custID) REFERENCES customer(id),
	CONSTRAINT receipt_fk_empID FOREIGN KEY(empID) REFERENCES employee(id)
);

Create Table service --data below
(
	id int IDENTITY(1,1),
	serName varchar(20),
	serDescription varchar(100),
	serPrice Money
	CONSTRAINT service_pk_id PRIMARY KEY(id)
);

Create Table service_order 
(
	id int IDENTITY(1,1),
	serordDateIn Date,
	serordDateOut Date,
	serordIssue varchar(100),
	serordWarranty bit default 0,
	receiptID int NOT NULL,
	serviceID int NOT NULL,
	equipID int NOT NULL,
	empID int NOT NULL
	CONSTRAINT serord_pk_id PRIMARY KEY(id),
	CONSTRAINT serord_fk_reseiptID FOREIGN KEY(receiptID) REFERENCES receipt(id),
	CONSTRAINT serord_fk_serviceID FOREIGN KEY(serviceID) REFERENCES service(id),
	CONSTRAINT serord_fk_equipID FOREIGN KEY(equipID) REFERENCES equipment(id),
	CONSTRAINT serord_fk_empID FOREIGN KEY(empID) REFERENCES employee(id)
);

Create Table product --data below
(
	id int IDENTITY(1,1),
	prodName varchar(50),
	prodDescription varchar(100),
	prodBrand varchar(50)
	CONSTRAINT product_pk_id PRIMARY KEY(id)
);

Create Table prod_order
(
	id int IDENTITY(1,1),
	pordNumber varchar(50),
	pordDateOrdered Date,
	pordPaid bit default 0
	CONSTRAINT prodorder_pk_id PRIMARY KEY(id)
);

Create Table inventory --data below
(
	id int IDENTITY(1,1),
	invQuantity int,
	invSize decimal(5, 2),
	invMeasure varchar(20),
	invPrice money,
	productID int NOT NULL
	CONSTRAINT inventory_pk_id PRIMARY KEY(id),
	CONSTRAINT inventory_fk_productID FOREIGN KEY(productID) REFERENCES product(id)
);

Create Table on_order
(
	id int IDENTITY(1,1),
	onordInvoiceNum varchar(20),
	onordArriveDate Date,
	onordNumInOrder int,
	onordPrice money,
	inventoryID int NOT NULL,
	prodorderID int NOT NULL
	CONSTRAINT onorder_pk_id PRIMARY KEY(id),
	CONSTRAINT onorder_fk_inventoryID FOREIGN KEY(inventoryID) REFERENCES inventory(id),
	CONSTRAINT onorder_fk_prodorderID FOREIGN KEY(prodorderID) REFERENCES prod_order(id)
);

Create Table order_line
(
	id int IDENTITY(1,1),
	orlPrice money,
	orlQuantity int,
	orlOrderReq bit default 0,
	orlNote varchar(100),
	inventoryID int NOT NULL,
	receiptID int NOT NULL
	CONSTRAINT orderline_pk_id PRIMARY KEY(id),
	CONSTRAINT orderline_fk_inventoryID FOREIGN KEY(inventoryID) REFERENCES inventory(id),
	CONSTRAINT orderline_fk_receiptID FOREIGN KEY(receiptID) REFERENCES receipt(id)
);

--Inserts
--Equip_type
INSERT INTO equip_type (eqtType) VALUES ('Lawn Mower');
INSERT INTO equip_type (eqtType) VALUES ('Weedeater');
INSERT INTO equip_type (eqtType) VALUES ('Leaf blower');
INSERT INTO equip_type (eqtType) VALUES ('Chainsaw');
INSERT INTO equip_type (eqtType) VALUES ('Generator');
INSERT INTO equip_type (eqtType) VALUES ('Pressure washer');
INSERT INTO equip_type (eqtType) VALUES ('Riding Lawnmower');
INSERT INTO equip_type (eqtType) VALUES ('Snow Blower');

--Payment
INSERT INTO payment (payType) VALUES ('Visa');
INSERT INTO payment (payType) VALUES ('Mastercard');
INSERT INTO payment (payType) VALUES ('American Express');
INSERT INTO payment (payType) VALUES ('Debit');
INSERT INTO payment (payType) VALUES ('Cash');

--POsitions
INSERT INTO position (posName) VALUES ('Sales');
INSERT INTO position (posName) VALUES ('Technician');
INSERT INTO position (posName) VALUES ('Administration');
INSERT INTO position (posName) VALUES ('Manager');
INSERT INTO position (posName) VALUES ('Ordering');

--employee
INSERT INTO employee (empFirst, empLast, posID) VALUES ('Emma', 'Carr', 4);
INSERT INTO employee (empFirst, empLast, posID) VALUES ('Sam', 'Delign', 5);
INSERT INTO employee (empFirst, empLast, posID) VALUES ('Eugene', 'Downey', 2);
INSERT INTO employee (empFirst, empLast, posID) VALUES ('Sarah', 'Kendell', 2);
INSERT INTO employee (empFirst, empLast, posID) VALUES ('Wendy', 'Tutti', 1);
INSERT INTO employee (empFirst, empLast, posID) VALUES ('William', 'Dickey', 1);
INSERT INTO employee (empFirst, empLast, posID) VALUES ('Emily', 'Rosten', 3);

--Customer
INSERT INTO customer (custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES ('Bob', 'Underhill', '9058889632', '1234 Clare St', 'Welland', 'E3E4R5', 'b.underhill@gmail.com');
INSERT INTO customer (custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES ('Sandy', 'Targard', '9057778523', '52 West Side Rd', 'Port Colborne', 'L3K6T6', 'sandyboo@hotmail.com');
INSERT INTO customer (custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES ('Rodger', 'Torence', '3174458693', '676 Highway 3', 'Dunville', 'L4R7U8', 'toernce_r@gmail.com');
INSERT INTO customer (custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES ('William', 'Boney', '9057864562', '34 Clarence St', 'Port Colborne', 'L3K3E4', 'boney_is_right@hotmail.com');
INSERT INTO customer (custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES ('Oliver', 'Danski', '9054568523', '122 First Ave', 'Welland', 'L3C7T4', 'danski.o@hotmail.com');
--customer no equip just sales
INSERT INTO customer (custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES ('Danielle', 'Wellard', '9054758523', '43 Westlane Rd', 'Welland', 'L3C7R4', 'wellarddj@hotmail.com');

--manufacturer
INSERT INTO manufacturer (manName) VALUES ('Black and Decker');
INSERT INTO manufacturer (manName) VALUES ('Husqvarna');
INSERT INTO manufacturer (manName) VALUES ('Honda');
INSERT INTO manufacturer (manName) VALUES ('Yard Machines');
INSERT INTO manufacturer (manName) VALUES ('Dewalt');
INSERT INTO manufacturer (manName) VALUES ('Briggs and Stratton');
INSERT INTO manufacturer (manName) VALUES ('Kubota');
INSERT INTO manufacturer (manName) VALUES ('Hitachi');
INSERT INTO manufacturer (manName) VALUES ('Craftsman');

--Eduipment
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('20in Cordless', '545482135484', 1, 1, 1);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('17-inch 2 stroke', '5461548513', 1, 2, 2);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('EU1000i', '1584513215', 1, 5, 3);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('21-inch', '5456465524', 2, 1, 4);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('40V', '5481213555', 2, 2, 1);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('DCCS690M1', '654df5645df', 3, 4, 5);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('BS34564', '548235188', 3, 1, 6);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('40V', '9965482123', 3, 2, 1);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('KB3000U', '654sd465', 4, 1, 7);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('22.5cc', '65484121546', 4, 2, 8);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('KB2010R', '56418151ds51', 5, 1, 7);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('20V', '4568464314', 5, 2, 1);
INSERT INTO equipment (equModel, equSerial, custID, equtypeID, equManuID)
VALUES ('S23454633', '354584621321', 5, 8, 9);

--Service
INSERT INTO service (serName, serDescription, serPrice) VALUES ('Oil Change', 'Standard oil change for most makes and models.', 25.00);
INSERT INTO service (serName, serDescription, serPrice) VALUES ('Shop Time', 'Time spent by technicians performing work on device.', 20.00);
INSERT INTO service (serName, serDescription, serPrice) VALUES ('Blade Sharpening', 'Sharpening and balancing of standard cutting blade or chain.', 15.00);
INSERT INTO service (serName, serDescription, serPrice) VALUES ('Winter Service', 'Package deal with oil change and other winter preparation.', 45.00);
INSERT INTO service (serName, serDescription, serPrice) VALUES ('Spring Service', 'Package deal with oil change and other spring preparation.', 45.00);

--Product
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('2 stroke oil', 'Blue - Oil for a two stoke engine.', 'Castrol'); 
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('2 stroke oil', 'Red - Oil for a two stoke engine.', 'Penzoil');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('4 stroke oil', 'Oil for a four stoke engine.', 'Castrol');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('4 stroke oil', 'Oil for a four stoke engine.', 'Penzoil');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('Fuel Stabilizer', 'Used to stablize old gasoline.', 'Champion');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('Air filter', 'Paper. Air filter for Briggs and Stratton engines.', 'Briggs and Stratton');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('Air filter', 'Paper. Air filter for Briggs and Stratton engines.', 'Briggs and Stratton');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('50:1 Mixed Gas', 'Pre-mixed gas for two stroke engines requiring a 50:1 gas to oil ratio.', 'Castrol');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('40:1 Mixed Gas', 'Pre-mixed gas for two stroke engines requiring a 40:1 gas to oil ratio.', 'Castrol');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('40:1 Mixed Gas', 'Pre-mixed gas for two stroke engines requiring a 40:1 gas to oil ratio.', 'Castrol');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('Key', 'Used to maintain engine timing.', 'Briggs and Stratton');
INSERT INTO product (prodName, prodDescription, prodBrand) VALUES ('Blade', 'For mower.', 'Honda');

--Inventory
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (24, 6, 'Fl oz', 4.95, 1);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (19, 6, 'Fl oz', 5.55, 2);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (36, 24, 'Fl oz', 10.99, 3);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (25, 24, 'Fl oz', 11.99, 4);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (16, 8, 'Fl oz', 8.99, 5);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (5, 5, 'inch', 15.99, 6);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (6, 4, 'inch', 13.99, 7);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID) 
VALUES (24, 1, 'Litre', 12.99, 8);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID)
VALUES (21, 1, 'Litre', 12.99, 9);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID)
VALUES (1, .01, 'inch', .65, 10);
INSERT INTO inventory (invQuantity,	invSize, invMeasure, invPrice, productID)
VALUES (1, 24, 'inch', 15.99, 11);

--receipt
INSERT INTO receipt (ordNumber,	ordDate, ordPaid, paymentID, custID, empID)
VALUES ('1', '2018-04-25', 1, 5, 1, 5); --Wendy sold Bob something that he paid cash for
INSERT INTO receipt (ordNumber,	ordDate, ordPaid, paymentID, custID, empID)
VALUES ('2', '2017-10-25', 1, 5, 5, 5); --Wendy sold Bob something that he paid cash for
INSERT INTO receipt (ordNumber,	ordDate, ordPaid, paymentID, custID, empID)
VALUES ('3', '2017-06-11', 1, 1, 6, 6); 

--service_order
INSERT INTO service_order (serordDateIn, serordDateOut, serordIssue, serordWarranty, receiptID, serviceID, equipID,	empID)
VALUES ('2018-04-19', '2018-04-23', 'Change oil and sharpen blade.', 0, 1, 5, 1, 4); --ordnumber 1 spring service to Bob's lawn mower
INSERT INTO service_order (serordDateIn, serordDateOut, serordIssue, serordWarranty, receiptID, serviceID, equipID,	empID)
VALUES ('2018-04-19', '2018-04-23', 'Gap spark plug and restring line.', 0, 1, 5, 2, 4); --ordnumber 1 spring service to Bob's weedeater
INSERT INTO service_order (serordDateIn, serordDateOut, serordIssue, serordWarranty, receiptID, serviceID, equipID,	empID)
VALUES ('2018-04-19', '2018-04-23', 'Change oil and air filter.', 0, 1, 5, 3, 4); --ordnumber 1 spring service to Bob's generator
INSERT INTO service_order (serordDateIn, serordDateOut, serordIssue, serordWarranty, receiptID, serviceID, equipID,	empID)
VALUES ('2018-10-15', '2017-10-20', 'Change oil and grease auger.', 1, 2, 4, 13, 3); --ordnumber 2 winter service to Oliver's snowblower

--order_line
INSERT INTO order_line (orlPrice, orlQuantity, orlOrderReq,	orlNote, inventoryID, receiptID)
VALUES (4.95, 2, 0,'For a 2 stroke weedeater', 1, 3);
INSERT INTO order_line (orlPrice, orlQuantity, orlOrderReq,	orlNote, inventoryID, receiptID)
VALUES (11.99, 2, 0,'For a 2 stroke weedeater', 9, 3);
INSERT INTO order_line (orlPrice, orlQuantity, orlOrderReq,	orlNote, inventoryID, receiptID)
VALUES (15.99, 1, 0,'For lawn mower', 6, 1);
INSERT INTO order_line (orlPrice, orlQuantity, orlOrderReq,	orlNote, inventoryID, receiptID)
VALUES (15.99, 1, 1,'For lawn mower', 11, 1);

--prod_order

INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('52558', '2017-05-28', 1);
INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('52559', '2018-04-28', 1);
INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('52560', '2018-06-02', 1);
INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('52561', '2018-09-05', 1);
INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('52562', '2018-09-05', 1);
INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('000856', '2018-08-12', 1);
INSERT INTO prod_order (pordNumber, pordDateOrdered, pordPaid)
VALUES ('000856', '2018-04-18', 1);

--on_order
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder, onordPrice, inventoryID, prodorderID)
VALUES('2456894', '2017-06-03', 12, 4.46, 1, 1);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2456856', '2018-05-03', 12, 5.00, 2, 2);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2454594', '2018-06-09', 24, 9.9, 3, 3);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2753894', '2018-06-09', 24, 10.8, 4, 3);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2245694', '2018-06-09', 6, 14.4, 6, 4);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2476894', '2018-06-09', 12, 12.6, 7, 4);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2463494', '2018-06-09', 24, 10.8, 8, 5);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2453494', '2018-06-09', 24, 11.7, 9, 5);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2453856', '2018-08-19', 6, .63, 10, 6);
INSERT INTO on_order(onordInvoiceNum, onordArriveDate, onordNumInOrder,onordPrice, inventoryID, prodorderID)
VALUES('2459856', '2018-04-25', 1, 14.4, 11, 7);