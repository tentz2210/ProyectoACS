CREATE TABLE Departamento (
	departamentoId SMALLINT NOT NULL,
    nombre VARCHAR(50),
    PRIMARY KEY(departamentoId)
);

CREATE TABLE Colaborador (
	cedula VARCHAR(10) NOT NULL,
	departamentoId SMALLINT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    celular INT,
    email VARCHAR(320),
    salarioBruto DOUBLE NOT NULL,
    contribucionAsociacion FLOAT NOT NULL,
    activo TINYINT DEFAULT TRUE,
    PRIMARY KEY(cedula),
    FOREIGN KEY(departamentoId) REFERENCES Departamento(departamentoID)
);

CREATE TABLE HistoricoDespido (
	despidoId INT NOT NULL,
    cedula VARCHAR(10) NOT NULL,
    fecha DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY(despidoId),
    FOREIGN KEY(cedula) REFERENCES Colaborador(cedula)
);

CREATE TABLE Reporte (
	reporteId INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL DEFAULT (CURRENT_DATE),
	PRIMARY KEY(reporteId)
);

CREATE TABLE HistoricoSalario (
	cedula VARCHAR(10) NOT NULL,
    reporteId INT NOT NULL,
    salarioBruto DOUBLE NOT NULL,
    salarioNeto DOUBLE NOT NULL,
	PRIMARY KEY(cedula, reporteId),
    FOREIGN KEY(cedula) REFERENCES Colaborador(cedula),
    FOREIGN KEY(reporteId) REFERENCES Reporte(reporteId)
);

CREATE TABLE Deduccion (
	deduccionId INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    porcentaje FLOAT NOT NULL,
    PRIMARY KEY(deduccionId)
);

CREATE TABLE CampoDeduccionObr (
	campoDeduccionObrId INT NOT NULL AUTO_INCREMENT,
    cedula VARCHAR(10) NOT NULL,
    reporteId INT NOT NULL,
    montoCCSS DOUBLE NOT NULL,
    montoBancoPopular DOUBLE NOT NULL,
    montoAsocSolidarista DOUBLE NOT NULL,
    PRIMARY KEY(campoDeduccionObrId),
    FOREIGN KEY(cedula) REFERENCES Colaborador(cedula),
    FOREIGN KEY(reporteId) REFERENCES Reporte(reporteId)
);

CREATE TABLE CampoDeduccionPat (
	campoDeduccionPatId INT NOT NULL AUTO_INCREMENT,
    reporteId INT NOT NULL,
    totalCCSS DOUBLE NOT NULL,
    totalAguinaldo DOUBLE NOT NULL,
    totalCesantia DOUBLE NOT NULL,
    totalVacaciones DOUBLE NOT NULL,
    totalINS DOUBLE NOT NULL,
    PRIMARY KEY(campoDeduccionPatId),
    FOREIGN KEY(reporteId) REFERENCES Reporte(reporteId)
);

CREATE TABLE CampoIR (
	campoIRId INT NOT NULL AUTO_INCREMENT,
    cedula VARCHAR(10) NOT NULL,
    reporteId INT NOT NULL,
    monto DOUBLE,
    PRIMARY KEY(campoIRId),
    FOREIGN KEY(cedula) REFERENCES Colaborador(cedula),
    FOREIGN KEY(reporteId) REFERENCES Reporte(reporteId)
);
