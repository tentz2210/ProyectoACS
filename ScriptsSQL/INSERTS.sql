select * from calidad.tbl_empleados;

INSERT INTO Departamento(departamentoId, nombre) 
VALUES 
	(1,'Departamento 1'),
	(2,'Departamento 2'),
    (3,'Departamento 3'),
    (4,'Departamento 4'),
    (5,'Departamento 5'),
    (6,'Departamento 6'),
    (7,'Departamento 7'),
    (8,'Departamento 8'),
    (9,'Departamento 9'),
    (10,'Departamento 10'),
    (11,'Departamento 11'),
    (12,'Departamento 12'),
    (13,'Departamento 13'),
    (14,'Departamento 14'),
    (15,'Departamento 15'),
    (16,'Departamento 16'),
    (17,'Departamento 17'),
    (18,'Departamento 18'),
    (19,'Departamento 19'),
    (20,'Departamento 20'),
    (21,'Departamento 21'),
    (22,'Departamento 22'),
    (23,'Departamento 23'),
    (24,'Departamento 24');

INSERT INTO Deduccion(nombre, porcentaje)
VALUES
	('CCSS_obrero', 8),
    ('banco_popular', 1),
    ('CCSS_patron', 24),
    ('aguinaldo', 8.33),
    ('cesantia', 6.33),
    ('vacaciones', 4.16),
    ('INS', 1.5);

-- Para pasar datos a tabla colaborador
SELECT cedula, departamento, nombre, apellido1, apellido2, 87654321, concat(nombre, '@ejemplo.com'), salario, round(rand()*5, 1) as contribucionAsociacion, true
FROM calidad.tbl_empleados; -- poner nombre de tabla temporal

INSERT INTO Colaborador 
	SELECT cedula, 
		   departamento as departamentoId,
           nombre,
           apellido1,
           apellido2,
           87654321 as celular,
           concat(nombre, '@ejemplo.com') as email,
           salario as salarioBruto,
           round(rand()*5, 1) as contribucionAsociacion,
           true as activo
	FROM calidad.tbl_empleados; -- poner nombre de tabla temporal

SELECT salarioBruto*

select * from colaborador;