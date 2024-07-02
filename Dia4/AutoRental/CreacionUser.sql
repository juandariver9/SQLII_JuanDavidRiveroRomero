
use AutoRental;

-- Creación de usuarios
CREATE USER 'Empleado'@'172.16.101.158' IDENTIFIED BY 'Empleado#1234';
CREATE USER 'Cliente'@'172.16.101.158' IDENTIFIED BY 'Cliente#5678';
CREATE USER 'Jefe'@'172.16.101.158' IDENTIFIED BY 'Jefe#4321';


-- Dar permisos CRUD a los Empleados
GRANT EXECUTE ON PROCEDURE crearVehiculo TO 'Empleado'@'172.16.101.158';
GRANT EXECUTE ON PROCEDURE actualizarVehiculo TO 'Empleado'@'172.16.101.158';
GRANT EXECUTE ON PROCEDURE eliminarVehiculo TO 'Empleado'@'172.16.101.158';

-- Dar permisos para consultar y ver historial de alquileres a Clientes
GRANT EXECUTE ON PROCEDURE consultarVehiculos TO 'Cliente'@'172.16.101.158';
GRANT EXECUTE ON PROCEDURE consultarHistorialAlquileres TO 'Cliente'@'172.16.101.158';

-- Dar permisos al jefe de consultar todo
GRANT EXECUTE ON PROCEDURE consultarTodo TO 'Jefe'@'172.16.101.158';

-- Refrescar permisos / Guardar
FLUSH PRIVILEGES;

