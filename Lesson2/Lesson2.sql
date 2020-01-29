/*Установите СУБД MySQL. 
Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
 
Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
Создайте дамп единственной таблицы help_keyword базы данных mysql. 
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/



/*
 * Microsoft Windows [Version 10.0.17763.973]
(c) 2018 Microsoft Corporation. All rights reserved.

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p
Enter password: ******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 19
Server version: 8.0.19 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit
Bye

C:\Program Files\MySQL\MySQL Server 8.0\bin>wsl nano .my.cnf

C:\Program Files\MySQL\MySQL Server 8.0\bin>dir
 Volume in drive C is Windows
 Volume Serial Number is 4C95-F578

 Directory of C:\Program Files\MySQL\MySQL Server 8.0\bin

29-Jan-20  09:29 PM    <DIR>          .
29-Jan-20  09:29 PM    <DIR>          ..
29-Jan-20  09:29 PM                35 .my.cnf
09-Dec-19  01:39 PM         6,276,616 comp_err.exe
09-Dec-19  09:29 PM           614,912 harness-library.dll
09-Dec-19  01:40 PM         6,376,960 ibd2sdi.exe
09-Dec-19  01:40 PM         6,347,784 innochecksum.exe
04-Dec-19  11:45 AM         3,384,320 libcrypto-1_1-x64.dll
23-Oct-19  09:37 AM         1,839,616 libmecab.dll
09-Dec-19  09:23 PM         6,380,032 libprotobuf-debug.dll
09-Dec-19  09:23 PM         1,039,872 libprotobuf-lite-debug.dll
09-Dec-19  09:29 PM           404,992 libprotobuf-lite.dll
09-Dec-19  09:29 PM           613,894 libprotobuf-lite.lib
09-Dec-19  09:30 PM         2,573,312 libprotobuf.dll
09-Dec-19  09:30 PM         3,586,510 libprotobuf.lib
04-Dec-19  11:45 AM           679,424 libssl-1_1-x64.dll
09-Dec-19  01:40 PM         6,253,584 lz4_decompress.exe
09-Dec-19  01:40 PM         6,633,480 myisamchk.exe
09-Dec-19  01:40 PM         6,474,760 myisamlog.exe
09-Dec-19  01:40 PM         6,530,056 myisampack.exe
09-Dec-19  01:40 PM         6,507,536 myisam_ftdump.exe
09-Dec-19  01:40 PM         6,932,480 mysql.exe
09-Dec-19  01:40 PM         6,833,672 mysqladmin.exe
09-Dec-19  01:40 PM         7,112,200 mysqlbinlog.exe
09-Dec-19  01:40 PM         6,840,328 mysqlcheck.exe
09-Dec-19  01:40 PM        47,603,200 mysqld.exe
09-Dec-19  01:40 PM         6,901,256 mysqldump.exe
09-Dec-19  09:23 PM             7,902 mysqldumpslow.pl
09-Dec-19  09:23 PM            28,797 mysqld_multi.pl
09-Dec-19  01:40 PM         6,827,528 mysqlimport.exe
09-Dec-19  01:40 PM         7,240,712 mysqlpump.exe
09-Dec-19  01:40 PM         7,364,104 mysqlrouter.exe
09-Dec-19  09:29 PM           250,880 mysqlrouter_http.dll
09-Dec-19  01:40 PM         7,412,248 mysqlrouter_keyring.exe
09-Dec-19  01:40 PM         7,413,784 mysqlrouter_passwd.exe
09-Dec-19  01:40 PM         6,235,168 mysqlrouter_plugin_info.exe
09-Dec-19  01:40 PM         6,825,480 mysqlshow.exe
09-Dec-19  01:40 PM         6,843,400 mysqlslap.exe
09-Dec-19  01:40 PM         6,267,416 mysql_config_editor.exe
09-Dec-19  01:40 PM         6,823,976 mysql_secure_installation.exe
09-Dec-19  01:40 PM         6,294,040 mysql_ssl_rsa_setup.exe
09-Dec-19  01:40 PM         6,207,512 mysql_tzinfo_to_sql.exe
09-Dec-19  01:40 PM         6,914,576 mysql_upgrade.exe
09-Dec-19  01:40 PM         6,252,056 my_print_defaults.exe
09-Dec-19  01:40 PM         6,993,920 perror.exe
09-Dec-19  01:40 PM         6,227,984 zlib_decompress.exe
              44 File(s)    263,172,314 bytes
               2 Dir(s)  118,422,626,304 bytes free

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql
ERROR 1045 (28000): Access denied for user 'ODBC'@'localhost' (using password: NO)

 */

create database example;
use example;
create table users (
	id int auto_increment not null primary key,
	name varchar(150) not null
);

/*
C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p
Enter password: ******

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.01 sec)

mysql> exit
Bye

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p example
mysql> show tables;
+-------------------+
| Tables_in_example |
+-------------------+
| users             |
+-------------------+
1 row in set (0.01 sec)

mysql> exit
Bye

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p example > example.sql
Enter password: ******

C:\Program Files\MySQL\MySQL Server 8.0\bin>dir
 Volume in drive C is Windows
 Volume Serial Number is 4C95-F578

 Directory of C:\Program Files\MySQL\MySQL Server 8.0\bin

29-Jan-20  10:55 PM    <DIR>          .
29-Jan-20  10:55 PM    <DIR>          ..
29-Jan-20  10:50 PM                38 .my.cnf
09-Dec-19  01:39 PM         6,276,616 comp_err.exe
29-Jan-20  10:55 PM             1,899 example.sql
09-Dec-19  09:29 PM           614,912 harness-library.dll
09-Dec-19  01:40 PM         6,376,960 ibd2sdi.exe
09-Dec-19  01:40 PM         6,347,784 innochecksum.exe
04-Dec-19  11:45 AM         3,384,320 libcrypto-1_1-x64.dll
23-Oct-19  09:37 AM         1,839,616 libmecab.dll
09-Dec-19  09:23 PM         6,380,032 libprotobuf-debug.dll
09-Dec-19  09:23 PM         1,039,872 libprotobuf-lite-debug.dll
09-Dec-19  09:29 PM           404,992 libprotobuf-lite.dll
09-Dec-19  09:29 PM           613,894 libprotobuf-lite.lib
09-Dec-19  09:30 PM         2,573,312 libprotobuf.dll
09-Dec-19  09:30 PM         3,586,510 libprotobuf.lib
04-Dec-19  11:45 AM           679,424 libssl-1_1-x64.dll
09-Dec-19  01:40 PM         6,253,584 lz4_decompress.exe
29-Jan-20  10:52 PM                29 my.ini
09-Dec-19  01:40 PM         6,633,480 myisamchk.exe
09-Dec-19  01:40 PM         6,474,760 myisamlog.exe
09-Dec-19  01:40 PM         6,530,056 myisampack.exe
09-Dec-19  01:40 PM         6,507,536 myisam_ftdump.exe
09-Dec-19  01:40 PM         6,932,480 mysql.exe
09-Dec-19  01:40 PM         6,833,672 mysqladmin.exe
09-Dec-19  01:40 PM         7,112,200 mysqlbinlog.exe
09-Dec-19  01:40 PM         6,840,328 mysqlcheck.exe
09-Dec-19  01:40 PM        47,603,200 mysqld.exe
09-Dec-19  01:40 PM         6,901,256 mysqldump.exe
09-Dec-19  09:23 PM             7,902 mysqldumpslow.pl
09-Dec-19  09:23 PM            28,797 mysqld_multi.pl
09-Dec-19  01:40 PM         6,827,528 mysqlimport.exe
09-Dec-19  01:40 PM         7,240,712 mysqlpump.exe
09-Dec-19  01:40 PM         7,364,104 mysqlrouter.exe
09-Dec-19  09:29 PM           250,880 mysqlrouter_http.dll
09-Dec-19  01:40 PM         7,412,248 mysqlrouter_keyring.exe
09-Dec-19  01:40 PM         7,413,784 mysqlrouter_passwd.exe
09-Dec-19  01:40 PM         6,235,168 mysqlrouter_plugin_info.exe
09-Dec-19  01:40 PM         6,825,480 mysqlshow.exe
09-Dec-19  01:40 PM         6,843,400 mysqlslap.exe
09-Dec-19  01:40 PM         6,267,416 mysql_config_editor.exe
09-Dec-19  01:40 PM         6,823,976 mysql_secure_installation.exe
09-Dec-19  01:40 PM         6,294,040 mysql_ssl_rsa_setup.exe
09-Dec-19  01:40 PM         6,207,512 mysql_tzinfo_to_sql.exe
09-Dec-19  01:40 PM         6,914,576 mysql_upgrade.exe
09-Dec-19  01:40 PM         6,252,056 my_print_defaults.exe
09-Dec-19  01:40 PM         6,993,920 perror.exe
09-Dec-19  01:40 PM         6,227,984 zlib_decompress.exe
              46 File(s)    263,174,245 bytes
               2 Dir(s)  109,477,396,480 bytes free

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p -e "create database sample;"
Enter password: ******

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p sample < example.sql
Enter password: ******

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p -e "use sample; show tables;"
Enter password: ******
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p -e "use sample; describe users;"
Enter password: ******
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| id    | int          | NO   | PRI | NULL    | auto_increment |
| name  | varchar(150) | NO   |     | NULL    |                |
+-------+--------------+------+-----+---------+----------------+

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p --where="true limit 100" mysql help_keyword > my_dump.sql
Enter password: ******

*/
