CREATE USER admitry@'%' IDENTIFIED WITH mysql_native_password BY '2Y#8U_ZbH97X';
CREATE USER identity-svc@'%' IDENTIFIED WITH mysql_native_password BY 'uXZ8C6L6pk';
GRANT ALL PRIVILEGES ON identityservice.* TO admitry@'%';
GRANT SELECT,INSERT,UPDATE,DELETE ON identityservice.* TO identity-svc@'%';
