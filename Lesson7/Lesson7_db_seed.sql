DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS `catalogs`;
CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  ('1', 'Процессоры'),
  ('2', 'Материнские платы'),
  ('3', 'Видеокарты'),
  ('4', 'Жесткие диски'),
  ('5', 'Оперативная память');

DROP TABLE IF EXISTS rubrics;
CREATE TABLE rubrics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics VALUES
  (NULL, 'Видеокарты'),
  (NULL, 'Память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id bigint(20) unsigned not NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (catalog_id) REFERENCES catalogs(id),
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, '1'),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, '1'),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, '1'),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, '1'),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, '2'),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, '2'),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, '2'),
  ('VOLUPTATE', 'Fugiat exercitationem corporis animi sed et voluptas in.', 1310.00, '3'),
  ('DICTA', 'Fugiat minima sint repudiandae quaerat omnis non.', 14790.00, '3'),
  ('EUM', 'Blanditiis molestias officiis voluptas repudiandae.', 9060.00, '3');
  

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  FOREIGN KEY (user_id) REFERENCES users(id),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Заказы';

INSERT INTO `orders` VALUES ('1','1','1977-02-14 07:56:38','2018-08-20 09:13:37'),
('2','2','1997-10-27 08:06:15','1995-05-22 18:47:17'),
('3','3','1994-05-06 09:12:38','1992-06-28 06:55:29'),
('4','4','2008-12-11 23:37:30','2013-03-31 07:10:41'),
('5','5','1981-06-03 18:26:10','1984-03-03 23:33:37'),
('6','1','2007-07-28 15:07:58','1982-04-30 10:19:26'),
('7','1','2002-10-25 22:36:33','2014-10-31 15:56:39'),
('8','2','1988-11-16 07:09:11','2003-02-25 14:18:51'),
('9','3','1989-07-06 04:30:45','1993-12-17 21:20:33'),
('10','4','2013-07-31 15:01:59','2017-10-19 15:47:49'),
('11','5','2014-05-25 02:46:35','1991-12-24 21:01:52'),
('12','1','1987-05-21 20:53:56','2005-05-18 14:31:09'),
('13','1','2019-02-09 09:42:55','1989-09-04 09:06:59'),
('14','2','1983-08-29 22:11:01','2009-10-28 09:57:54'),
('15','3','2004-04-25 08:24:57','1991-12-29 01:39:00'),
('16','4','1996-07-20 22:06:34','1980-03-13 17:49:47'),
('17','5','2008-03-16 16:00:52','2008-05-31 23:48:45'),
('18','1','1983-04-28 00:40:33','2008-05-10 01:12:37'),
('19','1','1995-03-26 17:16:10','2003-12-25 14:39:45'),
('20','2','1983-11-15 20:44:29','2013-04-09 14:06:44'),
('21','3','1987-01-20 05:31:27','1971-03-08 09:14:02'),
('22','4','2013-10-02 05:08:24','1982-06-30 02:23:38'),
('23','5','1992-11-14 12:43:28','2014-04-23 20:02:59'),
('24','1','2017-02-20 03:15:12','1997-08-05 02:52:00'),
('25','1','1998-11-27 14:28:54','1975-05-25 09:51:39'); 


DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Состав заказа';

INSERT INTO `orders_products` VALUES ('1','1','1','10','2003-12-05 12:38:04','2002-02-11 08:45:36'),
('2','2','2','9','2009-05-28 22:28:30','1987-10-24 13:21:16'),
('3','3','3','7','1981-07-16 21:08:51','2001-08-24 05:38:51'),
('4','4','4','6','1990-01-29 20:43:39','1973-11-11 00:47:56'),
('5','5','5','9','2019-03-17 16:30:03','2014-05-17 20:43:15'),
('6','6','6','3','1995-02-12 12:05:35','1971-11-15 09:53:51'),
('7','7','7','9','1995-10-28 18:36:57','2014-11-24 04:29:11'),
('8','8','8','4','1995-02-13 03:06:26','2019-10-20 09:39:01'),
('9','9','9','2','1985-07-03 13:24:11','1985-09-03 00:42:52'),
('10','10','10','1','1999-10-01 14:04:58','1995-05-14 00:21:18'),
('11','11','1','7','1990-06-27 04:57:02','2002-10-08 09:03:25'),
('12','12','2','5','1977-02-24 23:12:41','1970-06-10 12:57:26'),
('13','13','3','4','1983-05-23 05:48:00','2014-10-06 09:02:24'),
('14','14','4','7','1981-04-04 06:00:36','1977-04-18 19:23:53'),
('15','15','5','9','1994-05-31 07:08:28','1993-12-16 14:04:20'),
('16','16','6','10','2000-07-31 02:25:10','1997-10-07 06:37:21'),
('17','17','7','6','1999-11-29 17:08:45','1992-04-13 13:06:11'),
('18','18','8','5','2003-02-21 22:47:26','2015-07-15 05:15:09'),
('19','19','9','7','2003-10-18 00:21:17','2009-01-30 05:20:06'),
('20','20','10','5','1986-08-07 08:44:01','2002-08-12 21:45:20'),
('21','21','1','4','1997-08-02 15:20:34','2016-04-20 04:32:08'),
('22','22','2','1','2000-08-04 19:08:45','2002-04-06 05:54:41'),
('23','23','3','8','1996-02-09 19:33:44','1998-09-14 07:18:46'),
('24','24','4','10','2002-01-10 14:50:44','2015-08-11 04:31:42'),
('25','25','5','5','1997-03-25 07:19:09','1973-05-23 04:29:08'); 


DROP TABLE IF EXISTS `storehouses`;
CREATE TABLE `storehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Склады';

INSERT INTO `storehouses` VALUES ('1','blanditiis','2017-09-10 15:55:17','1996-01-19 13:03:37'),
('2','assumenda','1995-01-02 15:21:57','1972-01-21 03:33:00'),
('3','inventore','2016-05-13 15:53:20','2000-01-24 08:58:45'); 


DROP TABLE IF EXISTS `storehouses_products`;
CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` bigint(20) unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  FOREIGN KEY (storehouse_id) REFERENCES storehouses(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Запасы на складе';

INSERT INTO `storehouses_products` VALUES ('1','1','1','20','1974-07-30 19:06:13','1985-11-02 04:02:42'),
('2','2','2','15','1970-11-08 07:40:25','2013-03-10 19:25:39'),
('3','3','3','40','1994-04-04 22:04:10','1983-12-26 21:15:30'),
('4','1','4','95','2010-07-07 10:11:56','1996-01-14 18:44:29'),
('5','2','5','100','1994-06-06 03:24:31','1993-10-27 21:43:03'),
('6','3','6','12','1970-03-21 11:13:47','2001-10-28 19:38:33'),
('7','1','7','55','1998-02-02 18:01:53','2008-05-14 18:19:01'),
('8','2','8','52','1973-01-08 21:23:52','1973-10-12 12:42:14'),
('9','3','9','68','1985-10-01 05:36:14','2018-12-11 23:36:08'),
('10','1','10','40','1988-02-09 19:59:17','1983-06-26 00:47:56'),
('11','2','1','2','1986-01-06 15:02:29','2001-10-08 08:53:05'),
('12','3','2','71','1975-04-03 04:53:35','1988-02-13 02:04:39'),
('13','1','3','6','2012-06-21 15:00:28','2014-01-02 20:33:00'),
('14','2','4','85','2018-10-02 17:06:10','1973-12-05 02:31:07'),
('15','3','5','38','2000-08-09 18:48:21','1988-08-12 15:04:12'),
('16','1','6','92','1983-04-26 06:58:22','1977-03-25 22:04:18'),
('17','2','7','45','2009-02-25 23:57:07','1989-05-19 14:40:54'),
('18','3','8','9','1977-03-16 23:51:19','2007-08-24 06:15:21'),
('19','1','9','78','1990-04-28 06:29:54','1989-10-13 17:07:39'),
('20','2','10','63','2019-05-29 09:33:25','1989-09-06 03:29:40'); 

