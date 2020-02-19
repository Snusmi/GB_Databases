DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамиль',
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname)
);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('1', 'Reuben', 'Nienow', 'arlo50@example.org', '9374071116');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('2', 'Frederik', 'Upton', 'terrence.cartwright@example.org', '9127498182');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('3', 'Unique', 'Windler', 'rupert55@example.org', '9921090703');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('4', 'Norene', 'West', 'rebekah29@example.net', '9592139196');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('5', 'Frederick', 'Effertz', 'von.bridget@example.net', '9909791725');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('6', 'Victoria', 'Medhurst', 'sstehr@example.net', '9456642385');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('7', 'Austyn', 'Braun', 'itzel.beahan@example.com', '9448906606');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('8', 'Jaida', 'Kilback', 'johnathan.wisozk@example.com', '9290679311');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('9', 'Mireya', 'Orn', 'missouri87@example.org', '9228624339');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('10', 'Jordyn', 'Jerde', 'edach@example.com', '9443126821');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('11', 'Thad', 'McDermott', 'shaun.ferry@example.org', '9840726982');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('12', 'Aiden', 'Runolfsdottir', 'doug57@example.net', '9260442904');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('13', 'Bernadette', 'Haag', 'lhoeger@example.net', '9984574866');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('14', 'Dedric', 'Stanton', 'tconsidine@example.org', '9499932439');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`) VALUES ('15', 'Clare', 'Wolff', 'effertz.laverna@example.org', '9251665331');


DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);
INSERT INTO `messages` VALUES 
('1','1','3','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29'),
('2','2','14','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.',now()),
('3','3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.','1993-09-14 19:45:58'),
('4','4','12','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.','1985-11-25 16:56:25'),
('5','5','11','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','1999-09-19 04:35:46'),
('6','6','10','Rerum labore culpa et laboriosam eum totam. Quidem pariatur sit alias. Atque doloribus ratione eum rem dolor vitae saepe.','1973-11-09 08:12:04'),
('7','7','9','Perspiciatis temporibus doloribus debitis. Et inventore labore eos modi. Quo temporibus corporis minus. Accusamus aspernatur nihil nobis placeat molestiae et commodi eaque.','1998-04-09 00:00:26'),
('8','8','8','Suscipit dolore voluptas et sit vero et sint. Rem ut ratione voluptatum assumenda nesciunt ea. Quas qui qui atque ut. Similique et praesentium non voluptate iure. Eum aperiam officia quia dolorem.','2005-08-20 18:40:27'),
('9','9','7','Et quia libero aut vitae minus. Rerum a blanditiis debitis sit nam. Veniam quasi aut autem ratione dolorem. Sunt quo similique dolorem odit totam sint sed.','2013-03-19 04:10:10'),
('10','10','6','Praesentium molestias quia aut odio. Est quis eius ut animi optio molestiae. Amet tempore sequi blanditiis in est.','1976-05-22 14:38:15'),
('11','11','5','Molestiae laudantium quibusdam porro est alias placeat assumenda. Ut consequatur rerum officiis exercitationem eveniet. Qui eum maxime sed in.','1996-04-27 00:23:37'),
('12','12','4','Quo asperiores et id veritatis placeat. Aperiam ut sit exercitationem iste vel nisi fugit quia. Suscipit labore error ducimus quaerat distinctio quae quasi.','1989-05-13 22:39:47'),
('13','13','3','Earum sunt quia sed harum modi accusamus. Quia dolor laboriosam asperiores aliquam quia. Sint id quasi et cumque qui minima ut quo. Autem sed laudantium officiis sit sit.','1997-09-30 00:06:14'),
('14','14','2','Aut enim sint voluptas saepe. Ut tenetur quos rem earum sint inventore fugiat. Eaque recusandae similique earum laborum.','1977-10-15 23:26:40'),
('15','15','1','Nisi rerum officiis officiis aut ad voluptates autem. Dolor nesciunt eum qui eos dignissimos culpa iste. Atque qui vitae quos odit inventore eum. Quam et voluptas quia amet.','1977-10-13 19:40:32'),
('16','1','3','Consequatur ut et repellat non voluptatem nihil veritatis. Vel deleniti omnis et consequuntur. Et doloribus reprehenderit sed earum quas velit labore.','1998-05-24 10:09:36'),
('17','2','4','Iste deserunt in et et. Corrupti rerum a veritatis harum. Ratione consequatur est ut deserunt dolores.','1993-01-30 15:51:38'),
('18','3','1','Dicta non inventore autem incidunt accusamus amet distinctio. Aut laborum nam ab maxime. Maxime minima blanditiis et neque. Et laboriosam qui at deserunt magnam.','1996-05-19 14:18:39'),
('19','4','2','Amet ad dolorum distinctio excepturi possimus quia. Adipisci veniam porro ipsum ipsum tempora est blanditiis. Magni ut quia eius qui.','1998-08-12 04:42:34'),
('20','5','1','Porro aperiam voluptate quo eos nobis. Qui blanditiis cum id eos. Est sit reprehenderit consequatur eum corporis. Molestias quia quo sit architecto aut.','2013-11-01 05:14:05'),
('21','6','10','Architecto sunt asperiores modi. A commodi non qui.','2007-10-22 01:34:17'),
('22','7','9','Minus praesentium ipsum iusto ipsum et a nobis. Aut distinctio enim dolor suscipit et. Quia culpa molestiae architecto quod. Error nulla qui et harum sapiente maxime qui sed.','1986-07-17 11:23:56'),
('23','8','8','Explicabo nostrum eius cum molestiae. Et deserunt aut consectetur molestiae. Illo veritatis sed ab.','2002-06-22 15:10:59'),
('24','9','7','Excepturi consequatur ducimus voluptatum. Est sed perferendis ducimus officia et. Qui nemo sapiente harum rerum.','2007-09-14 22:06:16'),
('25','10','6','Non deserunt quis non illum. In vel exercitationem dolore reiciendis non animi sequi cumque. Officia et repellat in aut voluptas. Dignissimos sed voluptatem minima eligendi. Magnam porro omnis mollitia aspernatur error quia.','2006-06-16 19:28:59'),
('26','1','3','Minus tenetur molestiae laudantium est voluptatem tempora. Sed ab veniam porro similique cumque. Accusamus illo est et tempora excepturi odit.','1977-11-04 08:02:22'),
('27','2','4','At ratione quae facere minima exercitationem vel ipsum ipsam. Qui eligendi repellat ut unde quos hic sit. Itaque expedita voluptatem id numquam. Provident culpa expedita alias optio ipsum id. Voluptatum quae quidem nihil aut nemo voluptatibus.','1975-06-25 22:37:18'),
('28','3','1','Nam dignissimos nobis qui qui voluptate. Dolor voluptas praesentium quis tenetur deleniti dolorem incidunt. Cupiditate qui nam excepturi.','2007-03-22 10:13:05'),
('29','4','8','Molestias ratione tenetur sint. Vel rerum voluptas vel vitae et aut non autem. Distinctio sunt in dignissimos esse eligendi praesentium. Ut totam autem vel sapiente architecto et.','2003-01-11 19:37:45'),
('30','5','10','Perferendis in eius architecto debitis exercitationem. Optio deleniti ad dolor sapiente soluta. Quisquam deserunt autem amet magni quasi quo dolores. Expedita ea omnis omnis sint.','2010-04-13 15:06:20'),
('31','6','1','Voluptatum totam inventore numquam dolor mollitia. Qui explicabo ut commodi culpa libero quisquam. Doloribus consequuntur rerum in nesciunt quia consequuntur ut.','2009-02-23 05:02:06'),
('32','7','3','Delectus animi laboriosam magnam. Dolor a qui numquam et. Magnam rerum exercitationem officiis numquam.','2017-06-21 05:19:41'),
('33','8','5','Blanditiis incidunt fugiat itaque animi impedit modi ratione at. Excepturi vel hic enim quidem aut ullam facilis. Ipsum aut maxime deserunt doloremque.','1996-01-15 13:05:37'),
('34','9','7','Quia magnam reprehenderit libero fugiat. Voluptatem id qui incidunt nihil et voluptatem quos dicta. Corrupti et ut ratione quos architecto omnis. Accusamus quo aliquam hic sit quia illum.','1987-01-09 11:35:59'),
('35','10','9','Voluptatem aperiam omnis ut sed nulla. Autem optio eligendi et corrupti.','1980-07-24 15:48:57'),
('36','1','10','Omnis dolor dignissimos vel tempora. Quia explicabo iste tempora delectus esse. Laudantium molestiae recusandae laboriosam quam.','2007-01-31 14:18:23'),
('37','2','9','Nesciunt vitae consequuntur et molestiae deleniti cupiditate nostrum. Et natus eveniet officiis voluptas voluptas magni velit. Explicabo ipsam et quis eos dolore explicabo.','1971-09-15 21:08:26'),
('38','3','1','Atque deleniti voluptas labore veniam quas ipsam voluptatem. Similique facere qui est quaerat est et. Incidunt corporis aut deleniti aut excepturi.','1991-12-06 22:30:58'),
('39','4','7','Placeat eos est animi voluptatem quas dolore. Dolor minima rem corporis perspiciatis. Nemo est autem voluptate est.','2004-10-09 10:37:23'),
('40','5','6','Ab quibusdam dolor et illum quis dolore. Qui deserunt consequuntur voluptatem itaque. Expedita sit velit hic repudiandae provident culpa quisquam. Est aut rerum itaque in non et.','1972-03-14 21:06:39'),
('41','6','5','Quasi porro esse voluptate aut quia quo cupiditate. Nihil dolorem neque ut est quibusdam. Eius labore quidem rerum animi eligendi sapiente. Quo dolor voluptates fugit sed eos ipsam illo quia.','2017-04-22 21:50:21'),
('42','7','4','Similique accusantium voluptatem perferendis dignissimos et inventore qui. Est aspernatur et voluptas occaecati officiis dolores numquam. Ut amet quas natus voluptatibus.','2001-11-06 03:19:29'),
('43','8','3','Nostrum aspernatur enim cum iure ut neque similique ut. Labore repudiandae eum inventore est consequatur. Non sed ea incidunt laboriosam ea itaque porro. Esse culpa id explicabo odio consequatur unde voluptatum.','1997-02-17 15:31:00'),
('44','9','2','Magni ex dolor enim assumenda sit modi molestiae. Est quis aliquam ut id aliquam eveniet est. Fuga quaerat neque tenetur. Nihil reprehenderit necessitatibus ut quo nam excepturi.','1998-06-20 05:03:15'),
('45','10','1','Quaerat eum sequi consequatur perferendis in libero. Nulla facilis sed facere natus. Harum aut incidunt quia harum aut beatae aspernatur. Perferendis dolor et ut corporis blanditiis.','2004-04-20 20:20:36'),
('46','1','9','Expedita quia similique praesentium placeat. Harum omnis perspiciatis occaecati odio. Enim consequatur sequi ut hic deserunt odit quos.','2005-06-30 22:41:30'),
('47','2','7','Cum reiciendis neque unde reprehenderit totam laborum porro. Voluptas sed eveniet voluptas. Qui sed consequatur exercitationem quis. Nihil velit possimus magnam cumque dolore cum nemo.','1973-09-27 23:29:10'),
('48','3','5','Dolorum dignissimos ipsa tempore enim. Aliquam ex labore exercitationem odio id dignissimos eaque. Aperiam cupiditate alias ut rerum asperiores et.','1986-05-03 10:04:03'),
('49','4','3','Molestiae omnis magnam labore quidem omnis doloribus delectus. Aut a ut velit quos. Quae est omnis vel omnis omnis aut distinctio aperiam. Numquam nulla quo qui quis.','1970-08-09 14:37:59'),
('50','5','1','Dolorem necessitatibus ullam cumque quo assumenda alias. Molestias quibusdam earum commodi placeat. Saepe voluptatem voluptatem aut.','1976-06-06 22:03:25'),
('51','6','2','Tenetur aut nobis pariatur et accusamus est eos deserunt. Non quia ratione aspernatur. Perspiciatis doloremque adipisci qui et animi. Aut quis in non.','1992-04-30 20:58:57'),
('52','7','4','Animi et et incidunt ea sequi eaque quia. Quia laudantium est necessitatibus natus qui velit impedit vitae. Dolorum vitae eius tempore et magnam.','1973-03-10 13:48:51'),
('53','8','6','Enim in minima dolores possimus odio quia. Officia qui quis laudantium ea dolor omnis. Dolores nihil optio exercitationem optio nihil exercitationem laboriosam est. Enim quasi qui dolorem sit tempora labore laboriosam.','1982-11-18 08:42:29'),
('54','9','8','Quam tempora accusantium ullam doloribus eveniet ut. Qui dolores ut et. Molestiae velit dolorem vel similique neque.','1995-03-14 17:47:23'),
('55','10','10','Dolore molestias aut sit cum. Libero tempora laboriosam mollitia saepe. Ipsa voluptatum itaque sequi dolorem. Ipsam sint sequi perferendis odio amet dicta optio fugit.','1999-07-08 10:32:41'),
('56','1','2','Inventore facere perferendis nostrum est. Aut eos laborum iusto itaque tenetur. Dicta nihil maxime necessitatibus ut nihil. Enim ab et quo aperiam.','2008-10-15 17:57:56'),
('57','2','3','Voluptates consequatur et et necessitatibus soluta et. Reiciendis saepe debitis placeat autem. Aperiam soluta et commodi sint consectetur.','1974-01-30 16:15:55'),
('58','3','1','Libero eos incidunt ipsum omnis sit quisquam dolores doloribus. Doloremque nobis repellat sit vel totam molestias. Minus quasi qui labore tenetur molestiae est assumenda.','1979-10-08 08:07:50'),
('59','4','5','Tempore vero voluptatem mollitia qui suscipit iusto suscipit. Aut consectetur accusamus provident consequatur officiis. Amet fugit voluptatibus dolorem reiciendis voluptatem cupiditate quia.','1994-08-20 09:12:31'),
('60','5','6','Quia sequi animi repellat. Consequatur ad soluta consequatur quo. Molestias suscipit et placeat non officiis rerum et. Voluptatibus ea veniam architecto labore aut corporis qui.','1974-04-18 22:45:58'),
('61','6','7','Aut ab numquam non commodi aut. Assumenda adipisci hic tenetur. Possimus delectus dicta ab id dolores.','1987-10-17 16:11:13'),
('62','7','8','Eos amet ut qui tempora saepe totam. Velit ut quis ut quia. Est id eos et commodi nihil. Rerum saepe quia consequatur laborum delectus suscipit velit.','2012-11-25 07:00:39'),
('63','8','9','Eligendi qui iusto non. Rerum amet aut tempore expedita ut assumenda perspiciatis. Id ut nemo quis. Sit quia repellendus et minus.','2005-02-27 23:18:23'),
('64','9','10','Consectetur ad nihil tenetur iusto. Possimus qui quibusdam id ut. Sunt molestias quidem quisquam eligendi natus. Assumenda magnam laborum harum nemo qui nisi.','1998-10-18 18:46:37'),
('65','10','1','Alias voluptatem odit aliquid possimus id est. Aliquid excepturi soluta deserunt vel quidem voluptatem ipsam. Natus ex quis neque unde est. Molestias possimus sint quos sed quo.','1988-05-14 20:25:46'),
('66','1','3','Temporibus voluptates ipsa placeat est dolorum. Mollitia aut laboriosam consequuntur amet asperiores maxime aspernatur distinctio. Incidunt est voluptatem ipsam provident optio dignissimos praesentium. Dolores quis laudantium ut beatae voluptas blanditiis est.','1988-03-02 21:17:37'),
('67','2','4','Minus necessitatibus voluptate molestiae eius. Illo consequatur aliquam dolore fugit nemo est beatae beatae.','2001-09-08 17:21:02'),
('68','3','5','Et aut libero odit id. Occaecati doloribus et quam excepturi eveniet esse.','1990-05-02 19:23:36'),
('69','4','6','Rerum qui deleniti et dolorum quae. Voluptates repudiandae aliquid at repellat. At delectus rerum aut qui qui. Accusantium suscipit blanditiis aut tenetur quae et ut. Fugit dolorem veritatis quam corrupti odio sint voluptatem impedit.','1992-11-20 08:57:16'),
('70','5','7','Occaecati et quisquam fugit a. Et repellendus alias quam incidunt ut tempora. Deserunt temporibus aut saepe eius excepturi.','1970-08-11 21:33:29'),
('71','6','8','Sint quo natus ut odit corrupti laboriosam iure molestias. Quod repudiandae consequuntur quas et dolore expedita. Iste dolorem eius officiis. Deleniti magni iusto autem vero.','2005-10-16 03:28:41'),
('72','7','9','Aperiam nobis odit omnis culpa. Ex esse tempora et error. Animi doloribus ut dolores dolorum quos facilis. Vel cupiditate sint cum est et. Quasi quo aut et consequatur repellat odit ut.','1988-02-29 05:32:01'),
('73','8','10','Incidunt exercitationem qui amet explicabo natus ipsam repudiandae. Quod fugiat dolor qui eum sit est. Magni eum odit et eos consequatur id.','2010-04-18 01:08:09'),
('74','9','1','Ipsam debitis eligendi labore error minima inventore quia. Minus et minima ut. Consequatur consectetur corporis et laborum impedit.','1985-10-05 19:13:28'),
('75','10','2','Explicabo tenetur illo sint corporis dolore. Vitae quos quia qui hic natus deserunt facere sit. Molestiae enim animi libero qui. Quis accusamus itaque quas qui cumque qui.','2012-03-29 11:54:19'),
('76','1','3','Ut placeat ad ab tempore. Temporibus itaque distinctio hic laboriosam eum asperiores quibusdam placeat. Aut sit ut est perspiciatis beatae omnis. Ad et aperiam dolorem voluptatem molestiae quia eos.','1986-03-25 09:53:35'),
('77','2','5','Nesciunt animi voluptatum eveniet voluptatem perferendis vel. Dolorem dolor nihil doloremque sed ut. Unde ea et numquam tenetur modi eos qui. Fuga est sapiente omnis omnis.','1972-04-24 19:27:51'),
('78','3','1','Recusandae laudantium debitis modi perspiciatis mollitia aliquid saepe culpa. In molestiae dolore nesciunt. Sint dolorem velit aliquid saepe dolorum iure voluptatem.','2014-07-19 03:46:12'),
('79','4','7','Et aut earum aut dolores enim sequi. Quo cumque dolorum eos qui vel expedita quo. Est libero labore et tempore. Temporibus deleniti ipsa ea ea possimus accusamus maxime.','1984-10-24 22:39:24'),
('80','5','8','Voluptas nemo aliquam pariatur sequi dolorem officia molestiae. Cupiditate ut ab necessitatibus odio suscipit quo.','1991-05-25 00:05:39'),
('81','6','9','Occaecati possimus ipsum velit dolorum in ipsam. Hic laudantium eligendi pariatur deserunt molestias. Esse doloribus nemo odio aperiam illum.','1992-06-19 09:18:21'),
('82','7','10','Aut quas animi sed quis. Autem explicabo totam accusamus. Sapiente in sunt in dolores. Totam est repellendus voluptas.','1990-08-26 13:57:28'),
('83','8','1','Harum non ea incidunt accusamus fugit voluptatibus. Totam voluptatibus inventore dolorum odit.','2017-08-01 23:04:18'),
('84','9','2','Consequuntur atque ut officiis est laudantium sapiente quia. Ut atque at corrupti autem. Consequatur repudiandae consequatur ut eligendi ipsam eum vero.','1984-08-20 04:11:47'),
('85','10','3','Explicabo fugit consequatur non. Ex qui culpa amet. Accusamus consequatur sed quia qui nihil quia.','1998-08-07 18:07:35'),
('86','1','5','Aut vero dolore hic et reiciendis omnis. Nesciunt quis aut odit quam. Reprehenderit omnis molestiae ipsa vero laboriosam totam consectetur cumque. Facere et qui dolore ut architecto reprehenderit.','1989-05-22 06:13:52'),
('87','2','6','Qui omnis a assumenda tempora assumenda. Consequatur nihil dolorem veritatis qui dolores vel.','2010-08-08 17:23:39'),
('88','3','7','Consequatur repudiandae voluptas ex ea. Commodi non officiis culpa quos. Eum id sed voluptatibus.','2011-03-01 02:20:15'),
('89','4','8','Velit tenetur qui ratione dolore non. Ad omnis totam aliquid quos.','2008-01-26 14:29:48'),
('90','5','9','Beatae et adipisci dolorem. Consequatur ut tenetur nulla dolor corporis vero.','1996-07-08 15:22:44'),
('91','6','10','Quia est natus assumenda explicabo fugit atque. Ea sit maiores quod repellendus molestiae. Qui consectetur qui aut ipsa corporis dolore architecto corporis.','2015-12-29 19:09:22'),
('92','7','1','Ipsa sunt voluptatem animi optio qui. Eum autem quam et accusantium fuga autem voluptatem. Laborum illum dignissimos ut et qui sed. Est hic nesciunt quo iusto dolor soluta maxime.','2014-11-15 17:19:35'),
('93','8','2','Doloribus aliquid incidunt et architecto ipsa est sapiente. In nesciunt quia et quo expedita. Possimus qui voluptatum fuga eum ut.','1979-10-07 18:50:35'),
('94','9','3','Qui deleniti omnis officiis. Maiores ducimus quisquam inventore iusto totam est deserunt voluptates. Quasi reprehenderit excepturi vel aut ullam.','1983-09-13 00:31:43'),
('95','10','4','Est voluptatem voluptas ut asperiores expedita voluptatem. Recusandae reiciendis eos magnam fugit placeat blanditiis illo. Aliquam quis officia repellat consequatur aut consequatur voluptas.','1975-09-22 08:07:45'),
('96','1','3','Non sunt maxime nisi impedit dolores. Aliquid vero et facilis a. Non maiores quos dolores saepe similique maxime.','1988-12-01 15:08:45'),
('97','2','4','Tempore aliquid aut ipsa. Ea sunt modi non ducimus eum sed ea. Sint aliquid nihil ipsam est cumque velit earum. Voluptas qui inventore eius et facere placeat nemo.','1992-04-14 11:30:54'),
('98','3','1','Quasi velit non fugiat. Neque porro molestiae est et architecto. Voluptatem ipsa in beatae nihil voluptatem quidem. Minus est in autem saepe.','1999-11-20 22:33:47'),
('99','4','2','Maiores ut accusantium rerum. Expedita consequuntur et placeat vero ea eligendi et eum. Et distinctio at beatae quis ut ut rerum. In repellat corrupti adipisci quaerat repellat quas illo.','1990-06-30 05:56:22'),
('100','5','1','Molestiae molestiae non doloribus temporibus minima. Eaque sapiente ex assumenda. Eveniet dolorum iure qui mollitia repudiandae vel. Labore quos qui necessitatibus.','1991-05-20 07:06:14'); 

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL PRIMARY KEY, -- changed to combined primary key (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    -- `status` TINYINT UNSIGNED,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
	INDEX (initiator_user_id),
    INDEX (target_user_id),
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '15', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '14', 'requested', '1987-10-10 07:33:23', '1983-01-18 01:56:05');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('3', '13', 'approved', '2015-02-07 01:53:07', '2015-09-14 16:17:12');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '12', 'approved', '1983-04-08 15:57:26', '1976-12-28 23:54:58');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('5', '11', 'unfriended', '1976-03-03 18:22:00', '1996-12-03 11:29:04');

INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('7', '9', 'requested', '1989-10-26 06:20:23', '2001-08-05 16:01:03');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '8', 'unfriended', '1987-12-30 01:50:03', '2001-07-09 07:39:50');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '7', 'requested', '2003-12-27 22:52:09', '1998-04-18 04:41:46');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('10', '6', 'declined', '1970-05-08 00:32:15', '2007-03-22 21:08:16');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('11', '5', 'approved', '1988-05-02 10:55:41', '1985-02-09 05:04:27');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('12', '4', 'unfriended', '1975-07-25 20:11:02', '1993-06-30 12:51:09');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('13', '3', 'declined', '2000-06-24 13:17:54', '1982-04-16 16:12:48');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('14', '2', 'declined', '2007-12-09 17:17:48', '1991-05-31 12:38:33');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('15', '1', 'unfriended', '2016-07-21 20:48:02', '1982-10-06 14:54:41');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '2', 'requested', '1992-10-04 04:16:38', '2001-01-24 13:54:16');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '3', 'approved', '1984-11-20 10:33:06', '2018-10-07 19:43:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('3', '4', 'approved', '1992-07-31 16:34:16', '2008-08-03 10:13:44');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '5', 'requested', '1993-06-18 14:21:32', '1976-01-16 15:57:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('5', '6', 'declined', '2007-03-22 18:13:14', '2010-01-06 00:06:18');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('6', '7', 'requested', '2015-09-17 12:10:37', '1986-06-30 22:29:41');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('7', '8', 'approved', '2004-09-21 23:23:19', '2003-01-27 16:11:05');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '9', 'requested', '1972-04-26 20:13:41', '1991-01-03 06:58:39');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '10', 'unfriended', '2017-08-08 05:38:20', '2007-09-27 03:07:27');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('10', '1', 'approved', '2001-01-16 08:07:31', '1995-04-25 06:23:27');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '3', 'approved', '2004-07-31 10:12:37', '2001-06-28 18:49:10');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '4', 'declined', '2004-11-01 19:13:46', '1978-05-16 19:08:26');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('3', '5', 'requested', '1989-07-10 17:02:49', '2007-03-16 20:42:05');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '6', 'unfriended', '1984-08-12 11:38:13', '1971-07-07 10:40:59');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('5', '7', 'unfriended', '1997-03-01 23:22:31', '1974-08-30 23:16:26');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('6', '8', 'approved', '2003-02-19 05:45:39', '2015-02-04 15:26:16');

INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '10', 'requested', '2018-08-15 10:50:34', '1984-08-24 14:00:01');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '1', 'unfriended', '1988-06-12 03:29:45', '1998-11-28 12:07:32');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('10', '2', 'unfriended', '1988-01-30 09:10:41', '2004-06-02 14:04:53');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '4', 'declined', '1993-03-10 12:19:15', '2007-05-17 03:24:16');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '5', 'requested', '1999-06-21 09:26:23', '2011-08-28 05:29:49');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('3', '6', 'requested', '1977-03-14 20:26:41', '1975-09-03 17:01:54');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '7', 'approved', '2017-09-08 20:11:20', '1989-12-10 18:38:58');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('5', '8', 'approved', '2001-08-16 04:34:33', '1999-01-01 14:33:52');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('6', '9', 'unfriended', '1982-07-18 15:48:44', '1989-10-14 05:48:07');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('7', '10', 'requested', '1973-10-29 10:38:00', '1973-11-02 18:26:40');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '1', 'requested', '1979-12-17 11:27:04', '2004-09-28 04:54:42');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '2', 'approved', '2013-10-01 07:28:04', '2006-12-12 05:43:06');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('10', '3', 'requested', '2011-07-27 12:46:23', '1988-05-07 21:59:11');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '5', 'declined', '1999-11-13 00:33:38', '2016-05-02 19:19:15');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '6', 'approved', '1980-03-02 03:50:22', '2010-09-22 18:58:47');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('3', '7', 'requested', '2003-11-15 23:04:36', '1991-08-05 16:56:51');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '8', 'approved', '2006-03-24 23:01:39', '2010-08-04 15:00:32');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('5', '9', 'approved', '2008-07-18 00:34:41', '2016-12-25 03:18:49');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('6', '10', 'approved', '2001-10-14 18:49:19', '2012-06-08 01:36:28');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('7', '1', 'requested', '2000-06-08 04:08:36', '2010-10-12 10:27:39');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '2', 'approved', '1972-07-01 10:35:33', '1972-03-03 01:26:27');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '3', 'declined', '2007-07-24 20:49:26', '2014-03-10 04:56:59');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('10', '4', 'approved', '1981-09-25 09:50:15', '1991-04-22 04:24:22');


DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
    INDEX communities_name_idx(name)
);
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (2,'atque'),(1,'beatae'),(9,'est'),(5,'eum'),(7,'hic'),(6,'nemo'),(8,'quis'),(4,'rerum'),(10,'tempora'),(3,'voluptas');
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('1', '1');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('1', '2');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('1', '3');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('2', '4');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('2', '5');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('6', '6');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('7', '7');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('8', '8');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('9', '9');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('10', '10');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('11', '1');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('12', '2');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('13', '3');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('14', '4');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('15', '5');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('1', '6');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('2', '7');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('3', '8');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('4', '9');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('5', '10');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('6', '1');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('7', '2');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('8', '3');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('9', '4');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('10', '5');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('11', '6');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('12', '7');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('13', '8');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('14', '9');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('15', '10');

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW()
);
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES 
	(1,'Photo','2003-07-09 10:08:05'),
	(2,'Music','2009-06-19 20:08:09'),
	(3,'Video','1984-04-18 01:55:09'),
	(4,'Post','2001-04-17 06:47:52');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(1,1,'Est aut aliquid est. Soluta eveniet doloribus ipsam ut id assumenda quam. Consequuntur et velit aperiam error corporis rem corporis. Est similique quisquam quia maxime eaque possimus facere officiis. Odio magni atque dicta voluptatibus hic iste delectus.','a.jpg',5,NULL,'1991-11-16 08:14:38.000','2019-06-19 18:11:58.000')
,(2,2,'Laborum dolorem magni unde vero sit hic. Pariatur quia voluptas magnam. Blanditiis dolorem et molestias veniam facere provident.','asperiores.jpg',4510,NULL,'1986-12-10 19:34:26.000','2019-06-19 18:11:58.000')
,(1,3,'A quam ea ullam reiciendis vel et reiciendis. Delectus iure mollitia est. Eum dolores dolores sed officia vitae qui. Sed repudiandae voluptatem voluptatibus libero culpa quo.','sapiente.jpg',763116,NULL,'1978-09-18 17:07:49.000','2019-06-19 18:11:58.000')
,(4,4,'Velit commodi in veniam occaecati. Tenetur temporibus ullam enim officiis aut illum. In maiores velit nobis soluta molestias maiores tempora. Quisquam et ut et sequi.','rerum.jpg',740,NULL,'1984-10-21 04:41:15.000','2019-06-19 18:11:58.000')
,(1,5,'Est eaque est qui et omnis rerum. Expedita porro nesciunt inventore consequatur quos. Inventore aut rerum voluptas. Dicta vel ut quibusdam cupiditate tempore.','user5-profile-image.jpg',40813,NULL,'2014-06-20 03:34:11.000','2019-06-19 18:11:58.000')
,(2,6,'Atque et nam nulla et aliquid. Vel repellendus aut natus odit quibusdam quis atque et. Laudantium minima velit dolores eos voluptate nostrum.','quasi.jpg',119422,NULL,'1991-11-02 07:50:45.000','2019-06-19 18:11:58.000')
,(3,7,'Nihil ut et reprehenderit et. Numquam veniam quis impedit. Voluptas saepe rerum illo vel omnis. Aliquam illum ut quo saepe ea unde est.','non.jpg',704558,NULL,'1988-09-17 20:56:38.000','2019-06-19 18:11:58.000')
,(4,8,'Sint quod fugit molestiae dolore repellendus est. Quis corporis necessitatibus commodi placeat temporibus doloremque voluptatem. Nemo maxime sit dolorem perferendis repellat. Et impedit deleniti eaque pariatur ut quia voluptatibus.','earum.jpg',65108,NULL,'1995-10-07 10:19:53.000','2019-06-19 18:11:58.000')
,(1,9,'Optio sed aperiam veniam eum. Rerum placeat soluta iusto perspiciatis quibusdam dolorem eos. Ea pariatur optio est ut.','ullam.jpg',83717449,NULL,'2003-08-05 05:55:25.000','2019-06-19 18:11:58.000')
,(2,10,'Facere nostrum facilis aperiam quisquam dolor. Minima omnis est nam.','maiores.jpg',75,NULL,'1984-05-17 07:37:30.000','2019-06-19 18:11:58.000')
;
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(3,1,'A omnis ratione non. Et velit sed incidunt corporis ut rerum nemo. Ut pariatur tempora ea incidunt praesentium ut. Eligendi et et rerum sequi ut.','non.jpg',0,NULL,'2010-05-07 19:13:09.000','2019-06-19 18:11:58.000')
,(4,1,'Quo minus harum debitis debitis quis sunt. Dolores suscipit placeat dolorum non voluptate et. Non eos odio esse tempore. Illum minus quidem temporibus porro.','earum.jpg',1826766,NULL,'2013-08-25 22:49:45.000','2019-06-19 18:11:58.000')
,(1,1,'Et aliquid sit natus vitae fuga enim repudiandae. Quis ab et debitis est accusantium labore. Exercitationem delectus eaque necessitatibus.','hic.jpg',979,NULL,'2015-11-02 00:11:31.000','2019-06-19 18:11:58.000')
,(2,1,'Nobis est sed blanditiis assumenda incidunt explicabo. Facere rem assumenda odio explicabo ad enim repellat quia. Dolor mollitia fugiat officia nihil animi.','iste.jpg',18,NULL,'2006-05-11 12:11:06.000','2019-06-19 18:11:58.000')
,(3,1,'Tempora ad et aspernatur laborum ut dolor et. Exercitationem quaerat corporis placeat et.','quia.jpg',7,NULL,'2000-03-29 04:01:57.000','2019-06-19 18:11:58.000')
,(4,1,'Accusantium est ea fuga omnis mollitia. Dolores officia et consequatur iste est quo. Ullam laborum qui ut quo delectus temporibus.','omnis.jpg',2058670,NULL,'1971-10-08 06:43:32.000','2019-06-19 18:11:58.000')
,(1,1,'Quasi itaque atque ut aliquam debitis. Qui consequuntur maiores sit ad perspiciatis quaerat assumenda repudiandae. Necessitatibus placeat quaerat aut voluptatem ratione voluptate expedita. Nulla doloremque aut molestiae nam.','aperiam.jpg',3489253,NULL,'1973-12-19 09:20:43.000','2019-06-19 18:11:58.000')
,(2,1,'Deserunt voluptatem quia voluptatem sit. Qui omnis distinctio optio voluptatem veniam atque dolorem. Repellat laboriosam illo consequatur nesciunt voluptas magni rerum. Saepe quos qui doloremque.','commodi.jpg',8,NULL,'1989-03-01 17:19:42.000','2019-06-19 18:11:58.000')
,(3,1,'Fugiat consequuntur voluptatem odit omnis. Quia aut voluptate officia rerum. Cumque voluptatem eaque dolorum voluptas sed. Et autem atque est minus veritatis explicabo eos.','id.jpg',1,NULL,'1970-11-04 03:06:33.000','2019-06-19 18:11:58.000')
,(4,2,'Autem dolore beatae aut corporis fugit ratione. Ex beatae qui at. Est deleniti asperiores temporibus perferendis est.','fugiat.jpg',82,NULL,'2017-06-08 03:23:04.000','2019-06-19 18:11:58.000')
;
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(1,11,'Provident eligendi animi quidem qui ipsum. Accusamus dolor sint est qui magnam. Omnis enim quis dolore magni facilis repudiandae deserunt. Consequatur eum at recusandae id tenetur voluptas amet.','ipsa.jpg',1,NULL,'1986-12-30 23:42:20.000','2019-06-19 18:11:58.000')
,(2,12,'Animi ut labore dolore atque consequuntur maxime fugit. Sunt et et facere sint. Recusandae numquam accusamus a. Non quia dolorem reiciendis earum et officiis iure.','adipisci.jpg',4582,NULL,'2017-07-19 09:44:31.000','2019-06-19 18:11:58.000')
,(3,13,'Sint officiis a ipsa quaerat rerum ea totam. Aut perferendis deleniti error ipsa ducimus ipsam. Ipsum a sunt quis placeat.','qui.jpg',8302441,NULL,'1985-01-28 13:54:18.000','2019-06-19 18:11:58.000')
,(4,14,'Et accusamus a et adipisci dolore. Blanditiis sit vitae dolorem voluptas temporibus numquam ab. Aut temporibus accusantium consectetur.','maxime.jpg',91764,NULL,'2006-08-07 15:24:03.000','2019-06-19 18:11:58.000')
,(1,15,'Consequuntur animi sed ea perferendis ad magnam. Aut libero alias sequi iste qui est. Ut quo dignissimos quibusdam doloremque est est incidunt.','qui.jpg',90944,NULL,'2000-11-07 15:35:46.000','2019-06-19 18:11:58.000')
,(2,6,'Accusantium sit praesentium voluptatem molestias architecto. Excepturi doloremque ab eligendi eum ullam voluptas qui. Inventore expedita distinctio omnis laborum laboriosam.','eveniet.jpg',317340,NULL,'1999-07-10 01:22:03.000','2019-06-19 18:11:58.000')
,(3,7,'Et iure cupiditate expedita ut earum et illum. Cum sed assumenda velit officia. Voluptas harum ea magni aspernatur aut ea vel.','incidunt.jpg',0,NULL,'1996-06-24 05:20:00.000','2019-06-19 18:11:58.000')
,(4,8,'A culpa nostrum et quis. Id ipsum ipsum deserunt earum eaque aut earum. Blanditiis et commodi voluptas.','eaque.jpg',9525,NULL,'1973-07-27 14:27:31.000','2019-06-19 18:11:58.000')
,(1,9,'Cumque quod provident provident fugit cumque numquam. Fuga totam delectus a aut quaerat nemo dignissimos eos. Ratione harum et laborum qui dolore aliquam facilis numquam. At quas nam sapiente porro nesciunt voluptatum.','non.jpg',20697427,NULL,'1999-02-12 16:23:02.000','2019-06-19 18:11:58.000')
,(2,10,'Provident quia fuga et consequatur reprehenderit repellat. Et aut cum nostrum ut beatae animi aut alias.','et.jpg',263408,NULL,'1977-02-20 10:38:19.000','2019-06-19 18:11:58.000')
;
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(3,1,'Voluptatem est recusandae molestias quod. Voluptatem velit omnis asperiores dolorum est vero. Quo doloribus aut natus rem. Dolor sapiente libero quis sit.','et.jpg',4391,NULL,'1976-08-29 01:30:58.000','2019-06-19 18:11:58.000')
,(4,2,'Et commodi tempora voluptate perferendis. Ullam ratione sequi in eveniet accusantium consequatur. Quod quis ipsum consectetur fuga numquam.','odio.jpg',90,NULL,'2011-05-04 15:25:34.000','2019-06-19 18:11:58.000')
,(1,3,'Similique qui quibusdam vitae et. Voluptas nihil nesciunt reiciendis et. Incidunt necessitatibus illo asperiores quidem ipsa quam. Amet quisquam amet aut facere totam fuga quasi.','expedita.jpg',87,NULL,'2004-12-04 20:41:26.000','2019-06-19 18:11:58.000')
,(2,4,'Eos id culpa inventore voluptatem aut placeat dolorem. Ex sunt rem esse aspernatur. Est ut ut quidem est esse. Possimus quia nisi neque.','beatae.jpg',694461,NULL,'2009-07-14 02:12:15.000','2019-06-19 18:11:58.000')
,(3,5,'Libero ut qui dicta impedit. Consequatur earum neque quis consequatur numquam consequatur. Voluptatibus eos vel ex quis sed cum.','et.jpg',154603,NULL,'1982-03-22 20:11:50.000','2019-06-19 18:11:58.000')
,(4,6,'Sapiente in totam sed aliquam rem qui occaecati. Dolor dignissimos omnis mollitia temporibus repellendus ut. Est esse facilis deleniti eum dolorem ex distinctio. Est nisi rerum aut optio. Quod dolor occaecati expedita quia incidunt debitis.','tenetur.jpg',6392040,NULL,'2002-02-25 18:09:15.000','2019-06-19 18:11:58.000')
,(1,7,'Ut praesentium soluta facere sunt. Eveniet in voluptatem optio neque cumque quis ut. Dolores assumenda ullam error quis atque magni ut. Quia at aut et aliquid consectetur.','accusantium.jpg',0,NULL,'2001-12-11 00:20:19.000','2019-06-19 18:11:58.000')
,(2,8,'Ut ab libero dolor eum deleniti porro facilis. Quo iusto perspiciatis fugiat voluptatem nam sint. Ut nisi sed et dicta eos explicabo quos.','corrupti.jpg',3,NULL,'1985-09-26 10:28:43.000','2019-06-19 18:11:58.000')
,(3,9,'Nam voluptas omnis in quas aut. Nihil perspiciatis magni voluptatum mollitia aut nulla. Consequuntur nostrum atque nihil omnis. Velit hic eum sapiente quis molestiae deleniti.','tempore.jpg',2896602,NULL,'1986-09-26 20:25:54.000','2019-06-19 18:11:58.000')
,(4,10,'Ea odio eveniet totam asperiores aut vel. Nihil dolores natus magnam aut delectus perspiciatis eum ullam. Magnam est cupiditate earum fuga aut numquam. Delectus modi ut occaecati est et aut.','necessitatibus.jpg',0,NULL,'1992-02-13 22:01:03.000','2019-06-19 18:11:58.000')
;
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(1,1,'Dolorem molestias similique laboriosam et. Incidunt earum voluptatem magnam voluptas eligendi quos. Cum voluptatem quia odio sed. Ut voluptatum ex sint illum molestias perferendis laborum.','sapiente.jpg',816152694,NULL,'1990-10-06 08:14:28.000','2019-06-19 18:11:58.000')
,(2,2,'Id illo quia corporis. Magni id illo commodi natus. Eos porro error nihil optio quia.','dolorem.jpg',7095,NULL,'1997-02-27 21:12:18.000','2019-06-19 18:11:58.000')
,(3,3,'Eos omnis error quis est debitis. Itaque adipisci voluptatibus velit autem. Tempora quo saepe nesciunt sapiente sequi hic.','illo.jpg',1520673,NULL,'1986-07-05 22:35:21.000','2019-06-19 18:11:58.000')
,(4,4,'Dolore non repellat mollitia dolor ut sequi. Excepturi enim dolorem mollitia eaque sit porro ab. Eos consequatur hic dolore itaque quia animi ea.','dignissimos.jpg',548,NULL,'2002-12-21 03:54:14.000','2019-06-19 18:11:58.000')
,(1,5,'Cupiditate modi molestiae culpa delectus est et voluptatem. Eius non impedit asperiores praesentium repellendus tempore. Minus natus quod eos quidem.','qui.jpg',7380,NULL,'2016-05-23 13:35:39.000','2019-06-19 18:11:58.000')
,(2,6,'Provident dignissimos necessitatibus ut et esse. Excepturi et iste facere id suscipit ut. Voluptatem est ex et dolor nobis facilis et. Ut voluptatibus sunt et ut.','aut.jpg',14685,NULL,'2009-12-02 01:42:24.000','2019-06-19 18:11:58.000')
,(3,7,'In mollitia consequatur aspernatur atque. Alias illum voluptatem et nemo et exercitationem. Voluptatem in ut quia similique quis. Saepe cupiditate sunt tenetur minima.','laborum.jpg',3,NULL,'2010-12-16 09:47:22.000','2019-06-19 18:11:58.000')
,(4,8,'Quidem ad libero voluptas et veniam. Dolores dolores quia voluptatem soluta. Voluptatibus facere saepe non nulla.','consequatur.jpg',490,NULL,'1977-01-14 01:24:52.000','2019-06-19 18:11:58.000')
,(1,9,'Esse eveniet similique sit temporibus aliquam. Sequi consequatur excepturi enim aut. Mollitia voluptas facilis velit omnis animi ea numquam. Accusamus nostrum aspernatur ullam itaque et eveniet quia. Corrupti tempora fugit rerum architecto voluptatem pariatur.','quae.jpg',26430194,NULL,'1990-08-09 00:43:45.000','2019-06-19 18:11:58.000')
,(2,10,'Molestiae excepturi quia necessitatibus id voluptatem laudantium. Et ut ea mollitia quisquam. Vel consequatur quas excepturi totam sit suscipit. Aut tempora ratione eos ipsam quae possimus libero. Architecto et quia voluptatem et tempora alias sequi.','nulla.jpg',0,NULL,'1995-04-23 07:55:46.000','2019-06-19 18:11:58.000')
;
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(3,1,'Omnis quaerat minus inventore quaerat. Ut sunt optio similique laboriosam. Fugit voluptas nesciunt debitis possimus tempore. Architecto sunt maiores laborum quod laboriosam.','dolorem.jpg',38,NULL,'1976-09-18 10:50:57.000','2019-06-19 18:11:58.000')
,(4,2,'Ullam unde earum dolorem. Vel doloremque harum optio deserunt iure. Voluptate at animi veniam suscipit quisquam.','dolorum.jpg',447,NULL,'2015-10-20 01:11:46.000','2019-06-19 18:11:58.000')
,(1,3,'Ut distinctio non vero qui. Accusantium a consectetur magnam eum quisquam molestias. Sequi et quam fuga ut sint.','impedit.jpg',874783484,NULL,'1988-08-22 10:39:27.000','2019-06-19 18:11:58.000')
,(2,4,'Fugiat rem eveniet laborum eius ipsa. Soluta provident nihil dolor aliquid ut modi magnam delectus. Ratione amet dolores quam molestiae blanditiis.','voluptas.jpg',86837,NULL,'2010-01-19 21:57:21.000','2019-06-19 18:11:58.000')
,(3,5,'Consequatur voluptatem et sequi voluptatibus ut accusamus perferendis. Aut perspiciatis laboriosam ut consectetur. Ducimus omnis rem ut unde nobis sit rerum laborum. Reiciendis quaerat amet consequatur velit excepturi deserunt atque. Sed natus quibusdam quidem pariatur.','et.jpg',868,NULL,'2014-09-09 19:10:38.000','2019-06-19 18:11:58.000')
,(4,6,'Non est quia doloribus sed. Voluptates vitae necessitatibus molestiae quo dolorum mollitia at. Quos rem omnis porro nulla vero tempore similique ratione. Mollitia quo quo et et non laboriosam perferendis sit.','aliquid.jpg',10461638,NULL,'1988-06-16 01:16:35.000','2019-06-19 18:11:58.000')
,(1,7,'Quia provident autem nisi quisquam rerum. Inventore nostrum dolores eum explicabo hic ipsum deserunt. Eos et eum aut.','maiores.jpg',482028,NULL,'2016-05-20 20:16:27.000','2019-06-19 18:11:58.000')
,(2,8,'Repellat minima animi iure explicabo blanditiis sed. Incidunt vel animi reprehenderit quisquam reprehenderit. Dolor ut ipsum deleniti ut officia. Velit sequi consequatur nemo nam sed rerum.','dolorem.jpg',142917961,NULL,'1974-05-05 20:37:58.000','2019-06-19 18:11:58.000')
,(3,9,'Assumenda ipsum officiis fuga unde itaque eveniet magni. Quasi assumenda qui sed quod quis. Amet sit dolores accusantium voluptatem omnis unde soluta.','unde.jpg',6099,NULL,'1972-08-24 05:37:28.000','2019-06-19 18:11:58.000')
,(4,10,'Non est animi consequatur. Neque aliquid aut voluptatem aut inventore ut. Maiores hic voluptas nesciunt. Nulla vel facilis deleniti tempore.','dignissimos.jpg',783631045,NULL,'2006-11-01 15:16:53.000','2019-06-19 18:11:58.000')
;
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(1,1,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','nisi.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(2,2,'Nihil quasi doloremque rerum velit non libero. Non veritatis perspiciatis autem. Expedita rerum nihil aliquam.','sint.jpg',86964,NULL,'2011-09-12 11:05:53.000','2019-06-19 18:11:58.000')
,(3,3,'Nesciunt aut sint nam dolor facilis ut est. Odit dolores assumenda dolore.','ipsum.jpg',689891921,NULL,'2008-05-10 05:19:10.000','2019-06-19 18:11:58.000')
,(4,4,'Aliquid facere dignissimos quidem quo et beatae. Non qui dolore velit. Nemo non asperiores architecto corporis ratione.','velit.jpg',767,NULL,'1981-11-28 00:43:00.000','2019-06-19 18:11:58.000')
,(1,5,'Id quos rerum delectus quas porro eos. Qui in accusantium nihil et possimus. Qui doloribus dolores a deserunt illo.','ducimus.jpg',663,NULL,'2005-01-31 02:53:19.000','2019-06-19 18:11:58.000')
,(2,6,'Ipsa odit ut sed et. Eos vero aut veritatis doloribus ipsam et at repellendus. Fugiat sequi sint aliquam nostrum voluptate. Omnis quaerat consequatur cum.','mollitia.jpg',66726632,NULL,'1970-10-07 22:45:18.000','2019-06-19 18:11:58.000')
,(3,7,'Placeat aut consequatur unde sed qui voluptatum. Harum ut quasi reprehenderit nostrum et. Facilis magnam consectetur ea suscipit accusantium.','enim.jpg',213578,NULL,'2015-06-20 15:21:47.000','2019-06-19 18:11:58.000')
,(4,8,'Quod assumenda impedit aut odio consequatur aut quisquam. In officia mollitia nobis. Non accusantium ut tempore.','iure.jpg',0,NULL,'1996-05-24 05:33:17.000','2019-06-19 18:11:58.000')
,(1,9,'Nemo eum et placeat non et repellat consequuntur. Rem vitae rerum sed aut numquam voluptatum quia. Magni itaque rerum laboriosam saepe molestias a.','voluptas.jpg',8488,NULL,'1973-03-06 04:36:40.000','2019-06-19 18:11:58.000')
,(2,10,'Alias qui dolores tempore est. Molestiae necessitatibus debitis nihil qui. Et molestiae voluptatem doloribus tempore enim veritatis tenetur. Consequatur qui non debitis voluptas et in soluta.','aut.jpg',96,NULL,'2001-09-09 22:19:46.000','2019-06-19 18:11:58.000')
;

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    , FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict
    , FOREIGN KEY (media_id) REFERENCES media(id)
);
INSERT INTO `likes` VALUES 
('1','1','1','1988-10-14 18:47:39'),
('2','2','1','1988-09-04 16:08:30'),
('3','3','1','1994-07-10 22:07:03'),
('4','4','1','1991-05-12 20:32:08'),
('5','5','2','1978-09-10 14:36:01'),
('6','6','2','1992-04-15 01:27:31'),
('7','7','2','2003-02-03 04:56:27'),
('8','8','8','2017-04-24 09:30:19'),
('9','9','9','1974-02-07 20:53:55'),
('10','10','10','1973-05-11 03:21:40'),
('11','11','11','2008-12-17 13:03:56'),
('12','12','12','1995-07-17 21:22:38'),
('13','13','13','1985-09-07 23:34:21'),
('14','14','14','1973-01-27 23:11:53'),
('15','15','15','1973-01-27 23:11:53'),
('16','1','1','1988-10-14 18:47:39'),
('17','2','2','1988-10-14 18:47:40'),
('18','3','3','1988-10-14 18:47:41'),
('19','4','4','1988-10-14 18:47:42'),
('20','5','5','1988-10-14 18:47:43'),
('21','6','6','1988-10-14 18:47:44'),
('22','7','7','1988-10-14 18:47:45'),
('23','8','8','1988-10-14 18:47:46'),
('24','9','9','1988-10-14 18:47:47'),
('25','10','10','1988-10-14 18:47:48'),
('26','11','11','1988-10-14 18:47:49'),
('27','12','12','1988-10-14 18:47:50'),
('28','13','13','1988-10-14 18:47:51'),
('29','14','14','1988-10-14 18:47:52'),
('30','15','15','1988-10-14 18:47:53'),
('31','1','1','1988-10-14 18:47:39'),
('32','2','2','1988-10-14 18:47:40'),
('33','3','3','1988-10-14 18:47:41'),
('34','4','4','1988-10-14 18:47:42'),
('35','5','5','1988-10-14 18:47:43'),
('36','6','6','1988-10-14 18:47:44'),
('37','7','7','1988-10-14 18:47:45'),
('38','8','8','1988-10-14 18:47:46'),
('39','9','9','1988-10-14 18:47:47'),
('40','10','10','1988-10-14 18:47:48'),
('41','11','1','1988-10-14 18:47:49'),
('42','12','2','1988-10-14 18:47:50'),
('43','13','3','1988-10-14 18:47:51'),
('44','14','4','1988-10-14 18:47:52'),
('45','15','5','1988-10-14 18:47:53'),
('46','2','1','1988-10-14 18:47:39'),
('47','3','2','1988-10-14 18:47:40'),
('48','4','3','1988-10-14 18:47:41'),
('49','5','4','1988-10-14 18:47:42'),
('50','6','5','1988-10-14 18:47:43'),
('51','7','6','1988-10-14 18:47:44'),
('52','8','7','1988-10-14 18:47:45'),
('53','9','8','1988-10-14 18:47:46'),
('54','10','9','1988-10-14 18:47:47'),
('55','11','10','1988-10-14 18:47:48'),
('56','12','1','1988-10-14 18:47:49'),
('57','13','2','1988-10-14 18:47:50'),
('58','14','3','1988-10-14 18:47:51'),
('59','15','4','1988-10-14 18:47:52'),
('60','3','1','1988-10-14 18:47:39'),
('61','4','2','1988-10-14 18:47:40'),
('62','5','3','1988-10-14 18:47:41'),
('63','6','4','1988-10-14 18:47:42'),
('64','7','5','1988-10-14 18:47:43'),
('65','8','6','1988-10-14 18:47:44'),
('66','9','7','1988-10-14 18:47:45'),
('67','10','8','1988-10-14 18:47:46'),
('68','11','9','1988-10-14 18:47:47'),
('69','12','10','1988-10-14 18:47:48'),
('70','13','1','1988-10-14 18:47:49'),
('71','14','2','1988-10-14 18:47:50'),
('72','15','3','1988-10-14 18:47:51')
; 

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (photo_id) REFERENCES media(id)
);
INSERT INTO `profiles` VALUES 
('1','f','1976-11-08','1','1970-01-18 03:54:01','Adriannaport'),
('2','f','2011-12-20','2','1994-11-06 23:56:10','North Nettieton'),
('3','m','1994-06-15','3','1975-11-27 02:27:11','Padbergtown'),
('4','f','1979-11-07','4','1994-04-12 04:31:49','Port Rupertville'),
('5','f','1976-04-19','5','1976-07-05 02:25:30','Spencerfort'),
('6','f','1983-09-07','6','1981-06-20 15:54:43','South Woodrowmouth'),
('7','m','2014-07-31','7','1997-06-21 07:52:05','South Jeffereyshire'),
('8','f','1975-03-26','8','2008-08-18 18:23:25','Howeside'),
('9','f','1982-11-01','9','2014-09-29 01:22:26','Loweborough'),
('10','m','1977-05-14','10','1980-03-17 18:17:45','New Nellaside'),
('11','m','2008-10-28','11','2011-08-22 08:31:06','New Skylar'),
('12','f','1994-02-07','12','2015-08-04 16:34:50','South Dameontown'),
('13','f','1998-08-08','13','1978-02-12 03:14:55','North Terencemouth'),
('14','f','1973-11-16','14','2015-03-13 03:01:16','West Wilfordshire'),
('15','m','1979-08-20','15','1983-08-13 03:48:56','North Xavier'); 
