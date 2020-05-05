
-- create the database
DROP DATABASE IF EXISTS DogKennel;
CREATE DATABASE DogKennel;

USE DogKennel;

-- create the tables
DROP TABLE IF EXISTS Dog;
CREATE TABLE Dog (
    DogID CHAR(8) PRIMARY KEY,
    Name VARCHAR(32) NOT NULL,
    Breed VARCHAR(32) NOT NULL,
    FatherID CHAR(8) NULL,
    MotherID CHAR(8) NULL,
    Gender VARCHAR(32) NOT NULL,
    Shots TINYINT NOT NULL,
    Birth DATE NOT NULL,
    Status VARCHAR(60) NOT NULL
);

ALTER TABLE Dog
    DROP CONSTRAINT IF EXISTS FK_Dog_FatherID;
ALTER TABLE Dog
    ADD CONSTRAINT  FK_Dog_FatherID
    FOREIGN KEY (FatherID)
    REFERENCES Dog (DogID);

ALTER TABLE Dog
    DROP CONSTRAINT IF EXISTS FK_Dog_MotherID;
ALTER TABLE Dog
    ADD CONSTRAINT  FK_Dog_MotherID
    FOREIGN KEY (MotherID)
    REFERENCES Dog (DogID);

DROP TABLE IF EXISTS Client;
CREATE TABLE Client(
    ClientID INT PRIMARY KEY,
    Name VARCHAR(32) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber CHAR(10) NOT NULL
);

DROP TABLE IF EXISTS Purchase;
CREATE TABLE Purchase(
    DogID CHAR(8) NOT NULL,
    ClientID INT NOT NULL,
    Date DATE NOT NULL,
    Price FLOAT NOT NULL
);

ALTER TABLE Purchase
    DROP CONSTRAINT IF EXISTS PK_Purchase;
ALTER TABLE Purchase
    ADD CONSTRAINT  PK_Purchase
    PRIMARY KEY (DogID, ClientID);

ALTER TABLE Purchase
    DROP CONSTRAINT IF EXISTS FK_Dog_DogID;
ALTER TABLE Purchase
    ADD CONSTRAINT  FK_Dog_DogID
    FOREIGN KEY (DogID)
    REFERENCES Dog (DogID);

ALTER TABLE Purchase
    DROP CONSTRAINT IF EXISTS FK_Client_ClientID;
ALTER TABLE Purchase
    ADD CONSTRAINT  FK_Client_ClientID
    FOREIGN KEY (ClientID)
    REFERENCES Client (ClientID);