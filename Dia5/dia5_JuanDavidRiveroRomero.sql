-- #####################################
-- #####    DIA 5  -  MySQL 2      #####
-- #####################################




USE `mysql2_dia5`;

-- Trigger para insertar o actualizar una ciudad en pais con
-- la nueva población
delimiter //
CREATE TRIGGER after_city_insert_update
AFTER INSERT ON city
FOR EACH ROW
BEGIN
	UPDATE country
    SET Population = Population + NEW.Population
    WHERE Code = NEW.CountryCode;
END //
delimiter ;

-- Test 
INSERT INTO city (Name,CountryCode,District,Population)
VALUES("Artemis","AFG","Piso 6",1250000);


delimiter //
CREATE TRIGGER after_city_insert_update
AFTER DELETE ON city
FOR EACH ROW
BEGIN
	UPDATE country
    SET Population = Population - Old.Population
    WHERE Code = NEW.CountryCode;
END //
delimiter ;


Select * from city where Name = "Artemis";
delete from city where ID = 4082;

CREATE TABLE IF NOT EXISTS city_audit (
	audit_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT,
    action VARCHAR(10),
    old_population INT,
    new_population INT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

-- Trigger para auditoria de ciudades cuando se inserta
delimiter //
create trigger after_city_insert_audit
after insert on city
for each row
begin
	insert into city_audit(city_id,action,new_population)
    values (NEW.ID,'INSERT',NEW.Population);
end //
delimiter ;
select * from city_audit;
INSERT INTO city (Name,CountryCode,District,Population)
VALUES("Artemis","AFG","Piso 6",1250000);

-- sadsa
delimiter //
create trigger after_city_update_audit
after update on city
for each row
begin
	insert into city_audit(city_id,action,old_population,new_population)
    values (OLD.ID,'UPDATE',OLD.Population,NEW.Population);
end //
delimiter ;




select * from city_audit;
INSERT INTO city (Name,CountryCode,District,Population)
VALUES("Artemis","AFG","Piso 6",1250000);
update city set Population = 1550000 where ID=4086;
select * from city_audit;

CREATE TABLE IF NOT EXISTS city_backup(
	ID int NOT NULL PRIMARY KEY,
    Name CHAR(35) NOT NULL,
    CountryCode CHAR(3) NOT NULL,
    District CHAR(20) NOT NULL,
    Population int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

delimiter //
create event if not exists weekly_city_backup
on schedule every 1 week
Do 
begin
	truncate table city_backup;
    insert into city_backup(ID,Name,CountryCode,District,Population)
    select ID,Name,CountryCode, District,Population from city;
end;
delimiter ;