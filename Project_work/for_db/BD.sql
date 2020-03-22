drop database if exists polls;
create database polls;
use polls;

drop table if exists polls;
create table polls (
	id int(11) serial primary key,
	hash varchar(6) unique not null,
	name varchar(255) not null,
	`type` enum('BASE', 'TEST', 'COMMERCIAL'),
	image_id int(11) unsigned default null,
	cost int(11) not null default 0,
	incentive_points int(11) not null default 0,
	is_in_debug tinyint(1) not null default 0,
	questions_count int(11) not null,
	time_created datetime(6) default now(),
	time_updated datetime(6) default null on update current_timestamp,
	interviews_target_number int(11) default null,
	interviews_actual_number int(11) default 0,
	user_created_id int(11) not null,
	priority int(11) not null default 64,
	index poll_name_idx(name),
	index poll_hash_idx(hash),
	index poll_type_idx(`type`)
);

drop table if exists placements;
create table placements (
	id serial,
	name varchar(20) unique not null,
	description varchar(255) not null,
	primary key placement_name_idx(name)
);	

insert into placements (id, name, description) values
(1, "DESKTOP", "Версия только для десктопа"),
(2, "MOBILE", "Версия для мобильного приложения");

drop table if exists statuses;
create table statuses (
	id int serial,
	name varchar(20) unique not null,
	description varchar(255) not null,
	primary key status_name_idx(name)
);	

insert into statuses (id, name, description) values
(1, "OPENED_FOR_ALL", "Опрос открыт для прохождения всем пользователям."),
(2, "OPENED_FOR_INVITED", "Опрос открыт для прохождения приглашенным пользователям."),
(3, "CLOSED", "Опрос закрыт, но начавшие могу его закончить."),
(4, "ARCHIVED", "Опрос перемещен в архив.");

drop table if exists polls_placements;
create table polls_placements (
	id int serial,
	poll_id int(11) not null,
	status_id int(11) not null,
	placement_id int(11) not null,
	foreign key (poll_id) references polls(id),
	foreign key (status_id) references statuses(id),
	foreign key (placement_id) references placements(id),
	primary key (status_id)
);	

drop table if exists screens;
create table screens (
	id int serial primary key,
	idx varchar(255) not null,
	show_if varchar(255) not null,
	is_terminal tinyint(1) not null default 0,
	is_win tinyint(1) default null,
	poll_id int(11) not null,
	foreign key (poll_id) references polls(id),
	index win_trminal_idx(is_win,is_terminal)
);	

drop table if exists questions;
create table questions (
	id int(11) serial primary key,
	idx varchar(255) not null,
	show_if varchar(255) not null,
	`type` varchar(50) not null,
	`text` varchar(4095) not null,
	screen_id int(11) not null,
	foreign key (screen_id) references screens(id),
	index question_text_idx(`text`),
	index question_type_idx(`type`)
);	

drop table if exists answers;
create table answers (
	id int(11) serial primary key,
	idx int(11) not null,
	show_if varchar(255) not null,
	is_excluding tinyint(1) not null default 0,
	`type` varchar(50),
	`text` varchar(4095),
	question_id int(11) not null,
	foreign key (question_id) references questions(id),
	index answer_text_idx(`text`)
);	

drop table if exists users;
create table users (
	id int(11) serial primary key,
	sex varchar(1),
	birthday date default null,
	firstname varchar(50) collate utf8_unicode_ci default null,
	lasttname varchar(50) collate utf8_unicode_ci default null,
	region_id int(11) default null,
	current_points int(11) not null default 0,
	is_verified tinyint(1) not null default 0,
	is_banned tinyint(1) not null default 0,
	time_created datetime(6) default now(),
	time_updated datetime(6) default current_timestamp on update current_timestamp,
	user_invited_id int(11) default null,
	joined_polls_cnt int(11) not null default 0,
	foreign key (region_id) references regions(id),
	foreign key (user_invited_id) references users(id),
	index sex_idx(sex)
);

drop table if exists regions;
create table regions (
	id int(11) serial primary key,
	parent_id int(11) unsigned,
	cityname varchar(255),
	regionname varchar(255),
	country_id int(11) unsigned,
	foreign key (parent_id) references regions(id),
	foreign key (country_id) references regions(id),
	index cityname_idx(cityname),
	index regionname_idx(regionname)
);

drop table if exists users_bans;
create table users_bans (
	id int(11) serial primary key,
	user_id int(11),
	time_created datetime(6) default now(),
	reason varchar(255) not null,
	moderator_id int(11) not null,
	foreign key (user_id) references users(id)
);
	
drop table if exists answers_by_users;
create table answers_by_users (
	id int(11) serial primary key,
	answer_id int(11) not null,
	user_text varchar(4095) default null,
	int_number int(11) default null,
	float_number float(11) default null,
	user_id int(11) not null,
	time_created datetime(6) default now(),
	foreign key (answer_id) references answers(id),
	foreign key (user_id) references users(id),
	index answer_type_idx(answer_type)
);		

drop table if exists currentstates;
create table currentstates (
	id int(11) serial primary key,
	poll_queue longtext,
	poll_id int(11) not null,
	screen_id int(11) not null,
	question_id int(11) not null,
	user_id int(11) not null,
	time_poll_started datetime(6) default now(),
	time_poll_finished datetime(6) default null on update current_timestamp,
	screens_queue json not null,
	foreign key (poll_id) references polls(id),
	foreign key (screen_id) references screens(id),
	foreign key (question_id) references questions(id),
	foreign key (user_id) references users(id)
);

drop table if exists points_transactions;
create table points_transactions (
	id int(11) serial primary key,
	user_id int(11),
	category varchar(50),
	points int(11) unsigned not null,
	time_created datetime(6) default now(),
	reason varchar(255) default null,
	parent_transaction_id int(11) unique default null,
	foreign key (user_id) references users(id),
	foreign key (parent_transaction_id) references points_transactions(id),
	foreign key (currentstate_id) references currentstates(id),
	index category_idx(category),
	index currentstate_idx(currentstate_id)
);

drop table if exists invite_statuses;
create table invite_statuses (
	id int serial,
	name varchar(20) unique not null,
	description varchar(255) not null,
	primary key status_name_idx(name)
);	

insert into invite_statuses (id, name, description) values
(1, "invitation_sent", "Приглашение выслано."),
(2, "invitation_accepted", "Приглашение принято.");

drop table if exists invites;
create table invites (
	id int(11) serial,
	status_id int(11) not null,
	user_id int(11) not null,
	reward_transaction_id int(11) default null,
	reward_allowed tinyint(1) default 0,
	time_created datetime(6) default now(),
	time_updated datetime(6) default null on update current_timestamp,
	foreign key (status_id) references invite_statuses(id),
	foreign key (user_id) references users(id),
	foreign key (reward_transaction_id) references points_transactions(id),
	index status_idx(status_id)
);


/*
процедуры и тригеры
может быть, обновлять среднее время прохождения опроса во вкладке duration
или обновлять число успешных интервью у опроса (только добавить это поле)
обновлять в таблице юзеров число пройденных опросов
помечать в таблице юзеров из_баннед тру или фолс при инсерте или делите в таблице банс
обновлять таблицу с инвайтами если есть транзакция за инвайт

вьюха (например, отображение всех активных опросов)
название, описание, длительность, число зашедших пользователей, число успешных, число неуспешных

вьюха
транзакции с баллами по годам/месяцам


