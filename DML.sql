-- Comp 3005: Project (Winter 2020)
-- Name: Adam Mohiuddin
-- ID: 101003042



-- #1
-- Adding a new user to the bookstore.
-- All the values in '' starting with "entered_" are all entered by the new user
-- on the application side of the database.
insert into user (user_level, first_name, last_name, email, password, address, billing_addr, 
	shipping_addr, card_num, name_on_card, expiry)
	values(0, 'entered_first_name', 'entered_last_name', 'entered_email', 'entered_password'
	'entered_address', 'entered_billing_addr', 'entered_shipping_addr', 'entered_card_num',
	'entered_name_on_card', 'entered_expiry');
	

-- #2
-- Adding a new book to the bookstore.
-- All the values in '' starting with "entered_" are all entered by an owner
-- on the application side of the database.
insert into book (ISBN, title, subtitle, page_count, publisher_name, published_year, book_synopsis, 
	language, format)
	values('entered_ISBN', 'entered_title', 'entered_subtitle', 'entered_page_count',
	'entered_publisher_name', 'entered_published_year', 'entered_book_synopsis', 'entered_language',
	'entered_format');


-- #3
-- Adding an author to a book.
-- All the values in '' starting with "entered_" are all entered by an owner
-- on the application side of the database.
insert into book_author (ISBN, author)
	values('entered_ISBN', 'entered_author');
	

-- #4
-- Adding a genre to a book.
-- All the values in '' starting with "entered_" are all entered by an owner
-- on the application side of the database.
insert into book_genre (ISBN, genre)
	values('entered_ISBN', 'entered_genre');
	
	
-- #5
-- Adding a new publisher to the bookstore.
-- All the values in '' starting with "entered_" are all entered by an owner
-- on the application side of the database.
insert into publisher (publisher_name, contact_name, email, address, bank_branch, bank_acct)
	values('entered_publisher_name', 'entered_contact_name', 'entered_email', 'entered_address',
	'entered_bank_branch', 'entered_bank_acct');

	
-- #6
-- Adding a phone to a publisher.
-- All the values in '' starting with "entered_" are all entered by an owner
-- on the application side of the database.
insert into publisher_phone (publisher, phone)
	values('entered_publisher', 'entered_phone');
	
	
-- #7
-- Creating a new user_order.
-- All the values in '' starting with "entered_" are all entered by a user
-- on the application side of the database or gotten from a separate query.
insert into user_order (order_date, user_ID)
	values(current_date, 'entered_user_ID');
	

-- #8
-- Creating a a new basket.
-- All the values in '' starting with "entered_" are all entered by a user
-- on the application side of the database or gotten from a separate query.
insert into basket (ISBN, quantity)
	values('entered_ISBN', 'entered_quantity');
	

-- #9
-- Enter the billing and shipping addresses info a user_order.
-- All the values in '' starting with "entered_" are all entered by a user
-- on the application side of the database or gotten from a separate query.
update user_order
set order_bill_addr = 'entered_order_bill_addr', order_ship_addr = 'entered_order_ship_addr'
where order_num = 'entered_order_num';


-- #10
-- Deleting a book.
-- 'entered_ISBN' is entered by an owner on the application side of the database.
delete from book
where ISBN = 'entered_ISBN';
delete from book_author
where ISBN = 'entered_ISBN';
delete from book_genre
where ISBN = 'entered_ISBN';


-- #11
-- Deleting a publisher.
-- 'entered_publisher_name' is entered by an owner on the application side of the database.
delete from publisher
where publisher_name = 'entered_publisher_name';
delete from publisher_phone
where publisher_name = 'entered_publisher_name';
