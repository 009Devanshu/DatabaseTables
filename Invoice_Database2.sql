create table client
(
	client_id int identity(1,1) primary key,
	name nvarchar(200),
	company nvarchar(200),
	display_block nvarchar(200),
	preferred_block nvarchar(200),
	address nvarchar(200),
	country nvarchar(200),
	contact nvarchar(200),
	email nvarchar(200),
	gst nvarchar(200)
	)

	
CREATE PROCEDURE InsertClient
    @name NVARCHAR(200),
	@company nvarchar(200),
    @display_block NVARCHAR(200),
    @preferred_block NVARCHAR(200),
    @address NVARCHAR(200),
    @country NVARCHAR(200),
    @contact NVARCHAR(200),
    @email NVARCHAR(200),
    @gst NVARCHAR(200)
	
AS
BEGIN
    INSERT INTO client (name,company ,display_block, preferred_block, address, country, contact, email, gst)
    VALUES (@name,@company,@display_block, @preferred_block, @address, @country, @contact, @email, @gst);
END

drop proc InsertClient;
go
create proc LoadClient
as 
begin
	select name as "Client Name",company as "Company Name" ,display_block as "Display Block",preferred_block as "Preferred Block",address as Address,country as Country,contact as Contact,email as Email,gst as GST from client
end

drop proc LoadClient;

drop table client;
drop proc InsertClient;
select name as "Client Name" from client;

drop proc UpdateClient;

create proc UpdateClient
	@name NVARCHAR(200),
	@company nvarchar(200),
    @display_block NVARCHAR(200),
    @preferred_block NVARCHAR(200),
    @address nvarchar(200),
	@country nvarchar(200),
    @contact NVARCHAR(200),
    @email NVARCHAR(200),
    @gst NVARCHAR(200)
as 
begin
	update client set name=@name,company=@company,display_block=@display_block,preferred_block=@preferred_block,address=@address,
	country=@country,contact=@contact,email=@email,gst=@gst where name=@name
end

exec LoadClient;

truncate table client;



create proc InsertInvoice
@client_name nvarchar(200),
@client_company nvarchar(200),
@client_address nvarchar(200),
@client_country nvarchar(200),
@client_gst nvarchar(200),
@invoice_number nvarchar(200),
@invoice_date date,
@item_name nvarchar(200),
@item_description nvarchar(700),
@ccy_code nvarchar(50),
@amount nvarchar(200),
@account_holder_name nvarchar(200),
@account_number nvarchar(200),
@ifsc nvarchar(200),
@swift nvarchar(200),
@bank_bank nvarchar(200)
as 
begin
 insert into Invoice(client_name,client_company,client_address,client_country,client_gst,invoice_number,invoice_date
 ,item_name,item_description,ccy_code,amount,account_holder_name,account_number,ifsc,swift,bank_bank) 
 values(@client_name,@client_company,@client_address,@client_country,@client_gst,@invoice_number,@invoice_date,@item_name,@item_description,
 @ccy_code,@amount,@account_holder_name,@account_number,@ifsc,@swift,@bank_bank);
end

create proc LoadInvoice
as
begin
	select client_name,client_company,invoice_number,invoice_date,client_address,client_country,client_gst
		,item_name,item_description,ccy_code,amount,account_holder_name,account_number,ifsc,swift,bank_bank from Invoice;
end



create proc LoadClientByName
@name nvarchar(200)
as 
begin 
	select name,company,address,country,contact,gst from client where name=@name;
end

create proc LoadClientName
as 
begin
	select name from client;
end
