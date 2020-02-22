use shop;

/*
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

select users.id as id,
users.name as username,
count(orders.id) as num_orders
from orders
join users
on users.id = orders.user_id
group by username;

/*
Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

select p.id,
	p.name,
	p.description,
	p.price,
	p.catalog_id,
	c.name as catalog_name
from products as p
join catalogs as c on p.catalog_id=c.id;

/*
Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id BIGINT not null unique,
  `from` VARCHAR(255),
  `to` VARCHAR(255),
  PRIMARY KEY (`from`, `to`)
);

INSERT INTO flights (id, `from`, `to`) VALUES
  ('1', 'moscow', 'omsk'),
  ('2', 'novgorod', 'kazan'),
  ('3', 'irkutsk', 'moscow'),
  ('4', 'omsk', 'irkutsk'),
  ('5', 'moscow', 'kazan');
 
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  `label` VARCHAR(255) unique not null,
  `name` VARCHAR(255) unique not null,
  PRIMARY KEY (`label`, `name`)
);


INSERT INTO cities (`label`, `name`) VALUES
  ('moscow', 'Москва'),
  ('novgorod', 'Новгород'),
  ('irkutsk', 'Иркутск'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань');

 select f.id as flight,
 t1.name as from_city,
 t2.name as to_city
 from flights as f
 join cities as t1 on f.`from` = t1.`label`
 join cities as t2 on f.`to` = t2.`label`;