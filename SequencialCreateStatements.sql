/*Function*/

CREATE FUNCTION SalePrice(@X Float)
RETURNS Float
AS
BEGIN
  RETURN @X *1.1
END

use ProjectAlpha;

create table Suppliers (
    SupplierID INT not null ,
    Name VARCHAR(500),
    City VARCHAR(500),
    Constraint PKSuppliers Primary Key (SupplierID)
);





    create table WholesaleDistributor (
    DistributorID INT,
    Name VARCHAR(500),
    ServiceTerritory VARCHAR(500),
    State VARCHAR(500)
    constraint PKWholesaleDistributor Primary Key( DistributorID)
);

 
create table Product (
    ProductID INT,
    [Name] VARCHAR(500),
    [Description] VARCHAR(5000),
    Category VARCHAR(500),
    CostPrice Float,
    MinSalePrice as dbo.SalePrice(CostPrice),
    Constraint PKProduct Primary Key (ProductID)
);
 

create table Manager (
    ManagerID INT,
    Name VARCHAR(500),
    City VARCHAR(500),
    Street VARCHAR(500),
    Contact varbinary(500)
    Constraint PKManager Primary Key (ManagerID)
);



create table PharmaceuticalCompany (
    PharmaceuticalCompanyID INT,
    Name VARCHAR(500),
    City VARCHAR(500),
    Street VARCHAR(500),
    Type VARCHAR(11) constraint cmpnytype check (Type in ('Ayurvedic','Alopathic','Homeopathic'))
    Constraint PKPharmaceuticalCompany Primary Key (PharmaceuticalCompanyID)
);

create table Warehouses (
    WarehouseID INT,
    Location VARCHAR(500),
    WarehouseCapacity INT,
    ManagerID Int,
    PharmaindustryID int,
    constraint PKWarehouses Primary Key (WarehouseID),
    constraint FKManagerID Foreign Key (ManagerID) references Manager (ManagerID),
    constraint FKPharmaIndustryID Foreign Key (PharmaindustryID) references  PharmaceuticalCompany(PharmaceuticalCompanyID) 

);
 





create table RawMaterial (
    RawMaterialID INT Not Null,
    UnitPrice INT,
    Type VARCHAR(500),
    Constraint PKRawMaterial Primary Key (RawMaterialID)
);

create table Equipments (
    EquipmentID Int Not null,
    WeightKG Float,
    wattage float,
    constraint PKEqipments Primary Key (EquipmentID),
    Constraint FKEquipmentID foreign key (EquipmentID) References RawMaterial(RawMaterialID)
    );
Create Table API (
    ActiveChemicalID int not null,
    FDAApproval varchar(500)  constraint Approvalchk Check (FDAApproval in ('Yes','Pending')),
    PhysicalState varchar(500),
    Constraint PKAPI Primary Key (ActiveChemicalID),
    Constraint FKActiveChemicalID foreign key (ActiveChemicalID) References RawMaterial(RawMaterialID)
    ); 

Create Table Excipient(
    InactiveChemicalID int not null,
    Preservatives varchar(500),
    CoatingAgent varchar(500),
    ColourUsed varchar(500),
    Constraint PKExcipient Primary Key (InactiveChemicalID),
    Constraint FKInactivechemicalID Foreign Key (InactiveChemicalID) References RawMaterial(RawMaterialID)
    );
    

 

 

 



 

 





create table LocalDistributor (
    LocalDistributorID INT Not null,
    OwnerName VARCHAR(500),
    LicenseID VARCHAR(500),
    City VARCHAR(500),
    ZipCode INT,
    WholesaleDistributorID int,
    Constraint PKLocalDistributorID Primary Key (LocalDistributorID),
    Constraint FKWholesaleDistributorID Foreign Key(WholesaleDistributorID) references WholesaleDistributor(DistributorID)
); 


    

 

Create Table HospitalPharmacy
    (
    HospitalPharmacyID int not null,
    HospitalName varchar(500),
  
    constraint PKHospitalPharmacyID Primary Key (HospitalPharmacyID),
    constraint FKHospitalPharmacyID Foreign Key (HospitalPharmacyID) references LocalDistributor(LocalDistributorID)
    );
    

 

Create Table Drugstore
(
    DrugStoreID int Not Null,
    StoreName varchar(500),
    
    constraint PKDrugstoreID Primary Key (DrugStoreID),
    constraint FKDrugstoreID Foreign Key (DrugstoreID) references LocalDistributor(LocalDistributorID)
);

Create Table OnlineRetailer
(
    OnlineRetailerID int Not Null,
    WebsiteName varchar(500),
    Email varchar(500),
    Rating int,
    Constraint PKOnlineRetailerID Primary Key ( OnlineRetailerID),
    Constraint FKOnlineRetailerID Foreign Key (OnlineRetailerID) references LocalDistributor(LocalDistributorID)
);

create table Customer (
    InsuranceID INT,
    Name VARCHAR(500),
    DateofBirth DATE,
    StreetName VARCHAR(500),
    City VARCHAR(500),
    Constraint PKCustomer Primary Key (InsuranceID)
);

Create Table PatientCustomer
(
    PatientInsuranceID Int not null,
    FamilyDoctorName varchar(500),
    AppointmentFrequency varchar(500),
    Constraint PKPatientCustomer Primary Key (PatientInsuranceID),
    Constraint FKPatientInsuranceID Foreign Key (PatientInsuranceID) references Customer(InsuranceID),
    
    );

Create Table PharmacyCustomer 
(
    PharmacyCustomerInsuranceID int not null,
    PharmacySavingsCardNumber varchar(500),

    Constraint PKDrugCustomerID Primary Key (PharmacyCustomerInsuranceID),
    Constraint FKDrugCustomerID Foreign Key (PharmacyCustomerInsuranceID) references Customer(InsuranceID),

    );
   
 

Create Table OnlineCustomer
(
    WebAccountInsuranceID int not null,
    OnlineUserName varchar(500),
    DateofRegistration date,


    Constraint PKWebAccountInsuranceID Primary Key (WebAccountInsuranceID),
    Constraint FKWebAccountInsuranceID Foreign Key(WebAccountInsuranceID) references Customer(InsuranceID),
    
    );
    

    Create Table WholesaleOrders
(
    OrderID int  not null,
    ProductID int,
    PharmaceuticalCompanyID int,
    WholesaleDistributorID int,
    Price int,
    DateofPlacing date,
    ExpectedDelivery date,
    constraint PKOrderID Primary Key (OrderID),
    constraint FKProductID Foreign Key (ProductID) references Product(ProductID),
    constraint FKPharmaceuticalCompanyID Foreign Key(PharmaceuticalCompanyID) references PharmaceuticalCompany(PharmaceuticalCompanyID),
    constraint FKWholesaleOrderDistributorID Foreign Key(WholesaleDistributorID) references WholesaleDistributor(DistributorID),
);

    Create Table DrugPurchase
(
    PurchaseID int  not null,
    Payment int,
    ProductID int,
    LocaldistributorID int,
    InsuranceID int,
    DateofPurchase Date,
    Constraint PKPurchaseID Primary KEy (PurchaseID),
    Constraint FKPurchaseProductID Foreign Key (ProductID) references Product(ProductID),
    Constraint FKPurchaseLocaldistributorID Foreign Key (LocaldistributorID) references LocalDistributor(LocalDistributorID),
    Constraint FKPurchaseInsuranceID Foreign Key (InsuranceID) references Customer(InsuranceID)
    );

    Create Table RawMaterialOrders
    (
        OrderID int  not null,
        RawMaterialID int,
        SupplierID int,
        WarehouseID int,
        [Date] date,
        TypeofOrder varchar(500) check (TypeofOrder in ('Express','Regular')),
        constraint PKWarehouseOrderID Primary KEy (OrderID),
        Constraint FKRawMaterialID Foreign Key (RawMaterialID) references RawMaterial(RawMaterialID),
        constraint FKSupplierID Foreign Key (SupplierID) references Suppliers(SupplierID),
        Constraint FKWarehouseID Foreign Key (WarehouseID) references Warehouses(WarehouseID),
    );



/*procedures*/
/*to get rawmaterial orders of specific date*/
Create procedure RawMaterialOrdersof @Date date

AS
BEGIN
  select * from RawMaterialOrders
  where RawMaterialOrders.[Date] = @Date
END;

/*procedure to count today sales*/
create procedure TodaySalesNumber

	as 
	BEGIN
	select Count(DrugPurchase.PurchaseID) from DrugPurchase
	where DrugPurchase.DateofPurchase = (SELECT CONVERT(date, getdate()))

	end;

/*Procedure to get express raw material orders of today*/
Create procedure Todayexpressorders

AS
BEGIN
 
  select * from RawMaterialOrders
  where RawMaterialOrders.[Date] = (SELECT CONVERT(date, getdate())) and RawMaterialOrders.TypeofOrder = 'Express'

END;

/*Triggers*/

CREATE TRIGGER ShowSaleCounttilltoday
   ON  dbo.DrugPurchase
  FOR Insert
AS 
BEGIN
select Count(DrugPurchase.PurchaseID) from DrugPurchase

END;


/*******************************************************************************************************/
/*Views*/

Create View PrescribingDoctorForDrugPurchase 
as
Select c.PatientInsuranceID,c.FamilyDoctorName,b.DateofPurchase
From DrugPurchase b Inner Join PatientCustomer c On (c.PatientInsuranceID = b.InsuranceID) 
 inner join HospitalPharmacy a on a.HospitalPharmacyID = b.LocalDistributorID
 

 Create View PurchasingCustomerDetails 
as
Select d.PharmacyCustomerInsuranceID,d.PharmacySavingsCardNumber,b.DateofPurchase, f.[Name]
From DrugPurchase b Inner Join PharmacyCustomer d On (d.PharmacyCustomerInsuranceID = b.InsuranceID) 
 inner join DrugStore e on e.DrugStoreID = b.LocalDistributorID inner join Customer f on f.InsuranceId = b.InsuranceID

/*Index*/

Create Nonclustered Index IN_CustomerOrders
on Customer ([Name] Asc)
 
Create Nonclustered Index IN_Payment
on DrugPurchase (Payment Asc)

Create Nonclustered Index IN_ProductName
on Product ([Name] Asc, Category Asc)



















































/*******************************************encryption**********************************************************************/
/* TDE Column Level encryption in SQL Server
  Similar to other Database vendors */

use sample
go
--Modify the Manager table by adding two columns username and Password columns


/* variable binary  allow use of characters set outside your current character set
   data will be in hexadecimal format
   real security comes from the encryption algorithm used*/

go

--Create a master key for the database. 
create MASTER KEY
ENCRYPTION BY PASSWORD = 'info6210';
-- drop master key 

-- very that master key exists
SELECT name KeyName,
  symmetric_key_id KeyID,
  key_length KeyLength,
  algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

go
--Create a self signed certificate and name it ManagerPass
CREATE CERTIFICATE ManagerPass  
   WITH SUBJECT = 'Manager Sample Password';  
GO  

-- drop CERTIFICATE ManagerPass  

--Create a symmetric key  with AES 256 algorithm using the certificate
-- as encryption/decryption method

CREATE SYMMETRIC KEY ManagerPass_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE ManagerPass;  
GO  
--drop SYMMETRIC KEY ManagerPass_SM 

--Now we are ready to encrypt the password and also decrypt

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY ManagerPass_SM  
   DECRYPTION BY CERTIFICATE ManagerPass;  

-- Encrypt the value in column Password  with symmetric  key, and default everyone with
-- a password of Pass1234  
UPDATE dbo Manager set  [Contact] = EncryptByKey(Key_GUID('ManagerPass_SM'),  convert(varbinary,'Pass123')  ) 
GO  



-- First open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY ManagerPass_SM  
   DECRYPTION BY CERTIFICATE ManagerPass;  
 
   
SELECT *, 
    CONVERT(varchar, DecryptByKey([Contact]))   
    AS 'Decrypted Contact'  
    FROM dbo.Manager;  
GO  
