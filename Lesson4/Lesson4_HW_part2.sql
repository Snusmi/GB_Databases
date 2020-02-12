/*
ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
*/

select distinct firstname from vk.users order by firstname asc;

/*
iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
*/

alter table vk.profiles
add is_active bool not null default true;

select birthday from vk.profiles limit 10;

update vk.profiles 
set is_active = false
where datediff(curdate(), birthday)/365.25 < 18;

select birthday from vk.profiles limit 10;

/*
iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
*/

select created_at from vk.messages order by created_at desc limit 10;

delete from vk.messages
where created_at > now();

select created_at from vk.messages order by created_at desc limit 10;