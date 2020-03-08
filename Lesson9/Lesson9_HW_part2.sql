/*Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)*/

/*
 * Создайте двух пользователей которые имеют доступ к базе данных shop. 
 * Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
 * второму пользователю shop — любые операции в пределах базы данных shop.
 */

use shop;
create user 'shop_read'@'localhost' identified by 'pass1';
grant select on shop.* TO 'shop_read'@'localhost';

create user 'shop'@'localhost' identified by 'pass2';
grant all on shop.* TO 'shop'@'localhost';

show grants for 'shop'@'localhost';
show grants for 'shop_read'@'localhost';

revoke all on *.* from 'shop_read'@'localhost';
revoke all on *.* from 'shop'@'localhost';
drop user 'shop_read'@'localhost';
drop user 'shop'@'localhost';



/*
 * Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
 * Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
 * Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
*/

drop table if exists accounts;
create table accounts (
	id serial primary key,
	name varchar(50) not null,
	`password` varchar(12) not null
);

insert into accounts
	(name, `password`)
values
('name1', 'password1'),
('name2', 'password2'),
('name3', 'password3'),
('name4', 'password4'),
('name5', 'password5');

select * from accounts;

create or replace view username as 
select a.id, a.name 
from accounts as a;

select * from username;

create user 'user_read'@'localhost' identified by 'pass';
grant select on shop.username TO 'user_read'@'localhost'; -- таблица и вьюха создавались в бд shop
show grants for 'user_read'@'localhost';

revoke all on *.* from 'user_read'@'localhost';
drop user 'user_read'@'localhost';