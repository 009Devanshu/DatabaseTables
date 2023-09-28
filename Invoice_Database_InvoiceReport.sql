use Emp_Data;


create table Report
(
	report_id int primary key identity(1,1),
	client_name nvarchar(200),
	client_company nvarchar(200),
	invoice_number int,
	invoice_string nvarchar(200),
	invoice_date date,
	client_address nvarchar(200),
	client_country nvarchar(200),
	client_gst nvarchar(200),
	item_name nvarchar(200),
	item_description nvarchar(200),
	ccy_code nvarchar(50),
	amount float,
	account_holder_name nvarchar(200),
	account_number nvarchar(200),
	ifsc nvarchar(200),
	swift nvarchar(200),
	bank_name nvarchar(200)
	)

create proc InsertIntoReport
	@client_name nvarchar(200),
	@client_company nvarchar(200),
	@invoice_number int,
	@invoice_string nvarchar(200),
	@invoice_date date,
	@client_address nvarchar(200),
	@client_country nvarchar(200),
	@client_gst nvarchar(200),
	@item_name nvarchar(200),
	@item_description nvarchar(200),
	@ccy_code nvarchar(50),
	@amount float,
	@account_holder_name nvarchar(200),
	@account_number nvarchar(200),
	@ifsc nvarchar(200),
	@swift nvarchar(200),
	@bank_name nvarchar(200)
as 
begin
	insert into Report(client_name,client_company,invoice_number,invoice_string,invoice_date,client_address,client_country,
		client_gst,item_name,item_description,ccy_code,amount,account_holder_name,account_number,ifsc,swift,bank_name) values(
		@client_name,@client_company,@invoice_number,@invoice_string,@invoice_date,@client_address,@client_country,
		@client_gst,@item_name,@item_description,@ccy_code,@amount,@account_holder_name,@account_number,@ifsc,@swift,@bank_name)
end


exec InsertIntoReport 'David','Infosys',10,'FY23-24/10','24 July, 2023','Kanpur','India','909888','Software Developer','A good programmer','Rs',
50000,'ATF','7887888','ATF/677','UIIU89','HDFC Bank';

create proc LoadInvoiceReport
as 
begin
	select client_name,client_company,invoice_number,invoice_string,invoice_date,client_address,client_country,
		client_gst,item_name,item_description,ccy_code,amount,account_holder_name,account_number,ifsc,swift,bank_name from Report;
end

exec LoadInvoiceReport;