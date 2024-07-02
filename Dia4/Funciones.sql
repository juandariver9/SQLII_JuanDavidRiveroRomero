
use AutoRental;

-- Procedimiento para crear un nuevo vehiculo:
DELIMITER //
CREATE PROCEDURE crearVehiculo (
    IN p_placa VARCHAR(20),
    IN p_tipo VARCHAR(20),
    IN p_color VARCHAR(20),
    IN p_motor VARCHAR(20),
    IN p_modelo VARCHAR(20),
    IN p_referencia VARCHAR(20),
    IN p_capacidad INT,
    IN p_puertas INT,
    IN p_sunroof BOOLEAN
)
BEGIN
    INSERT INTO Vehiculos (placa, tipo, color, motor, modelo, referencia, capacidad, puertas, sunroof)
    VALUES (p_placa, p_tipo, p_color, p_motor, p_modelo, p_referencia, p_capacidad, p_puertas, p_sunroof);
END //
DELIMITER ;

-- Procedimiento para actualizar un vehiculo
DELIMITER //

CREATE PROCEDURE ActualizarVehiculo(
    IN id_vehiculo INT,
    IN tipo_vehiculo VARCHAR(20),
    IN placa VARCHAR(10),
    IN referencia VARCHAR(50),
    IN modelo YEAR,
    IN puertas INT,
    IN capacidad INT,
    IN sunroof BOOLEAN,
    IN motor VARCHAR(20),
    IN color VARCHAR(20)
)
BEGIN
    UPDATE Vehiculos
    SET tipo_vehiculo = tipo_vehiculo, 
        placa = placa, 
        referencia = referencia, 
        modelo = modelo, 
        puertas = puertas, 
        capacidad = capacidad, 
        sunroof = sunroof, 
        motor = motor, 
        color = color
    WHERE 
        id_vehiculo = id_vehiculo;
END//
DELIMITER ;

-- Procedimiento para eliminar vehiculo
DELIMITER //
CREATE PROCEDURE EliminarVehiculo(
    IN id_vehiculo INT
)
BEGIN
    DELETE FROM Vehiculos
    WHERE id_vehiculo = id_vehiculo;
END//
DELIMITER ;

-- Procedimiento para consultar vehiculos
DELIMITER //
CREATE PROCEDURE consultarVehiculos ()
BEGIN
    SELECT * FROM Vehiculos;
END //
DELIMITER ;

-- Procedimiento para consultar el historial de alquileres de un cliente específico
DELIMITER //
CREATE PROCEDURE ConsultarHistorialAlquileres(
    IN id_cliente INT
)
BEGIN
    SELECT 
        a.id_alquiler,
        a.id_vehiculo,
        a.id_empleado,
        a.sucursal_salida,
        a.fecha_salida,
        a.sucursal_llegada,
        a.fecha_llegada,
        a.fecha_esperada_llegada,
        a.valor_alquiler_semana,
        a.valor_alquiler_dia,
        a.porcentaje_descuento,
        a.valor_cotizado,
        a.valor_pagado
    FROM 
        Alquileres a
    WHERE 
        a.id_cliente = id_cliente
    ORDER BY 
        a.fecha_salida DESC;
END//
DELIMITER ;


-- Procedimiento para consultar todos los datos de las tablas
DELIMITER //
CREATE PROCEDURE consultarTodo ()
BEGIN
    SELECT * FROM Vehiculos;
    SELECT * FROM Clientes;
    SELECT * FROM Empleados;
    SELECT * FROM Sucursales;
    SELECT * FROM Alquileres;
END //
DELIMITER ;
