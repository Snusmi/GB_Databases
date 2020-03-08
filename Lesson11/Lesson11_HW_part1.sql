/*
 * Создайте таблицу logs типа Archive. 
 * Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, 
 * название таблицы, идентификатор первичного ключа и содержимое поля name.
 */


use shop;

drop table if exists logs;
create table logs (
	id serial,
	`table` varchar(255) not null,
	created_at datetime default now(),
	table_key_id bigint not null,
	table_name varchar(255)
	
) ENGINE=Archive;

drop trigger if exists log_insert_products;
drop trigger if exists log_insert_catalogs;
drop trigger if exists log_insert_users;
DELIMITER //
//
create trigger log_insert_products after insert on products
for each row 
begin 
	insert into logs (`table`, table_key, table_name) VALUES ('produtcs', new.id, new.name);
end//

create trigger log_insert_catalogs after insert on catalogs
for each row 
begin 
	insert into logs (`table`, table_key, table_name) VALUES ('catalogs', new.id, new.name);
end//

create trigger log_insert_users after insert on users
for each row 
begin 
	insert into logs (`table`, table_key, table_name) VALUES ('catalogs', new.id, new.name);
end//

DELIMITER ;