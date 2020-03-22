delimiter //
drop trigger if exists calculate_user_age//
create trigger calculate_user_age before insert on users
for each row 
begin
	if (new.birthday is not null) then
		set new.age = TIMESTAMPDIFF(YEAR,STR_TO_DATE(new.birthday,'%Y-%m-%d'),now());
	else
		set new.age = null;
	end if;
end//


drop trigger if exists update_users_when_banned//
create trigger update_users_when_banned after insert on users_bans
for each row 
begin
	update users 
	set is_banned = 1
	where id = new.user_id;
end//

drop trigger if exists update_users_when_delete_from_banned//
create trigger update_users_when_delete_from_banned after delete on users_bans
for each row 
begin
	update users 
	set is_banned = 0
	where id = old.user_id;
end//

create or replace procedure update_users_joined_polls_cnt (to_user bigint)
begin
	update users 
		set joined_polls_cnt = joined_polls_cnt + 1
	where id = to_user;
end//

drop trigger if exists on_insert_currentstates//
create trigger on_insert_currentstates after insert on currentstates
for each row 
begin
	if (new.time_poll_finished is not null) then
		call update_users_joined_polls_cnt(new.user_id);
	end if;
end//


create or replace procedure update_polls_interviews_cnt (to_poll bigint)
begin
	update polls 
		set interviews_actual_number = interviews_actual_number + 1
	where id = to_poll;
end//

create or replace procedure points_transactions_after_poll_finished (to_user bigint, at_points int, from_currstate bigint, out param tinyint(1))
begin
	set param = 0;
	declare exit handler for sqlexception rollback;
	declare exit handler for sqlwarning rollback;
	
	start transaction;
		insert into points_transactions 
		(user_id,category,points,data_type,data_id) 
		values
		(to_user,'poll_finished',at_points,'current_state_id',from_currstate);
		
		update users
		set current_points = current_points + at_points
		where user_id = to_user;
		
		set param = 1;
	commit;	
end//


drop trigger if exists on_update_currentstates//
create trigger on_update_currentstates after update on currentstates
for each row 
begin
	declare is_success tinyint(1);
	declare points int;
	select is_win from screens where id = new.screen_id into is_success;
	select cost from polls where id = old.poll_id into points;
	if (new.time_poll_finished is not null and is_success = 1) then
		call update_poll_interviews_cnt(old.poll_id);
	end if;
	call points_transactions_after_poll_finished(old.user_id,points,old.id);
end//

create or replace procedure app_invite_first_rewarded_transaction (to_user bigint, invite_id bigint, out param tinyint(1))
begin
	set param = 0;
	declare exit handler for sqlexception rollback;
	declare exit handler for sqlwarning rollback;
	
	start transaction;
		insert into points_transactions 
		(user_id,category,points,data_type,data_id) 
		values
		(to_user,'app_invite_first_rewarded',10,'app_invite_id',invite_id);
		
		update users
		set current_points = current_points + 10
		where user_id = to_user;
		
		set param = 1;
	commit;	
end//

drop trigger if exists on_insert_invites//
create trigger on_insert_invites after insert on invites
for each row 
begin
	declare n_invites int;
	select count(*) from invites where user_id = new.user_id into is_first;
	if (n_invites = 1) then
		call app_invite_first_rewarded_transaction(new.user_id, new.id);
	end if;
end//


create or replace procedure update_invite_to_reward (invite_id bigint, out param tinyint(1))
begin
	set param = 0;
	
	declare to_user int;
	select user_id into to_user from invites where id = invite_id;
	
	declare exit handler for sqlexception rollback;
	declare exit handler for sqlwarning rollback;
	
	start transaction;
		update users
		set current_points = current_points + 20
		where user_id = to_user;
		
		declare transaction_id int;
		
		insert into points_transactions 
		(user_id,category,points,data_type,data_id) 
		values
		(to_user,'app_invite_rewarded',20,'app_invite_id',invite_id);
		
		set transaction_id = LAST_INSERT_ID();
		
		update invites
		set is_reward_allowed=1, reward_transaction_id = transaction_id
		where id = invite_id;
		
		set param = 1;
	commit;	
end//


create or replace procedure withdraw (from_user bigint, at_points int, out param tinyint(1))
begin
	set param = 0;
	declare user_balance, negative_points int;
	select current_points into user_balance from users where id = from_user;
	set negative_points = at_points * -1;
	
	declare exit handler for sqlexception rollback;
	declare exit handler for sqlwarning rollback;

	if user_balance<at_points then
		signal sqlstate '45000'
			set message_text = 'Баланс пользователя меньше запрашиваемой транзакции';
	end if;
	
	start transaction;
		update users
		set current_points = current_points - at_points
		where user_id = from_user;
		
		declare payment_id int;
		insert into payments (user_id,points) values
		(from_user,at_points);
		set payment_id = LAST_INSERT_ID();
		
		declare transaction_id int;
		insert into points_transactions 
		(user_id,category,points,data_type,data_id) 
		values
		(from_user,'withdrawal',negative_points,'payment_id',invite_id);
		set transaction_id = LAST_INSERT_ID();
		
		update payments
		set reward_transaction_id = transaction_id
		where id = payment_id;
	
		set param = 1;
	commit;	
end//	
	
	
	
CREATE PROCEDURE Withdraw(
    fromAccountId INT, 
    withdrawAmount DEC(10,2)
)
BEGIN
    IF withdrawAmount <= 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'The withdrawal amount must be greater than zero';
    END IF;
    
    UPDATE accounts 
    SET amount = amount - withdrawAmount
    WHERE accountId = fromAccountId;
END$$
 
DELIMITER ;


/*
нужно обновлять таблицу пойнт-транзакции в зависимости от 

drop trigger if exists update_user_points//
create trigger update_user_points after insert on currentstates
for each row 
begin
	declare is_success tinyint(1);
	declare points int;
	select is_win from screens where id = new.screen_id into is_success;
	select cost from polls where id = old.poll_id into points;
	if (new.time_poll_finished is not null and is_success = 1) then
		update users 
			set current_points = current_points + points
		where id = old.user_id;
	end if;
end//
