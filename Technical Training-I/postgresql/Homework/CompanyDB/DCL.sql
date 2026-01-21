-- 3. Data Control Language
-- create new role of Head Manager
create user Head_Manager 
with password 'managerpassord123';

-- grant select permissions to Head Manager
grant select on department to Head_Manager;
grant select on employee to Head_Manager;
grant select on project to Head_Manager;

-- explicitly revoke create privilege
revoke create on schema public from Head_Manager;
