CREATE DATABASE keiba_expectation_app_test DEFAULT CHARACTER SET utf8mb4;
CREATE USER keiba_expectation_app_test@'%' IDENTIFIED BY 'h4Dv3Acc';
GRANT ALL ON `keiba_expectation_app_test`.* TO keiba_expectation_app_test@'%';