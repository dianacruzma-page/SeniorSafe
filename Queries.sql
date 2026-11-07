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
