
-- Creación de la base de datos de AutoRental
CREATE DATABASE IF NOT EXISTS AutoRental;

-- Utilización de la base de datos
USE AutoRental;

-- Creación de la tabla Sucursales
CREATE TABLE Sucursales (
    id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
    ciudad VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono_fijo VARCHAR(15),
    celular VARCHAR(15),
    correo_electronico VARCHAR(50)
);

-- Creación de la tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    id_sucursal INT,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    ciudad_residencia VARCHAR(50) NOT NULL,
    celular VARCHAR(15),
    correo_electronico VARCHAR(50),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    ciudad_residencia VARCHAR(50) NOT NULL,
    celular VARCHAR(15),
    correo_electronico VARCHAR(50)
);

-- Creación de la tabla Vehiculos
CREATE TABLE Vehiculos (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    tipo_vehiculo VARCHAR(20) NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    referencia VARCHAR(50),
    modelo YEAR,
    puertas INT,
    capacidad INT,
    sunroof BOOLEAN,
    motor VARCHAR(20),
    color VARCHAR(20)
);

-- Creación de la tabla Alquileres
CREATE TABLE Alquileres (
    id_alquiler INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT,
    id_cliente INT,
    id_empleado INT,
    sucursal_salida INT,
    fecha_salida DATE,
    sucursal_llegada INT,
    fecha_llegada DATE,
    fecha_esperada_llegada DATE,
    valor_alquiler_semana DECIMAL(10,2),
    valor_alquiler_dia DECIMAL(10,2),
    porcentaje_descuento DECIMAL(5,2),
    valor_cotizado DECIMAL(10,2),
    valor_pagado DECIMAL(10,2),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
    FOREIGN KEY (sucursal_salida) REFERENCES Sucursales(id_sucursal),
    FOREIGN KEY (sucursal_llegada) REFERENCES Sucursales(id_sucursal)
);