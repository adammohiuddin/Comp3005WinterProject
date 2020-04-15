-- Comp 3005: Project (Winter 2020)
-- Name: Adam Mohiuddin
-- ID: 101003042



-- #1
-- Query to search for a book title from the collection of books.
-- entered_title is replaced by the title entered by the user.
select title, published_year, ISBN
from book
where title = 'entered_title';


-- #2
-- Query to search for all books by an author from the collection of books.
-- entered_author is replaced by the author entered by the user.
select title, published_year, ISBN
from book natural join book_author
where author = 'entered_author';


-- #3
-- Query to search for an ISBN from the collection of books.
-- entered_ISBN is replaced by the ISBN entered by the user.
select title, published_year, ISBN
from book
where ISBN = 'entered_ISBN';


-- #4
-- Query to search for all books by a publisher from the collection of books.
-- entered_publisher is replaced by the publisher entered by the user.
select title, published_year, ISBN
from book natural join publish 
where publisher = 'entered_publisher';


-- #5
-- Query to search for all books in a genre from the collection of books.
-- entered_genre is replaced by the genre entered by the user.
select title, published_year, ISBN
from book natural join book_genre
where genre = 'entered_genre';


-- #6
-- Query to find all authors for a given book.
-- 'given_ISBN' is the ISBN used for an individual book.
select author
from book_author
where ISBN = 'given_ISBN';


-- #7
-- Query to find all the genres for a given book.
-- 'given_ISBN' is the ISBN used for an individual book.
select genre
from book_genre
where ISBN = 'given_ISBN';


-- #8
-- Query to get the title, subtitle, page_count, publisher_name, published_year, book_synopsis, language, 
-- and format of a given book.
-- 'given_ISBN' is the ISBN used for an individual book.
select title, subtitle, page_count, publisher_name, published_year, book_synopsis, language, format
from book
where ISBN = 'given_ISBN';


-- #9
-- Query to get the quantity in stock of a given book.
-- This uses the views quantity_of_bought_books and quantity_of_sold_books (seen in DDL.sql).
-- The actual quantity is calculated on the application side by subtracting number_sold from number_bought.
-- Left outer join is used as there may be books which were bought but have never been sold at all.
-- 'given_ISBN' is the ISBN used for an individual book.
select number_bought, number_sold
from quantity_of_bought_books left outer join quantity_of_sold_books
where ISBN = 'given_ISBN';


-- #10
-- Query to get the current price of a book.
-- This current price is calculated using the publisher_percent and the book_cost for the most
-- recent shipment of the book.
-- The calculation is sales_price = book_cost * 1.4 + (book_cost * 0.4) * (publisher_percent / 100).
-- This value is calculated on the application side of the database, the only thing that is returned
-- here is the publisher_percent and the book_cost.
-- This query uses the function most_recent(ISBN) (#1 in functions.sql).
-- 'given_ISBN' is the ISBN used for an individual book.
select publisher_percent, book_cost
from order_book
where ISBN = 'given_ISBN' and order_date = most_recent(ISBN);


-- #11
-- Query to check if a given email and password exists for a user.
-- 'entered_email' and 'entered_password' are entered by the user on the application side.
select user_ID
from user
where email = 'entered_email' and password = 'entered_password';


-- #12
-- Query to get the first and last name of a user.
-- 'given_ISBN' is the ISBN used for an individual book.
select first_name, last_name
from user
where user_ID = 'given_user_ID';


-- #13
-- Query to get the order number of the most recent user order for a user.
-- 'entered_user_ID' is entered by a user on the application side of the database 
-- or gotten from a separate query.
select max(order_num)
from user_order
where user_ID = 'entered_user_ID';


-- #14
-- Query to get the books and quantity of books stored in a basket for a given order_num.
-- 'entered_order_num' is gotten from a separate query.
select title, quantity
from basket natural join book
where order_num = 'entered_order_num';


-- #15
-- Query to get the billing and shipping addresses from a user.
-- 'entered_user_num' is entered by a user on the application side of the database 
-- or gotten from a separate query.
select billing_addr, shipping_addr
from user
where user_num = 'entered_user_num';


-- #16
-- Query to get tracking information for the most recent order for a user.
-- 'entered_order_num' is gotten from a separate query.
select tracking_info
from user_order
where order_num = 'entered_order_num';


-- #17
-- Query to get all the orders of books given a date range.
-- 'start_date' and 'end_date' are entered by an owner on the application side of the database.
select order_num, order_date, order_qty, ISBN
from order_book
where order_date >= 'start_date' and order_date <= 'end_date';


-- #18
-- Query to get all the orders of books for a given book.
-- 'entered_ISBN' is entered by an owner on the application side of the database.
select order_num, order_date, order_qty, ISBN
from order_book
where ISBN = 'entered_ISBN';


-- #19
-- Query to get all the orders of books for a given publisher.
-- 'entered_publisher_name' is entered by an owner on the application side of the database.
select order_num, order_date, order_qty, ISBN, publisher_name
from order_book
where publisher_name = 'entered_publisher_name';


-- #20
-- Query to get how much money has been earned per book.
-- This query uses the view sale_price_for_quantity.
select ISBN, sum(quantity_price) as total_sales
from sale_price_for_quantity
group by ISBN;


-- #21
-- Query to get how much money has been earned per genre.
-- This query uses the view sale_price_for_quantity.
select genre, sum(quantity_price) as total_sales
from sale_price_for_quantity right outer join book_genre
group by genre;


-- #22
-- Query to get how much money has been earned per publisher.
-- This query uses the view sale_price_for_quantity.
select publisher_name, sum(quantity_price) as total_sales
from sale_price_for_quantity right outer join book
group by publisher_name;


-- #23
-- Query to get how much money has been earned per author.
-- This query uses the view sale_price_for_quantity.
select author, sum(quantity_price) as total_sales
from sale_price_for_quantity right outer join book_author
group by author;


-- #24
-- Query to get the sales of books when given a date range.
-- 'start_date' and 'end_date' are entered by an owner on the application side of the database.
select sum(quantity_price)
from sale_price_for_quantity
where order_date >= 'start_date' and order_date <= 'end_date';


-- #25
-- Query to get the cost of ordering books when given a date range.
-- 'start_date' and 'end_date' are entered by an owner on the application side of the database.
select sum(quantity_price)
from order_costs
where order_date >= 'start_date' and order_date <= 'end_date';


