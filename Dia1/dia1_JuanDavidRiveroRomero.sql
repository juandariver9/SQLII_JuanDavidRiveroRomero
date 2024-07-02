CREATE DATABASE centroMedico;

USE centroMedico;

-- Crear las tablas
CREATE TABLE medico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    provincia VARCHAR(255) NOT NULL,
    poblacion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    nif VARCHAR(20),
    codigo_postal VARCHAR(10),
    num_SS VARCHAR(20),
    num_colegiado VARCHAR(20)
);

CREATE TABLE sustitucion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE NOT NULL,
    id_medico INT,
    FOREIGN KEY (id_medico) REFERENCES medico(id)
);

CREATE TABLE consulta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dia_semana VARCHAR(20) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    id_medico INT,
    FOREIGN KEY (id_medico) REFERENCES medico(id)
);

CREATE TABLE empleado (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    provincia VARCHAR(255) NOT NULL,
    poblacion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    nif VARCHAR(20),
    codigo_postal VARCHAR(10),
    num_SS VARCHAR(20),
    tipo VARCHAR(50)
);

CREATE TABLE vacaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    duracion INT,
    id_empleado INT,
    id_medico INT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id),
    FOREIGN KEY (id_medico) REFERENCES medico(id)
);

CREATE TABLE paciente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(255),
    num_SS VARCHAR(20),
    id_medico INT,
    FOREIGN KEY (id_medico) REFERENCES medico(id)
);

-- Insertar datos en las tablas
INSERT INTO medico (nombre, direccion, provincia, poblacion, telefono, nif, codigo_postal, num_SS, num_colegiado) VALUES
('Dr. Smith', '123 Main St', 'Province1', 'City1', '555-1234', 'NIF1234', '12345', 'SS1234', 'Col1234'),
('Dr. Johnson', '456 Elm St', 'Province2', 'City2', '555-5678', 'NIF5678', '67890', 'SS5678', 'Col5678'),
('Dr. Williams', '789 Oak St', 'Province3', 'City3', '555-9012', 'NIF9012', '54321', 'SS9012', 'Col9012');

INSERT INTO sustitucion (fecha_alta, fecha_baja, id_medico) VALUES
('2024-01-01', '2024-01-15', 1),
('2024-02-01', '2024-02-10', 2),
('2024-03-01', '2024-03-15', 3);

INSERT INTO consulta (dia_semana, hora_inicio, hora_fin, id_medico) VALUES
('Monday', '08:00', '12:00', 1),
('Tuesday', '08:00', '12:00', 1),
('Wednesday', '08:00', '12:00', 2),
('Thursday', '08:00', '12:00', 2),
('Friday', '08:00', '12:00', 3),
('Monday', '13:00', '17:00', 3);

INSERT INTO empleado (nombre, direccion, provincia, poblacion, telefono, nif, codigo_postal, num_SS, tipo) VALUES
('Alice', '123 Pine St', 'Province1', 'City1', '555-2345', 'NIF2345', '11223', 'SS2345', 'Admin'),
('Bob', '456 Maple St', 'Province2', 'City2', '555-6789', 'NIF6789', '33445', 'SS6789', 'Nurse'),
('Charlie', '789 Birch St', 'Province3', 'City3', '555-3456', 'NIF3456', '55667', 'SS3456', 'Receptionist');

INSERT INTO vacaciones (fecha_inicio, fecha_fin, duracion, id_empleado, id_medico) VALUES
('2024-01-01', '2024-01-10', 10, 1, 1),
('2024-02-01', '2024-02-15', 15, 2, 2),
('2024-03-01', '2024-03-20', 20, 3, 3);

INSERT INTO paciente (nombre, direccion, telefono, email, num_SS, id_medico) VALUES
('John Doe', '123 Cedar St', '555-7890', 'john@example.com', 'SS7890', 1),
('Jane Roe', '456 Spruce St', '555-0123', 'jane@example.com', 'SS0123', 2),
('Jim Beam', '789 Fir St', '555-3457', 'jim@example.com', 'SS3457', 3),
('Jack Daniels', '101 Pine St', '555-6781', 'jack@example.com', 'SS6781', 1),
('Jill Valentine', '202 Oak St', '555-1239', 'jill@example.com', 'SS1239', 2),
('Jerry Mouse', '303 Elm St', '555-4562', 'jerry@example.com', 'SS4562', 3);

-- Consultas

-- 1. Número de pacientes atendidos por cada médico
SELECT m.nombre, COUNT(p.id) AS numero_pacientes
FROM medico m
LEFT JOIN paciente p ON m.id = p.id_medico
GROUP BY m.nombre;

-- 2. Total de días de vacaciones planificadas y disfrutadas por cada empleado
SELECT e.nombre, SUM(v.duracion) AS dias_vacaciones
FROM empleado e
LEFT JOIN vacaciones v ON e.id = v.id_empleado
GROUP BY e.nombre;

-- 3. Médicos con mayor cantidad de horas de consulta en la semana
SELECT m.nombre, SUM(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_fin)) AS horas_consulta
FROM medico m
LEFT JOIN consulta c ON m.id = c.id_medico
GROUP BY m.nombre
ORDER BY horas_consulta DESC;

-- 4. Número de sustituciones realizadas por cada médico sustituto
SELECT m.nombre, COUNT(s.id) AS numero_sustituciones
FROM medico m
LEFT JOIN sustitucion s ON m.id = s.id_medico
GROUP BY m.nombre;

-- 5. Número de médicos que están actualmente en sustitución
SELECT COUNT(DISTINCT id_medico) AS medicos_en_sustitucion
FROM sustitucion
WHERE CURDATE() BETWEEN fecha_alta AND fecha_baja;

-- 6. Horas totales de consulta por médico por día de la semana
SELECT m.nombre, c.dia_semana, SUM(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_fin)) AS horas_consulta
FROM medico m
LEFT JOIN consulta c ON m.id = c.id_medico
GROUP BY m.nombre, c.dia_semana;

-- 7. Médico con mayor cantidad de pacientes asignados
SELECT m.nombre, COUNT(p.id) AS numero_pacientes
FROM medico m
LEFT JOIN paciente p ON m.id = p.id_medico
GROUP BY m.nombre
ORDER BY numero_pacientes DESC
LIMIT 1;

-- 8. Empleados con más de 10 días de vacaciones disfrutadas
SELECT e.nombre, SUM(v.duracion) AS dias_vacaciones
FROM empleado e
LEFT JOIN vacaciones v ON e.id = v.id_empleado
GROUP BY e.nombre
HAVING dias_vacaciones > 10;

-- 9. Médicos que actualmente están realizando una sustitución
SELECT m.nombre
FROM medico m
LEFT JOIN sustitucion s ON m.id = s.id_medico
WHERE CURDATE() BETWEEN s.fecha_alta AND s.fecha_baja;

-- 10. Promedio de horas de consulta por médico por día de la semana
SELECT m.nombre, c.dia_semana, AVG(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_fin)) AS promedio_horas
FROM medico m
LEFT JOIN consulta c ON m.id = c.id_medico
GROUP BY m.nombre, c.dia_semana;