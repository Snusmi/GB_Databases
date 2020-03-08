-- Практическое задание по теме “Транзакции, переменные, представления”

/*
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';


start transaction;
select * from shop.users where id=1; /*проверить, что такая запись сесть*/

insert into sample.users (id, name, birthday_at, created_at, updated_at)
select shop.users.id, shop.users.name, shop.users.birthday_at, shop.users.created_at, shop.users.updated_at
from shop.users 
where shop.users.id=1;

select * from sample.users; /*проверяем*/

commit;


/*
 * Создайте представление, которое выводит название name товарной позиции из таблицы products 
 * и соответствующее название каталога name из таблицы catalogs.
 */

use shop;

create or replace view products_catalogs as 
select p.name as product_name,
c.name as catalog_name
from products as p
join catalogs as c on c.id = p.catalog_id;

select * from products_catalogs;

/*
 * Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, 
 * выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
 */

drop table if exists table_dates;
create table table_dates (
	id serial primary key,
	`date` date);

insert into table_dates (`date`) values
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

select * from table_dates;

create temporary table temp_days (
	`days` int unique not null);

insert into temp_days (`days`) values
	(1), (2), (3), (4), (5), (6), (7), (8), (9), (10)
	, (11), (12), (13), (14), (15), (16), (17), (18), (19), (20)
	, (21), (22), (23), (24), (25), (26), (27), (28), (29), (30)
	, (31);

select * from temp_days;
	
select 
	date('2018-08-01') + interval (td1.`days`-1) day as august_days,
	case when td2.`date` is null then 0 else 1 end as exists_in_table_dates
from temp_days as td1
left join table_dates as td2 on td1.`days` = day(td2.`date`)
order by august_days
;

/*
 * Пусть имеется любая таблица с календарным полем created_at. 
 * Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 */

drop table if exists table_dates;
create table table_dates (
	id serial primary key,
	created_at date);

insert into table_dates (created_at) values
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-05'),
	('2018-08-06'),
	('2018-08-07'),
	('2018-08-16'),
	('2018-08-17');
	
select * from table_dates;

start transaction;
select count(*)-5 from table_dates; -- сколько строчек удалить
delete from table_dates order by created_at limit 2;
select * from table_dates;
commit;

select * from table_dates;