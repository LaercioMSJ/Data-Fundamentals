
-- create the database
DROP DATABASE IF EXISTS WestConCableCompany;
CREATE DATABASE WestConCableCompany;

USE WestConCableCompany;


-- create the tables
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(32) NOT NULL,
    Payment FLOAT NULL
);

DROP TABLE IF EXISTS Channel;
CREATE TABLE Channel(
    ChannelID INT PRIMARY KEY,
    ChannelName VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS CablePackage;
CREATE TABLE CablePackage(
    CablePackageID INT PRIMARY KEY,
    CablePackageName VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS PayPerView;
CREATE TABLE PayPerView(
    PayPerViewID INT PRIMARY KEY,
    PayPerViewName VARCHAR(32) NOT NULL,
    EventDate DATETIME NOT NULL,
    Price FLOAT NOT NULL,
    ChannelID INT NOT NULL
);

DROP TABLE IF EXISTS CablePackageChannel;
CREATE TABLE CablePackageChannel(
    CablePackageID INT NOT NULL,
    ChannelID INT NOT NULL
);

DROP TABLE IF EXISTS CustomerPayPerView;
CREATE TABLE CustomerPayPerView(
    CustomerID INT NOT NULL,
    PayPerViewID INT NOT NULL
);

DROP TABLE IF EXISTS CustomerCablePackage;
CREATE TABLE CustomerCablePackage(
    CustomerID INT NOT NULL,
    CablePackageID INT NOT NULL
);


-- create relationships
ALTER TABLE PayPerView
    DROP CONSTRAINT IF EXISTS FK__Channel__ChannelID;
ALTER TABLE PayPerView
    ADD CONSTRAINT FK__Channel__ChannelID FOREIGN KEY (ChannelID)
        REFERENCES Channel (ChannelID);


ALTER TABLE CablePackageChannel
    DROP CONSTRAINT IF EXISTS PK_CablePackageChannel;
ALTER TABLE CablePackageChannel
    ADD CONSTRAINT  PK_CablePackageChannel
    PRIMARY KEY (CablePackageID, ChannelID);

ALTER TABLE CablePackageChannel
    DROP CONSTRAINT IF EXISTS FK_CablePackage_CablePackageID;
ALTER TABLE CablePackageChannel
    ADD CONSTRAINT  FK_CablePackage_CablePackageID
    FOREIGN KEY (CablePackageID)
    REFERENCES CablePackage (CablePackageID);

ALTER TABLE CablePackageChannel
    DROP CONSTRAINT IF EXISTS FK_Channel_ChannelID;
ALTER TABLE CablePackageChannel
    ADD CONSTRAINT  FK_Channel_ChannelID
    FOREIGN KEY (ChannelID)
    REFERENCES Channel (ChannelID);


ALTER TABLE CustomerPayPerView
    DROP CONSTRAINT IF EXISTS PK_CustomerPayPerView;
ALTER TABLE CustomerPayPerView
    ADD CONSTRAINT  PK_CustomerPayPerView
    PRIMARY KEY (CustomerID, PayPerViewID);

ALTER TABLE CustomerPayPerView
    DROP CONSTRAINT IF EXISTS FK_Customer_CustomerID;
ALTER TABLE CustomerPayPerView
    ADD CONSTRAINT  FK_Customer_CustomerID
    FOREIGN KEY (CustomerID)
    REFERENCES Customer (CustomerID);

ALTER TABLE CustomerPayPerView
    DROP CONSTRAINT IF EXISTS FK_PayPerView_PayPerViewID;
ALTER TABLE CustomerPayPerView
    ADD CONSTRAINT  FK_PayPerView_PayPerViewID
    FOREIGN KEY (PayPerViewID)
    REFERENCES PayPerView (PayPerViewID);


ALTER TABLE CustomerCablePackage
    DROP CONSTRAINT IF EXISTS PK_CustomerCablePackage;
ALTER TABLE CustomerCablePackage
    ADD CONSTRAINT  PK_CustomerCablePackage
    PRIMARY KEY (CustomerID, CablePackageID);

ALTER TABLE CustomerCablePackage
    DROP CONSTRAINT IF EXISTS FK_CustomerC_CustomerID;
ALTER TABLE CustomerCablePackage
    ADD CONSTRAINT  FK_CustomerC_CustomerID
    FOREIGN KEY (CustomerID)
    REFERENCES Customer (CustomerID);

ALTER TABLE CustomerCablePackage
    DROP CONSTRAINT IF EXISTS FK_CablePackageC_CablePackageID;
ALTER TABLE CustomerCablePackage
    ADD CONSTRAINT  FK_CablePackageC_CablePackageID
    FOREIGN KEY (CablePackageID)
    REFERENCES CablePackage (CablePackageID);


-- INSERTing customers
INSERT INTO Customer
    (CustomerID, CustomerName)
VALUES
    (1, 'John Buck'), (2, 'Jane Doe'), (3, 'Jack Sprat');


-- INSERTing channels
INSERT INTO Channel
    (ChannelID, ChannelName)
VALUES
    (1, 'ABC (100)'), (2, 'Spike (106)'), (3, 'TSN (110)');


-- INSERTing cable packages
INSERT INTO CablePackage
    (CablePackageID, CablePackageName)
VALUES
    (1, 'Basic'), (2, 'Action'), (3, 'Sports');


-- INSERTing channels in cable packages
INSERT INTO CablePackageChannel
    (CablePackageID, ChannelID)
VALUES
    (1, 1), (2, 2), (3, 3);


-- INSERTing Basic package to all customers
INSERT INTO CustomerCablePackage
    (CablePackageID, CustomerID)
VALUES
    (1, 1), (1, 2), (1, 3);


-- INSERTing Action package to Jane Doe
INSERT INTO CustomerCablePackage
    (CablePackageID, CustomerID)
VALUES
    (2, 2);


-- INSERTing pay per view
INSERT INTO PayPerView
    (PayPerViewID, PayPerViewName, EventDate, Price, ChannelID)
VALUES
    (2, 'The Prize Fight', '2018-10-31T20:00:000', 9.95, 3);


-- INSERTing John Buck to PayPerView The Prize Fight
INSERT INTO CustomerPayPerView
    (CustomerID, PayPerViewID)
VALUES
    (1, 1);


-- UPDATEing John Buck's payment
UPDATE Customer
SET Payment = 9.95
WHERE CustomerID = 1;


-- DELETEing Jane Doe's cable package
DELETE FROM CustomerCablePackage
WHERE CustomerID = 2 AND CablePackageID = 2;


-- SELECTing all customer information alphabetically by last name
SELECT * FROM Customer;
ORDER BY SUBSTR(CustomerName, INSTR(CustomerName, ' '));


-- SELECTing all information for the Spike channel
SELECT * FROM Channel
WHERE ChannelName LIKE 'Spike';


-- SELECTing the title and date of all future Pay-Per-View events
SELECT PayPerViewName, EventDate FROM PayPerView
WHERE EventDate > CURDATE();