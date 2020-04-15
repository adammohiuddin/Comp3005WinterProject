-- Comp 3005: Project (Winter 2020)
-- Name: Adam Mohiuddin
-- ID: 101003042



create table publisher
	(publisher_name		varchar(50),
	 contact_name		varchar(70),
	 email		varchar(255),
	 address	varchar(70),
	 bank_branch	numeric(9,0),
	 bank_acct	numeric(12,0),
	 primary key (publisher_name)
	);
	
create table publisher_phone
	(publisher_name		varchar(50),
	 phone		numeric(11,0),
	 primary key (publisher_name, phone),
	 foreign key (publisher_name) references publisher
	 	on delete cascade
	);

create table book
	(ISBN		numeric(13,0), 
	 title		varchar(150), 
	 subtitle	varchar(150),
	 page_count	numeric(5,0),
	 published_year	numeric(4,0),
	 book_synopsis	varchar(500),
	 language	varchar(3),
	 format		varchar(20),
	 primary key (ISBN)
	);
	
create table book_genre
	(ISBN		numeric(13,0),
	 genre		varchar(40),
	 primary key (ISBN, genre),
	 foreign key (ISBN) references book
	);

create table book_author
	(ISBN		numeric(13,0),
	 author		varchar(70),
	 primary key (ISBN, author),
	 foreign key (ISBN) references book
	);
	
create table publish
	(ISBN		numeric(13,0),
	 publisher_name		varchar(50),
	 primary key (ISBN, publisher_name),
	 foreign key (ISBN) references book,
	 foreign key (publisher_name) references publisher
	 	on delete set null
	);
	
create table order_book
	(order_num		serial,
	 order_date		date,
	 order_qty		numeric(3,0) check (order_qty > 0),
	 publisher_name		varchar(50),
	 publisher_percent	numeric(4,2),
	 ISBN		numeric(13,0),
	 book_cost		numeric(5,2),
	 primary key (order_num),
	 foreign key (ISBN) references book,
	 foreign key (publisher_name) references publisher
	);	
	
create table user
	(user_ID		serial,
	 user_level		numeric(1,0),
	 first_name		varchar(30),
	 last_name		varchar(40),
	 email	varchar(255),
	 password		varchar(32),
	 address		varchar(70),
	 billing_addr		varchar(70),
	 shipping_addr		varchar(70),
	 card_num		numeric(16,0),
	 name_on_card	varchar(22),
	 expiry		numeric(4,0),
	 primary key (user_ID)
	);
	
create table user_order
	(order_num		serial,
	 order_date		date,
	 user_ID		serial,
	 order_bill_addr		varchar(70),
	 order_ship_addr		varchar(70),
	 tracking_info		varchar(100),
	 primary key (order_num),
	 foreign key (user_ID) references user
	);

create table basket
	(order_num		serial,
	 ISBN			numeric(13,0),
	 quantity		numeric(1,0) check (quantity > 0 and quantity <= 2),
	 primary key (order_num),
	 foreign key (order_num) references order,
	 foreign key (ISBN) references book
	);	
	
	
	
create materialized view quantity_of_bought_books(ISBN, number_bought) as
select ISBN, sum(order_qty)
from order_book
group by ISBN;


create materialized view quantity_of_sold_books(ISBN, number_sold) as
select ISBN, sum(quantity)
from basket
group by ISBN;


create materialized view sale_price(order_num, order_date, ISBN, quantity, price_per_book) as
select order_num, ISBN, quantity, price_of(ISBN, order_date)
from user_order natural join basket;
