-- http://www.artfulsoftware.com/infotree/queries.php
-- https://mysqlstepbystep.com/2015/07/15/useful-queries-on-mysql-information_schema/
-- http://www.databasejournal.com/features/mysql/article.php/3904531/The-10-Most-Common-MySQL-Queries.htm
-- http://www.tecmint.com/mysqladmin-commands-for-database-administration-in-linux/
-- http://www.tutorialspoint.com/mysql/mysql-useful-functions.htm

/****
Kill PROCESSLIST
****/
SELECT Concat('KILL ', id, ';') 
FROM   information_schema.processlist 
WHERE  user = 'erp' 
       AND time > 200; 

/****
CREATE USER 
****/
CREATE USER 'cesar'@'%' IDENTIFIED BY 'QKiU8s9ZiuLrvbeYaPrn';
GRANT ALL PRIVILEGES ON *.* TO 'cesar'@'%';
FLUSH PRIVILEGES;



/****
Get Size of Database Tables 
****/

SELECT table_schema "Data Base Name",
    sum( data_length + index_length ) / 1024 / 1024 "Data Base Size in MB",
    sum( data_free )/ 1024 / 1024 "Free Space in MB"
FROM information_schema.TABLES
GROUP BY table_schema ; 

/***
Get column names in schema 
***/

SELECT DISTINCT TABLE_NAME 
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE COLUMN_NAME LIKE '%texto%'
        -- AND TABLE_SCHEMA='YourDatabase';
        
/***
Finding Text in MySQL Stored Procedure
***/

SELECT 
      * 
FROM 
      INFORMATION_SCHEMA.ROUTINES 
WHERE 
      ROUTINE_DEFINITION LIKE '%texto%' 
ORDER BY ROUTINE_NAME;

/***
Obtaining records with duplicate field values ​​and the number of repetitions:
***/

SELECT `column_name`, COUNT (` column_name`) AS `count`
FROM `table_name`
GROUP BY `column_name`
HAVING `count`;

/***
This query will group all records for `column_name` maximum date for the current value:
***/

SELECT *
FROM `table_name` AS` t1`
WHERE `column_date` =
(SELECT MAX (`column_date`) FROM` table_name` AS `t2` WHERE` t1`.`column_name` = `t2`.`column_name`);

/***
Selecting records repeated N times the value of the field. Change the query to a specific number of N:
***/

SELECT *
FROM `table_name`
GROUP BY `column_name`
HAVING COUNT (*) = N;


/***
Getting the size of the database MySQL:
***/

SELECT `table_schema` AS` Db name`,
ROUND (SUM (`data_length` +` index_length`) / 1024/1024, 3) AS ‘Db size (MB)’
FROM `information_schema`.`tables`
GROUP BY `table_schema`;

/***
Determination of the number of words in a column:
***/

SELECT LENGTH (`column_name`) – LENGTH (REPLACE (` column_name`, ”, ”)) + 1 AS `words_count`
FROM `table_name`;

/***
The event, which is triggered every 1 hour and deletes records from the table:
***/

SET GLOBAL `event_scheduler` = ON;
CREATE EVENT `hourly_event`
ON SCHEDULE EVERY 1 HOUR
DO
DELETE FROM `table_name`;

/***
Getting the name of the field, which is the primary key in the table:
***/

SELECT `COLUMN_NAME`
FROM `information_schema`.`COLUMNS`
WHERE `TABLE_NAME` = 'table_name'
AND `COLUMN_KEY` = 'PRI';

/***
Fetch information about foreign key table:
***/
SELECT `COLUMN_NAME`,` CONSTRAINT_NAME`, `REFERENCED_TABLE_NAME`,` REFERENCED_COLUMN_NAME`
FROM `information_schema`.`KEY_COLUMN_USAGE`
WHERE `TABLE_NAME` = ‘table_name’
AND `CONSTRAINT_NAME` & lt; & gt; ‘PRIMARY';


/***
Show replication status
***/
SHOW SLAVE STATUS;
