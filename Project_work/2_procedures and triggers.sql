use polls;

/*
 * Процедуры и триггеры для таблицы users_ban и флага is_banned в таблице users
 * 
 * Процедура to_ban отправляет пользователя в бан. Нужно указать id пользователя и причину.
 * Триггер update_users_when_banned после вставки в таблицу users_bans обновляет информацию в таблице users - переводит флаг is_banned = 1
 * 
 * Процедура from_ban удаляет пользователя из бана. Нужно указать id пользователя.
 * Триггер update_users_when_unbanned после удаления записи из таблицы users_bans обновляет информацию в таблице users - переводит флаг is_banned = 0
 */

set @moderator_id = 5;
drop procedure if exists to_ban;
drop trigger if exists update_users_when_banned;
drop procedure if exists from_ban;
drop trigger if exists update_users_when_unbanned;

delimiter //
create procedure to_ban(in ban_user_id bigint, in ban_reason varchar(255))
begin
	declare is_banned tinyint(1);
	select count(*) into is_banned from users_bans where user_id = ban_user_id;
	if is_banned=0 then
		insert into users_bans (user_id, reason, moderator_id) values
		(ban_user_id, ban_reason, @moderator_id);
	else
		signal sqlstate '45000'
			set message_text = 'Пользователь уже забанен';
	end if;
end//

create trigger update_users_when_banned after insert on users_bans
for each row 
begin
	update users 
	set is_banned = 1
	where id = new.user_id;
end//

create procedure from_ban(in ban_user_id bigint)
begin
	declare is_banned tinyint(1);
	select count(*) into is_banned from users_bans where user_id = ban_user_id;
	if is_banned=1 then
		delete from users_bans where user_id = ban_user_id;
	else
		signal sqlstate '45000'
			set message_text = 'Такого пользователя нет';
	end if;
end//

create trigger update_users_when_unbanned after delete on users_bans
for each row 
begin
	update users 
	set is_banned = 0
	where id = old.user_id;
end//
delimiter ;

-- проверка
select is_banned from users where id = 361796;
call to_ban(361796, 'fraud');
select is_banned from users where id = 361796;
select * from users_bans;
call to_ban(361796, 'fraud');
call from_ban(361796);
select * from users_bans;
select * from users where id = 361796;





/*
 * Триггер обновляет запись joined_polls_cnt в таблице users. 
 * Обернута триггером, который срабатывает после вставки записи в таблицу currentstates
 */

drop procedure if exists update_users_joined_polls_cnt;
drop trigger if exists on_insert_currentstates;

delimiter //
create procedure update_users_joined_polls_cnt(in to_user bigint)
begin
	update users 
		set joined_polls_cnt = joined_polls_cnt + 1
	where id = to_user;
end//

create trigger on_insert_currentstates after insert on currentstates
for each row 
begin
	call update_users_joined_polls_cnt(new.user_id);
end//
delimiter ;

-- проверка
select joined_polls_cnt from users where id = 361796;
insert into currentstates (poll_id, screen_id, question_id, user_id) values (532, 23344, 43510, 361796);
select joined_polls_cnt from users where id = 361796;






/*
 * При звершении прохождения опроса триггер вставляет запись в points_transactions, 
 * и в случае успешного прохождения обновляет число баллов у пользователя в таблице users 
 * и число интервью в опросе в таблице polls
 * Срабатывает после обновления таблицы currentstates
 */
drop trigger if exists on_update_currentstates;

delimiter //
create trigger on_update_currentstates after update on currentstates
for each row 
begin
	declare is_success tinyint(1);
	declare points int;
	select is_win into is_success from screens where id = new.screen_id;
	
	if is_success=1 then
		select cost into points from polls where id = old.poll_id;
	else
		select incentive_points into points from polls where id = old.poll_id;
	end if;

	if (new.time_poll_finished is not null and is_success = 1) then
		update polls 
		set interviews_actual_number = interviews_actual_number + 1
		where id = old.poll_id;
	end if;
	
	insert into points_transactions 
	(user_id,category,points,data_type,data_id) 
	values
	(old.user_id,'poll_finished',points,'current_state_id',old.id);
	
	update users
		set current_points = current_points + points
	where id = old.user_id;
end//
delimiter ;

-- проверка
select current_points from users where id = 361796;
select interviews_actual_number from polls where id = 532;
update currentstates 
set 
	screen_id = 23354,
	question_id = null,
	time_poll_finished = current_timestamp()
where id = 13571852;
select joined_polls_cnt from users where id = 361796;
select current_points from users where id = 361796;
select interviews_actual_number from polls where id = 532;



/*
 * Процедура вставки записи в таблицу invites. Нужно указать user_id, который отправил приглашение
 * Если это первое приглашение юзера, ему начисляются поощрительные баллы (увеличивается число текущих баллов в таблице users) 
 * и транзакция отражается в таблице points_transactions
 */

drop procedure if exists invites_insert;
delimiter //
create procedure invites_insert (in from_user bigint, out param tinyint)
begin
	
	declare invite_id int;
	declare reward_first_invite int;
	declare inv_num int;
	declare exit handler for sqlexception rollback;
	declare exit handler for sqlwarning rollback;
	set param = 0;
	set reward = 10;

	insert into invites (user_id) values (from_user);
	set invite_id = LAST_INSERT_ID();
	set param = 1;

	select count(id) into inv_num from invites where user_id = from_user;
	
	if (inv_num = 1) then
		start transaction;
			insert into points_transactions 
			(user_id,category,points,data_type,data_id) 
			values
			(from_user,'app_invite_first_rewarded',reward_first_invite,'app_invite_id',invite_id);
			
			update users
				set current_points = current_points + reward_first_invite
			where id = from_user;
			
			set param = 2;
		commit;
	end if;
end//
delimiter ;

-- проверка
select u.id as user_id,
u.current_points,
i.id as invite_id
from users u 
join invites i on u.id = i.user_id
where u.id = 361796;

call invites_insert(361796, @param);
select @param;

select u.id as user_id,
u.current_points,
i.id as invite_id
from users u 
join invites i on u.id = i.user_id
where u.id = 361796;

select * from points_transactions pt  where pt.user_id = 361796;





/*
 * Процедура обновления записи в таблице invites: приглашенный выполнил условия и приглашавшему должны начислиться баллы. 
 * Нужно указать id инвайта
 * Процедура обновляет запись в таблице invites, начисляет баллы пригласившему пользователю и отражает транзакцию в таблице points_transaction
 */

drop procedure if exists invites_update;
delimiter //
create procedure invites_update (in invite_id bigint, out param tinyint)
begin
	
	declare to_user int;
	declare transaction_id int;
	declare reward_invite_copleted int;
	declare exit handler for sqlexception rollback;
	declare exit handler for sqlwarning rollback;
	set param = 0;
	set reward_invite_copleted = 20;
	
	select user_id into to_user from invites where id = invite_id;
	start transaction;
		update users
		set current_points = current_points + reward_invite_copleted
		where id = to_user;
		
		insert into points_transactions 
		(user_id,category,points,data_type,data_id) 
		values
		(to_user,'app_invite_rewarded',reward_invite_copleted,'app_invite_id',invite_id);
		
		set transaction_id = LAST_INSERT_ID();
		
		update invites
		set is_reward_allowed=1, reward_transaction_id = transaction_id, status_id = 2
		where id = invite_id;
		
		set param = 1;
	commit;	
end//
delimiter ;


--- проверка
select u.id as user_id,
u.current_points,
i.id as invite_id,
i.status_id as invite_status
from users u 
join invites i on u.id = i.user_id
where u.id = 361796;

select id into @invite from invites where user_id = 361796;

call invites_update(@invite, @param);
select @param;

select u.id as user_id,
u.current_points,
i.id as invite_id,
i.status_id as invite_status
from users u 
join invites i on u.id = i.user_id
where u.id = 361796;

select * from points_transactions pt  where pt.user_id = 361796;





/*
 * Процедура обновления записи в таблице invites: приглашенный выполнил условия и приглашавшему должны начислиться баллы. 
 * Нужно указать id инвайта
 * Процедура обновляет запись в таблице invites, начисляет баллы пригласившему пользователю и отражает транзакцию в таблице points_transaction
 */

drop procedure if exists payment;
delimiter //
create procedure payment (in to_user bigint, in payment_points int, out param tinyint)
begin
	
	declare user_balance int;
	declare negative_points int;
	declare payment_id int;
	declare transaction_id int;
	-- declare exit handler for sqlexception rollback;
	-- declare exit handler for sqlwarning rollback;
	set param = 0;
	set negative_points = payment_points * -1;
	
	select current_points into user_balance from users where id = to_user;
	
	if user_balance<payment_points then
		signal sqlstate '45000'
			set message_text = 'Баланс пользователя меньше запрашиваемой транзакции';
	else
		start transaction;
			update users
			set current_points = current_points - payment_points
			where id = to_user;
			
			insert into payments (user_id,points) values
			(to_user,payment_points);
			set payment_id = LAST_INSERT_ID();
			
			insert into points_transactions 
			(user_id,category,points,data_type,data_id) 
			values
			(to_user,'withdrawal',negative_points,'payment_id',payment_id);
			set transaction_id = LAST_INSERT_ID();
			
			update payments
			set payment_transaction_id = transaction_id
			where id = payment_id;
		
			set param = 1;
		commit;	
	end if;
end//
delimiter ;

-- проверка
select current_points from users where id = 361796;
call payment(361796, 100, @param);

update users set current_points = 130 where id = 361796;
call payment(361796, 100, @param);
select @param;
select current_points from users where id = 361796;
select * from points_transactions pt  where pt.user_id = 361796;
select * from payments pt  where pt.user_id = 361796;