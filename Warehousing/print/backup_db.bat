rem *******************************Code Start*****************************
@echo off

set h=%time:~0,2%
set h=%h: =0%
set "Ymd=%date:~0,4%%date:~5,2%%date:~8,2%_%h%%time:~3,2%"
D:\SOFT_PHP_PACKAGE\mysql\bin\mysqldump --opt -u jiuling --password=jiuling111101 jiuling > D:\db_backup\jiuling_%Ymd%.sql

@echo on
rem *******************************Code End*****************************
