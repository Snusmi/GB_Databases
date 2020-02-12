/*
Практическое задание по теме “Введение в проектирование БД”
Написать cкрипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)
*/


DROP TABLE IF EXISTS video_albums;
CREATE TABLE video_albums (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED DEFAULT NULL,
    name varchar(100) DEFAULT NULL,
	description varchar(255) DEFAULT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS videos;
CREATE TABLE videos (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES video_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS documents;
CREATE TABLE documents(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
    `type` ENUM('gif', 'image', 'video'),
    filename VARCHAR(255),
    size INT,
    privacy ENUM('private', 'educational', 'book','other'),
	tags JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (filename, `type`),
    FOREIGN KEY (user_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS music;
CREATE TABLE music (
	id SERIAL PRIMARY KEY,
	`media_id` BIGINT unsigned NOT NULL,
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(150),
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX playlist_name_idx(name),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users_playlists;
CREATE TABLE users_playlists(
	user_id BIGINT UNSIGNED NOT NULL,
	playlist_id BIGINT UNSIGNED NOT NULL,
	song_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, playlist_id, song_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (song_id) REFERENCES music(id)
);