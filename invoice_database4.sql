create table Invoice
(
	invoice_id int primary key identity(1,1),
	client_name nvarchar(200),
	client_company nvarchar(200),
	client_address nvarchar(200),
	client_country nvarchar(200),
	client_gst nvarchar(200),
	invoice_number int,
	invoice_date date,
	item_name nvarchar(200),
	item_description nvarchar(700),
	ccy_code nvarchar(50),
	amount nvarchar(200),
	account_holder_name nvarchar(200),
	account_number nvarchar(200),
	ifsc nvarchar(200),
	swift nvarchar(200),
	bank_bank nvarchar(200)
	)

drop table Invoice;
go

create proc InsertInvoice
@client_name nvarchar(200),
@client_company nvarchar(200),
@client_address nvarchar(200),
@client_country nvarchar(200),
@client_gst nvarchar(200),
@invoice_number int,
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

exec InsertInvoice 'Rohit','ATF Labs','Hari Parwat Chauraha','India','909988',23,'24 July,2024','Software Developer'
,'A good programmer in Java and JavaScript','RS','50000','Anuj Jain','YYU77666','HFSF787','5655UIU','HDFC Bank';

select * from Invoice
go

create proc LoadInvoice
as
begin
	select client_name as "Client Name",client_company,invoice_number,invoice_date,item_name,item_description,client_address,client_country,client_gst
		,ccy_code,amount,account_holder_name,account_number,ifsc,swift,bank_bank from Invoice;
end

drop proc LoadInvoice;


delete from Invoice where client_name='Rohit';
