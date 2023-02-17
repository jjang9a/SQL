create user scott identified by tiger
default tablespace users;
grant connect, resource to scott;
grant create view, create synonym to scott;