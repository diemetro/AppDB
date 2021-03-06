CREATE DATABASE IF NOT EXISTS `identity`;
CREATE DATABASE IF NOT EXISTS `lk`;
CREATE DATABASE IF NOT EXISTS `signning`;
CREATE DATABASE IF NOT EXISTS `api`;
CREATE DATABASE IF NOT EXISTS `configrepository`;
CREATE DATABASE IF NOT EXISTS `billing`;
CREATE USER IF NOT EXISTS 'admitry'@'%' IDENTIFIED BY '2Y#8U_ZbH97X';
CREATE USER IF NOT EXISTS 'identity-svc'@'%' IDENTIFIED BY 'uXZ8C6L6pk';
GRANT SELECT, INSERT, UPDATE, DELETE ON identity.* TO 'identity-svc'@'%';
GRANT ALL PRIVILEGES ON identity.* TO 'admitry'@'%';
GRANT ALL PRIVILEGES ON lk.* TO 'admitry'@'%';
GRANT ALL PRIVILEGES ON signning.* TO 'admitry'@'%';
GRANT ALL PRIVILEGES ON api.* TO 'admitry'@'%';
GRANT ALL PRIVILEGES ON configrepository.* TO 'admitry'@'%';
GRANT ALL PRIVILEGES ON billing.* TO 'admitry'@'%';
FLUSH PRIVILEGES;
