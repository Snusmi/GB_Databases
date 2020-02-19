/*
Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/

use vk;

select
	user_id,
	max(user_id) as times
from
	(
	select
		id,
		from_user_id as user_id
	from
		messages
	where
		to_user_id = 3
union
	select
		id,
		to_user_id as user_id
	from
		messages
	where
		from_user_id = 3) as t
where
	user_id in (
	select
		distinct friend
	from
		(
		select
			initiator_user_id as friend,
			target_user_id as sel_user,
			`status`
		from
			friend_requests
		where
			`status` = 'approved'
			and target_user_id = 3
	union
		select
			target_user_id as friend,
			initiator_user_id as sel_user,
			`status`
		from
			friend_requests
		where
			`status` = 'approved'
			and initiator_user_id = 3) as t2);
		

select 
	count(*) as likes_cnt, 
	COALESCE(sex, 'total') as sex
from (
	select 
		count(*) as likes_cnt,
		user_id,
		(select gender from profiles where user_id = likes.user_id) as sex
	from likes
	where 
		user_id in 	(select user_id from profiles where (birthday + interval 10 year) < now() )
	group by user_id) as t 
group by sex with rollup;