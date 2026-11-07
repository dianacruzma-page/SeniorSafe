CREATE TABLE Diagnostico_cognitivo (
   Id_Diagnostico INT PRIMARY KEY,
   nombre_patologia VARCHAR (50) NOT NULL,
   Fase_etapa VARCHAR (60),
   Fecha_diagnostico DATE
);

CREATE TABLE Adulto_mayor (
   Id_Adulto_mayor INT PRIMARY KEY,
   nombre VARCHAR(50) NOT NULL,
   apellidos VARCHAR(40) NOT NULL,
   cedula VARCHAR(70) NOT NULL,
   edad INT NOT NULL,
   telefono INT NOT NULL,
   direccion VARCHAR(60)
   );


  CREATE TABLE Padecer (
    Id_Adulto_mayor int,
    Id_Diagnostico int,
    FOREIGN KEY (Id_Adulto_mayor)REFERENCES Adulto_mayor(Id_Adulto_mayor),
    FOREIGN KEY (Id_Diagnostico)REFERENCES Diagnostico_cognitivo(Id_Diagnostico)
   );


  CREATE TABLE Familiar (
    Id_familiar INT PRIMARY KEY,
    Id_Adulto_mayor INT,
	nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(20) NOT NULL,
    cedula VARCHAR(20)NOT NULL,
    correo VARCHAR(40)NOT NULL,
    telefono INT NOT NULL,
    parentesco VARCHAR(40)NOT NULL,
    direccion VARCHAR(40)NOT NULL,
    FOREIGN KEY (Id_Adulto_mayor)REFERENCES Adulto_mayor(Id_Adulto_mayor)
    );


CREATE TABLE Hogar (
   Id_Hogar INT PRIMARY KEY,
   Id_Adulto_mayor INT,
   direccion VARCHAR(200) NOT NULL,
   municipio VARCHAR(20) NOT NULL,
   tipo_vivienda  VARCHAR(50) NOT NULL,
   FOREIGN KEY (Id_Adulto_mayor)REFERENCES Adulto_mayor(Id_Adulto_mayor)
   );
   
CREATE TABLE Alerta (
   Id_Alerta INT PRIMARY KEY,
   Id_Hogar INT NOT NULL,
   fecha_hora DATE NOT NULL,
   tipo_alerta VARCHAR(40),
   nivel_riesgo VARCHAR(40) NOT NULL,
   estado VARCHAR(40) NOT NULL,
   FOREIGN KEY (Id_Hogar)REFERENCES Hogar(Id_Hogar)
   );


SELECT * FROM adulto_mayor, alerta, diagnostico_cognitivo, familiar, hogar, padecer;

INSERT INTO diagnostico_Cognitivo (Id_Diagnostico, nombre_patologia, Fase_etapa, Fecha_diagnostico) VALUES
    (1, 'Alzheimer', 'Inicial', '2026-02-10'),
    (2, 'Deterioro cognitivo leve', 'Leve', '2026-03-15'),
    (3, 'Demencia vascular', 'Moderada', '2026-02-20'),
    (4, 'Alzheimer', 'Avanzada', '2026-04-05'),
    (5, 'Demencia frontotemporal', 'Inicial', '2026-02-12'),
    (6, 'Deterioro cognitivo leve', 'Leve', '2026-02-28'),
    (7, 'Alzheimer', 'Moderada', '2026-03-01'),
    (8, 'Demencia vascular', 'Avanzada', '2026-03-10'),
    (9, 'Demencia por cuerpos de Lewy', 'Inicial', '2026-03-20'),
    (10, 'Deterioro cognitivo leve', 'Leve', '2026-03-25');

INSERT INTO Adulto_mayor (Id_Adulto_mayor, nombre, apellidos, cedula, edad, telefono, direccion) VALUES
    (1, 'Ana', 'Perez', '1001', 75, '300123456', 'Calle 10'),
    (2, 'Carlos', 'Gomez', '1002', 80, '300123457', 'Calle 20'),
    (3, 'Rosa', 'Martínez', '1003', 72, '300123458', 'Calle 30'),
    (4, 'Pedro', 'Rodríguez', '1004', 85, '300123459', 'Calle 40'),
    (5, 'Lucía', 'Fernández', '1005', 78, '300123460', 'Calle 50'),
    (6, 'Miguel', 'López', '1006', 82, '300123461', 'Calle 60'),
    (7, 'Elena', 'Torres', '1007', 70, '300123462', 'Calle 70'),
    (8, 'José', 'Ramírez', '1008', 88, '300123463', 'Calle 80'),
    (9, 'Sofía', 'Castro', '1009', 76, '300123464', 'Calle 90'),
    (10, 'David', 'Morales', '1010', 81, '300123465', 'Calle 100');

 CREATE TABLE Familiar (
    Id_familiar INT PRIMARY KEY,
    Id_Adulto_mayor INT,
	nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(20) NOT NULL,
    cedula VARCHAR(20)NOT NULL,
    correo VARCHAR(40) NULL,
    telefono INT NOT NULL,
    parentesco VARCHAR(40)NOT NULL,
    direccion VARCHAR(40)NOT NULL,
    FOREIGN KEY (Id_Adulto_mayor)REFERENCES Adulto_mayor(Id_Adulto_mayor)
    );

ALTER TABLE Familiar
ALTER COLUMN correo DROP NOT NULL;


INSERT INTO Familiar (Id_familiar, nombre, apellidos, cedula, correo, telefono, parentesco, direccion, Id_Adulto_mayor) VALUES
    (101, 'Maria', 'Perez', '2001', 'maria@example.com', '310123456', 'Hija', 'Calle 10', 1),
    (102, 'Luis', 'Gomez', '2002', 'luis@example.com', '310123457', 'Hijo', 'Calle 20', 2),
    (103, 'Carmen', 'Martínez', '2003', NULL, '310123458', 'Sobrina', 'Calle 30', 3),
    (104, 'Jorge', 'Rodríguez', '2004', 'jorge@example.com', '310123459', 'Hijo', 'Calle 40', 4),
    (105, 'Ana', 'Fernández', '2005', 'ana.f@example.com', '310123460', 'Hija', 'Calle 50', 5),
    (106, 'Carlos', 'López', '2006', NULL, '310123461', 'Hijo', 'Calle 60', 6),
    (107, 'Beatriz', 'Torres', '2007', 'beatriz@example.com', '310123462', 'Hermana', 'Calle 70', 7),
    (108, 'Gabriel', 'Ramírez', '2008', 'gabriel@example.com', '310123463', 'Hijo', 'Calle 80', 8),
    (109, 'Diana', 'Castro', '2009', NULL, '310123464', 'Hija', 'Calle 90', 9),
    (110, 'Mateo', 'Morales', '2010', 'mateo@example.com', '310123465', 'Nieto', 'Calle 100', 10);

INSERT INTO Hogar (Id_Hogar, direccion, municipio, tipo_vivienda, Id_Adulto_Mayor) VALUES
    (1, 'Calle 10', 'Soacha', 'Casa', 1),
    (2, 'Calle 20', 'Bogota', 'Apartamento', 2),
    (3, 'Calle 30', 'Soacha', 'Casa', 3),
    (4, 'Calle 40', 'Bogota', 'Apartamento', 4),
    (5, 'Calle 50', 'Bogota', 'Casa', 5),
    (6, 'Calle 60', 'Soacha', 'Apartamento', 6),
    (7, 'Calle 70', 'Bogota', 'Casa', 7),
    (8, 'Calle 80', 'Soacha', 'Apartamento', 8),
    (9, 'Calle 90', 'Bogota', 'Casa', 9),
    (10, 'Calle 100', 'Soacha', 'Apartamento', 10);


INSERT INTO Alerta (Id_alerta, Fecha_hora, Tipo_alerta, Nivel_riesgo, Estado, Id_hogar) VALUES
    (1, '2026-02-15 09:30:00', 'Caida', 'Alto', 'Pendiente', 1),
    (2, '2026-02-25 14:15:00', 'Desorientación', 'Medio', 'Resuelto', 2),
    (3, '2026-03-05 18:00:00', 'Emergencia médica', 'Alto', 'Pendiente', 3),
    (4, '2026-03-12 10:00:00', 'Apertura de puerta', 'Bajo', 'Resuelto', 4),
    (5, '2026-03-15 11:20:00', 'Caida', 'Alto', 'Pendiente', 5),
    (6, '2026-03-18 16:45:00', 'Desorientación', 'Medio', 'Resuelto', 6),
    (7, '2026-03-20 08:10:00', 'Emergencia médica', 'Alto', 'Pendiente', 7),
    (8, '2026-03-22 19:30:00', 'Apertura de puerta', 'Bajo', 'Resuelto', 8),
    (9, '2026-03-25 12:00:00', 'Caida', 'Alto', 'Pendiente', 9),
    (10, '2026-03-28 15:00:00', 'Desorientación', 'Medio', 'Resuelto', 10);


INSERT INTO Padecer
(Id_Adulto_mayor, Id_diagnostico)
VALUES
(1, 3),
(2, 1),
(3, 5),
(4, 2),
(5, 8),
(6, 7),
(7, 3),
(8, 6),
(9, 9),
(10, 4);


SELECT * FROM adulto_mayor, alerta, diagnostico_cognitivo, familiar, hogar;

TRUNCATE TABLE Padecer;

SELECT * FROM adulto_mayor;

SELECT * FROM diagnostico_cognitivo WHERE fecha_diagnostico BETWEEN '2026-01-01' AND '2026-02-28';

SELECT * FROM diagnostico_cognitivo WHERE fecha_diagnostico > '2026-01-01';

SELECT adulto_mayor.nombre, diagnostico_cognitivo.nombre_patologia
FROM adulto_mayor
INNER JOIN diagnostico_cognitivo ON adulto_mayor.Id_adulto_mayor = diagnostico_cognitivo.Id_diagnostico;



SELECT adulto_mayor.nombre, diagnostico_cognitivo.nombre_patologia
FROM adulto_mayor
INNER JOIN diagnostico_cognitivo ON adulto_mayor.Id_adulto_mayor = diagnostico_cognitivo.Id_diagnostico
WHERE diagnostico_cognitivo.nombre_patologia = 'Alzheimer';



--Sentencia que traiga edad del paciente con fecha de diagnóstico y nombre diagnóstico

SELECT adulto_mayor.edad, adulto_mayor.nombre, adulto_mayor.apellidos, Diagnostico_cognitivo.Nombre_patologia, Diagnostico_cognitivo.Fecha_diagnostico
FROM Adulto_Mayor
INNER JOIN Padecer ON Adulto_Mayor.Id_Adulto_mayor = Padecer.Id_Adulto_mayor
INNER JOIN Diagnostico_cognitivo ON Diagnostico_Cognitivo.Id_Diagnostico = Padecer.Id_Diagnostico;


SELECT * FROM adulto_mayor, diagnostico_cognitivo;



