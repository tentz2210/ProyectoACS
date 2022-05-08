DELIMITER $$

-- generacion de reporte, proc principal
CREATE PROCEDURE sp_generarReporte()
BEGIN
	DECLARE reporteId INT;

	INSERT INTO Reporte(fecha) VALUES(now());
	SELECT LAST_INSERT_ID() INTO reporteId;
    
    CALL sp_calcObrero(reporteId);
    CALL sp_calcIR(reporteId);
    CALL sp_calcPatrono(reporteId);
    CALL sp_calcSalario(reporteId);
END$$

-- calculo obrero
CREATE PROCEDURE sp_calcObrero(IN pReporteId INT)
BEGIN
	DECLARE CCSS FLOAT;
    DECLARE bancoPopular FLOAT;
    
    SELECT porcentaje/100.0 INTO CCSS
    FROM Deduccion
    WHERE nombre = 'CCSS_obrero';
    
    SELECT porcentaje/100.0 INTO bancoPopular
    FROM Deduccion
    WHERE nombre = 'banco_popular';
    
    INSERT INTO CampoDeduccionObr(cedula, reporteId, montoCCSS, montoBancoPopular, montoAsocSolidarista)
		SELECT c.cedula as cedula,
			   pReporteId as reporteId,
               c.salarioBruto*CCSS as montoCCSS,
               c.salarioBruto*bancoPopular as montoBancoPopular,
               c.salarioBruto*(c.contribucionAsociacion/100.0) as montoAsocSolidarista
		FROM Colaborador as c;
END$$

-- calculo patrono
CREATE PROCEDURE sp_calcPatrono(IN pReporteId INT)
BEGIN
	DECLARE CCSS FLOAT;
    DECLARE Aguinaldo FLOAT;
    DECLARE Cesantia FLOAT;
    DECLARE Vacaciones FLOAT;
    DECLARE INS FLOAT;
    DECLARE SalarioTotal DOUBLE;
    
    SELECT porcentaje/100.0 INTO CCSS
    FROM Deduccion
    WHERE nombre = 'CCSS_patron';
    
    SELECT porcentaje/100.0 INTO Aguinaldo
    FROM Deduccion
    WHERE nombre = 'aguinaldo';
    
	SELECT porcentaje/100.0 INTO Cesantia
    FROM Deduccion
    WHERE nombre = 'cesantia';
    
    SELECT porcentaje/100.0 INTO Vacaciones
    FROM Deduccion
    WHERE nombre = 'vacaciones';
    
    SELECT porcentaje/100.0 INTO INS
    FROM Deduccion
    WHERE nombre = 'INS';
    
    SELECT SUM(salarioBruto) INTO SalarioTotal
    FROM Colaborador;
    
    INSERT INTO CampoDeduccionPat(reporteId, totalCCSS, totalAguinaldo, totalCesantia, totalVacaciones, totalINS)
    VALUES(pReporteId, SalarioTotal*CCSS, SalarioTotal*Aguinaldo, SalarioTotal*Cesantia, SalarioTotal*Vacaciones, SalarioTotal*INS);
END$$

-- calculo impuesto de renta
CREATE PROCEDURE sp_calcIR(IN pReporteId INT)
BEGIN
    INSERT INTO CampoIR(cedula, reporteId, monto)
		SELECT c.cedula as cedula,
			   pReporteId as reporteId,
               (
				CASE
					WHEN c.salarioBruto <= 863000
					THEN 0
        
					WHEN c.salarioBruto > 863000 AND c.salarioBruto <= 1267000
					THEN ((c.salarioBruto-863000)*(10/100.00))
				
					WHEN c.salarioBruto > 1267000 AND c.salarioBruto <= 2223000
					THEN ((1267000-863000)*(10/100.00)) + ((c.salarioBruto-1267000)*(15/100.00))
				
					WHEN c.salarioBruto > 2223000 AND c.salarioBruto <= 4445000
					THEN ((1267000-863000)*(10/100.00)) + ((2223000-1267000)*(15/100.00)) + ((c.salarioBruto-2223000)*(20/100.00))
				
					WHEN c.salarioBruto > 4445000
					THEN ((1267000-863000)*(10/100.00)) + ((2223000-1267000)*(15/100.00)) + ((4445000-2223000)*(20/100.00)) + ((c.salarioBruto-4445000)*(25/100.00))
			 END 
			) as monto
		FROM Colaborador as c;
END$$

-- historico de salario
CREATE PROCEDURE sp_calcSalario(IN pReporteId INT)
BEGIN
	INSERT INTO HistoricoSalario(cedula, reporteId, salarioBruto, salarioNeto)
		SELECT c.cedula, cdo.reporteId, c.salarioBruto, c.salarioBruto-(cdo.montoCCSS + cdo.montoBancoPopular + cdo.montoAsocSolidarista + cir.monto) as salarioNeto FROM Colaborador c 
		INNER JOIN (SELECT * FROM CampoDeduccionObr WHERE reporteId = pReporteId) cdo 
		ON c.cedula = cdo.cedula
        INNER JOIN (SELECT * FROM CampoIR WHERE reporteId = pReporteId) cir
		ON c.cedula = cir.cedula;
END$$

DELIMITER ;