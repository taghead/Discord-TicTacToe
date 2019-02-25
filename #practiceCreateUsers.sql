/* Login as root  */
mysql -p -u root
use mysql;

/* Create User */
CREATE user normalUser;
UPDATE user SET authentication_string=password('1234') where user='normalUser'; /* Give user password */
FLUSH PRIVILEGES; /*Required*/

/* superUser */
CREATE USER 'superUser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON practice.* TO 'superUser'@'localhost';

/* Give privileges */
UPDATE user SET Select_priv='Y' WHERE user='normalUser'; 
UPDATE user SET Insert_priv='Y' WHERE user='normalUser'; 
UPDATE user SET Update_priv='Y' WHERE user='normalUser'; 
UPDATE user SET Show_db_priv='Y' WHERE user='normalUser'; 
UPDATE user SET Create_priv='Y' WHERE  user='normalUser';
FLUSH PRIVILEGES; /*Required like a commit but for privs*/ 
