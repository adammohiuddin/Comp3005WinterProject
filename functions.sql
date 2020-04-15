-- Comp 3005: Project (Winter 2020)
-- Name: Adam Mohiuddin
-- ID: 101003042



-- #1
-- Get the most recent order date for a book when given a book ISBN.
-- This function is used to help calculate the price of a book.
create function most_recent(ISBN numeric(13,0))
	return date
	begin
	declare recent_order date;
		select max(order_date) into recent_order
		from order_book
		where order_book.ISBN = ISBN
	return recent_order
	end


-- #2
-- Get the most recent order date for a book when given a book ISBN and a max_date.
-- This function is used to help calculate the price of a book to display to owner.
create function most_recent_for_date(ISBN numeric(13,0), max_date date)
	return date
	begin
	declare recent_order date;
		select max(order_date) into recent_order
		from order_book
		where order_book.ISBN = ISBN and order_date <= max_date
	return recent_order
	end


-- #3
-- Get the price for a book when given a ISBN and a date.
-- This function is used to help display statistics to an owner.
create function price_of(ISBN numeric(13,0), order_date date)
	return numeric(5,2)
	begin
	declare book_price numeric(5,2);
		select book_cost * 1.4 + (book_cost * 0.4) * (publisher_percent / 100) as price into book_price
		from order_book
		where order_book.ISBN = ISBN and order_date = most_recent_for_date(ISBN, order_date)
	return recent_order
	end


