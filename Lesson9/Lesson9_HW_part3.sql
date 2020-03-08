-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

/*
*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
*С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
*с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
*с 18:00 до 00:00 — "Добрый вечер", 
*с 00:00 до 6:00 — "Доброй ночи".
*/


drop function if exists hello;
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
//
create function hello()
returns varchar(255) not deterministic
begin
	declare greeting varchar(255);
	declare right_now int;
	set right_now = hour(now());
	if (right_now in (6,7,8,9,10,11)) then 
		set greeting = 'Доброе утро';
	elseif (right_now in (12,13,14,15,16,17)) then 
		set greeting = 'Добрый день';
	elseif (right_now in (18,19,20,21,22,23)) then 
		set greeting = 'Добрый вечер';
	elseif (right_now in (0,1,2,3,4,5)) then 
		set greeting = 'Доброй ночи';
	end if;
	return greeting;
end//

delimiter ;

select hello();

/*
В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

drop trigger if exists check_products_insert;
drop trigger if exists check_products_update;
DELIMITER //
//
create trigger check_products_insert before insert on products
for each row 
begin 
	if (new.name is null and new.description is null) then 
		signal sqlstate '45000' set message_text = '"name" or "description" must not be null. Operation cancelled';
	end if;
end//

create trigger check_products_update before update on products
for each row 
begin 
	if (new.name is null and new.description is null) then 
		signal sqlstate '45000' set message_text = '"name" or "description" must not be null. Operation cancelled';
	end if;
end//

delimiter ;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Some name', NULL, 1234.00, '2');
  
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, 'Some description', 1234.00, '2');
  
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, NULL, 1234.00, '2');
  
select * from products;

update products 
set name = null where id = 1;

update products 
set description = null where id = 2;

update products 
set name = null, description = null where id = 3;

/*
 * Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
 * Вызов функции FIBONACCI(10) должен возвращать число 55.
 */

drop function if exists fibonacci;
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
//
create function fibonacci(n int)
returns bigint not deterministic
begin
	declare res bigint;
	set res = (pow((1+sqrt(5))/2,n)+pow((1-sqrt(5))/2,n))/sqrt(5);
	return res;
end//

DELIMITER ;

select fibonacci(10);