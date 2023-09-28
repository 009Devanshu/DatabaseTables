use Emp_Data;

create proc UpdateCompanyAccount
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

select * from company



-- Create a stored procedure to delete a company and its associated accounts
CREATE PROCEDURE DeleteCompanyAndAccountsByName
    @CompanyName NVARCHAR(200)
AS
BEGIN
    -- Declare a variable to store the companyId
    DECLARE @CompanyId INT

    -- Get the companyId for the specified company name
    SELECT @CompanyId = company_id
    FROM company
    WHERE name = @CompanyName

    -- Check if a company with the given name exists
    IF @CompanyId IS NOT NULL
    BEGIN
        -- Delete records from the account table associated with the companyId
        DELETE FROM account
        WHERE companyId = @CompanyId

        -- Delete the company record from the company table
        DELETE FROM company
        WHERE company_id = @CompanyId

        PRINT 'Company and associated accounts deleted successfully.'
    END
    ELSE
    BEGIN
        PRINT 'Company not found.'
    END
END;

