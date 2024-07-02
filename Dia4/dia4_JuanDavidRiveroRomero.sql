create database MySQL2_dia4;
use MySQL2_dia4;

-- Creacion de usuario camper con acceso desde cualquier parte
create user 'camper'@'%' identified by 'campus2023';

-- Revisar permisos de x usuario
show grants for 'camper'@'%';

-- crear una tabla de personas
create table persona(
id int primary key, 
nombre varchar(255), 
apellido varchar(255)
 );
insert into persona (id, nombre , apellido)values(1,'Juan','Perez');
insert into persona (id, nombre , apellido)values(2,'Andres','Pastrana');
insert into persona (id, nombre , apellido)values(3,'Pedro','Gómez');
insert into persona (id, nombre , apellido)values(4,'Camilo','Gonzales');
insert into persona (id, nombre , apellido)values(5,'Stiven','Maldonado');
insert into persona (id, nombre , apellido)values(6,'Ardila','Perez');
insert into persona (id, nombre , apellido)values(7,'Ruben','Gomez');
insert into persona (id, nombre , apellido)values(8,'Andres','Portilla');
insert into persona (id, nombre , apellido)values(9,'Miguel','Carvajal');
insert into persona (id, nombre , apellido)values(10,'Andrea','Gómez');

-- Asignar permisos a x usuario para que acceda a la tabla persona de y base de datos
grant select on MySQL2_dia4.persona to 'camper'@'%';

-- Refrescar permisos BBDD
flush privileges;

-- Añadir permisos para hacer CRUD
grant insert,update,delete on MySQL2_dia4.persona to 'camper'@'%';

-- PELIGROSO: crear un usuario con permisos a todo
create user 'todito'@'%' identified by 'todito';
grant all on *.* to 'todito'@'%';
show grants for 'todito'@'%';

-- Denegar todos los permisos
revoke all on *.* from 'todito'@'%';

-- Crear un limite para que solamente se hagan x consultas por hora
alter user 'camper'@'%' with max_queries_per_hour 5;
flush privileges;

-- Revisar los limites o permisos que tiene un usuario a nivel de motor
select * from mysql.user where host ='%';

-- Eliminar usuario 
drop user 'deivid'@'%';

-- Solo poner permisos para que consulte una x base, una y tabla y una z columna
grant select (nombre) on MySQL2_dia4.persona to 'camper'@'%';