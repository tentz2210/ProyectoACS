-- visualizacion de un reporte completo de las deducciones al obrero
SELECT c.cedula, c.nombre, c.apellido1, cdo.montoCCSS, cdo.montoBancoPopular, cdo.montoAsocSolidarista, cir.monto as montoImpRenta, hs.salarioBruto, hs.salarioNeto
FROM Colaborador c 
INNER JOIN CampoDeduccionObr cdo ON c.cedula = cdo.cedula
INNER JOIN CampoIR cir ON c.cedula = cir.cedula AND cdo.reporteId = cir.reporteId
INNER JOIN HistoricoSalario hs ON c.cedula = hs.cedula AND cdo.reporteId = hs.reporteId
WHERE cdo.reporteId = 9;

-- total salario bruto
SELECT SUM(salarioBruto)
FROM Colaborador;

-- visualizacion del total de deducciones patronales en un reporte
SELECT totalCCSS, totalAguinaldo, totalCesantia, totalVacaciones, totalINS
FROM CampoDeduccionPat
WHERE reporteId = 9;

-- reportes registrados
SELECT * 
FROM reporte;