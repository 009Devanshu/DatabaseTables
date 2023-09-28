use Emp_Data;
-- Create the company table
CREATE TABLE company (
    company_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200),
    gst NVARCHAR(200),
    pan NVARCHAR(200),
    address NVARCHAR(200),
    lut NVARCHAR(200),
    cin NVARCHAR(200)
);


-- Create the account table
CREATE TABLE account (
    accountId INT PRIMARY KEY identity(1,1),
    bank_name NVARCHAR(200),
	account_number NVARCHAR(200),
    account_name NVARCHAR(200),
	IFSC_code NVARCHAR(200),
    swift_code NVARCHAR(200),
    address NVARCHAR(255),
    companyId INT,  -- This field will hold the foreign key
    FOREIGN KEY (companyId) REFERENCES company(company_id)
);

drop table account;

CREATE PROCEDURE InsertCompanyAndAccount
(
    @CompanyName NVARCHAR(200),
    @GST NVARCHAR(200),
    @PAN NVARCHAR(200),
    @CompanyAddress NVARCHAR(200),
    @LUT NVARCHAR(200),
    @CIN NVARCHAR(200),
    @BankName NVARCHAR(200),
    @AccountNumber NVARCHAR(200),
    @AccountName NVARCHAR(200),
    @IFSCCode NVARCHAR(200),
    @SwiftCode NVARCHAR(200),
    @BankAddress NVARCHAR(255)
)
AS
BEGIN
    DECLARE @CompanyId INT;

    -- Insert data into the 'company' table
    INSERT INTO company (name, gst, pan, address, lut, cin)
    VALUES (@CompanyName, @GST, @PAN, @CompanyAddress, @LUT, @CIN);

    -- Get the newly generated company_id
    SET @CompanyId = SCOPE_IDENTITY();

    -- Insert data into the 'account' table with the companyId as a foreign key
    INSERT INTO account (bank_name, account_number, account_name, IFSC_code, swift_code, address, companyId)
    VALUES (@BankName, @AccountNumber, @AccountName, @IFSCCode, @SwiftCode, @BankAddress, @CompanyId);
END;


create proc LoadCompanyWithAccount
as 
begin
	select c.name as "Company Name",c.gst as GST,c.pan as PAN,c.address as "Company Address",c.lut as "LUT Number",c.cin as "CIN Number",
	b.bank_name as "Bank Name",b.account_number as "Account Number",b.account_name as "Account Name",b.IFSC_code as "IFSC Code",b.swift_code as "Swift Code",b.address as "Bank Address"
	from company c inner join account b
	on c.company_id=b.companyId;
end

drop proc LoadCompanyWithAccount;
exec LoadCompanyWithAccount;


CREATE PROCEDURE UpdateCompanyAndAccountsByName
    @CompanyName NVARCHAR(200),
    @NewGST NVARCHAR(200),
    @NewPAN NVARCHAR(200),
    @NewAddress NVARCHAR(200),
    @NewLUT NVARCHAR(200),
    @NewCIN NVARCHAR(200),
    @NewBankName NVARCHAR(200),
    @NewAccountNumber NVARCHAR(200),
    @NewAccountName NVARCHAR(200),
    @NewIFSCCode NVARCHAR(200),
    @NewSwiftCode NVARCHAR(200),
    @NewAccountAddress NVARCHAR(255)
AS
BEGIN
    -- Update the company details
    UPDATE company
    SET 
        gst = @NewGST,
        pan = @NewPAN,
        address = @NewAddress,
        lut = @NewLUT,
        cin = @NewCIN
    WHERE name = @CompanyName;

    -- Update the associated account details
    UPDATE account
    SET bank_name = @NewBankName,
        account_number = @NewAccountNumber,
        account_name = @NewAccountName,
        IFSC_code = @NewIFSCCode,
        swift_code = @NewSwiftCode,
        address = @NewAccountAddress
    WHERE companyId = (SELECT company_id FROM company WHERE name = @CompanyName);
END;


