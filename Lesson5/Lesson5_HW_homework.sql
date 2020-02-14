USE shop;

/*
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
 */
update users
set 
	created_at = now(),
	updated_at = now();

select created_at, updated_at from users;

/*
Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

-- сначала сымитируем VARCHAR данные
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at VARCHAR(16) COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '05.10.1990  8:10'),
  ('Наталья', '12.11.1984  8:10'),
  ('Александр', '20.05.1985  8:10'),
  ('Сергей', '14.02.1988 18:10'),
  ('Иван', '12.01.1998 18:10'),
  ('Мария', '29.08.1992 18:10');

alter table users add column new_birthday DATETIME;
update users
set new_birthday = str_to_date(birthday_at, '%d.%m.%Y %H:%i');

alter table users 
drop column birthday_at,
rename column new_birthday to birthday_at;

describe users;
select birthday_at from users;

/*
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/

-- таблица storehouses_products пустая (
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO `storehouses_products` VALUES ('1','2','3','7','1979-04-26 17:28:23','1972-07-08 01:08:04'),
('2','1','1','2','2019-05-27 21:16:14','1982-05-02 15:19:55'),
('3','3','1','9','1979-03-19 18:56:29','1979-10-26 00:17:14'),
('4','3','7','0','1978-01-05 11:45:17','1995-11-23 14:07:19'),
('5','1','2','5','1974-05-26 01:47:24','2010-12-05 15:39:38'),
('6','2','3','7','2018-05-03 10:30:04','1978-09-24 09:11:25'),
('7','2','5','0','2018-01-06 00:17:49','1979-04-06 05:57:26'),
('8','3','1','1','1984-12-14 11:17:39','1971-12-20 06:28:14'),
('9','1','5','0','2008-03-12 20:09:22','1992-05-17 05:10:42'),
('10','2','6','6','2001-07-23 10:02:09','2014-05-09 19:58:46'); 

select * from storehouses_products order by value = 0, value;

/*
 * Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 * Месяцы заданы в виде списка английских названий ('may', 'august')
 */

select * 
from (
	select 
	*,
	monthname(birthday_at) as name_month
	from users ) as t
where name_month in ('May', 'August');

/*
 * Подсчитайте средний возраст пользователей в таблице users
 */

select round(avg(datediff(curdate(), birthday_at)/365.25),1) from users;

/*
 * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 */

select DAYNAME(DATE(CONCAT_WS('-', y, m, d))) as this_year_day,
DATE(CONCAT_WS('-', y, m, d)) as this_year_month_day,
birthday_at,
name
from (
select 
day(birthday_at) as d,
month(birthday_at) as m,
'2020' as y,
name,
birthday_at
from users
) as t;

select COUNT(distinct DAYNAME(DATE(CONCAT_WS('-', y, m, d)))) as this_year_days_count
from (
select 
day(birthday_at) as d,
month(birthday_at) as m,
'2020' as y
from users
) as t;

/*
 * Подсчитайте произведение чисел в столбце таблицы
 */

DROP TABLE IF EXISTS tbl_values;
CREATE TABLE tbl_values (
  value INT
);

insert into tbl_values values ('1'),('2'),('3'),('4'),('5');

-- погуглила
select exp(sum(log(value))) from tbl_values;