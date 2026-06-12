CREATE DATABASE EmpresaSQL;
GO

USE EmpresaSQL;
GO

CREATE TABLE TDepartamento (
    nDepartamentoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreDepartamento VARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE TCargo (
    nCargoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreCargo VARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE TEmpleado (
    nEmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    cNIF VARCHAR(20) UNIQUE,
    cNombre VARCHAR(50),
    cApellido VARCHAR(50),
    nDepartamentoID INT,
    nCargoID INT,
    dFechaContratacion DATE DEFAULT GETDATE(),
    nSalario DECIMAL(10,2),
    CONSTRAINT CK_Empleado_Salario CHECK (nSalario > 300),
    CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (nDepartamentoID) REFERENCES TDepartamento(nDepartamentoID),
    CONSTRAINT FK_Empleado_Cargo FOREIGN KEY (nCargoID) REFERENCES TCargo(nCargoID)
);
GO

CREATE TABLE TProyecto (
    nProyectoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreProyecto VARCHAR(100) NOT NULL,
    dFechaInicio DATE NOT NULL,
    dFechaFinalizacion DATE
);
GO

CREATE TABLE TEmpleadoProyecto (
    nEmpleadoID INT,
    nProyectoID INT,
    PRIMARY KEY (nEmpleadoID, nProyectoID),
    FOREIGN KEY (nEmpleadoID) REFERENCES TEmpleado(nEmpleadoID),
    FOREIGN KEY (nProyectoID) REFERENCES TProyecto(nProyectoID)
);
GO

ALTER TABLE TEmpleado ADD cEmail VARCHAR(150);
GO

ALTER TABLE TEmpleado ADD cTelefono VARCHAR(15);
GO

ALTER TABLE TEmpleado ALTER COLUMN cNombre VARCHAR(100);
GO

ALTER TABLE TEmpleado ALTER COLUMN cApellido VARCHAR(100);
GO

ALTER TABLE TEmpleado ADD cDireccion VARCHAR(200);
GO

ALTER TABLE TEmpleado ADD nEdad INT;
GO

ALTER TABLE TEmpleado ADD CONSTRAINT CK_Empleado_Edad CHECK (nEdad BETWEEN 18 AND 65);
GO

ALTER TABLE TEmpleado ADD CONSTRAINT UQ_Empleado_Email UNIQUE (cEmail);
GO

ALTER TABLE TEmpleado ADD bActivo BIT DEFAULT 1;
GO

ALTER TABLE TEmpleado DROP COLUMN cDireccion;
GO

ALTER TABLE TEmpleado ALTER COLUMN cTelefono VARCHAR(20);
GO

ALTER TABLE TEmpleado ADD cGenero CHAR(1);
GO

ALTER TABLE TEmpleado ADD CONSTRAINT CK_Empleado_Genero CHECK (cGenero IN ('M', 'F'));
GO

ALTER TABLE TEmpleado ADD dFechaNacimiento DATE;
GO

CREATE TABLE TSucursal (
    nSucursalID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreSucursal VARCHAR(100)
);
GO

INSERT INTO TDepartamento (cNombreDepartamento) VALUES 
('Recursos Humanos'), 
('Tecnología'), 
('Ventas'), 
('Finanzas'), 
('Marketing');
GO

INSERT INTO TCargo (cNombreCargo) VALUES 
('Gerente'), 
('Desarrollador'), 
('Analista'), 
('Ejecutivo de Ventas'), 
('Asistente');
GO

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cEmail, cGenero) VALUES
('NIF-01', 'Ana', 'Gomez', 2, 2, 1500.00, 28, 'ana@test.com', 'F'),
('NIF-02', 'Luis', 'Perez', 3, 4, 1200.00, 35, 'luis@test.com', 'M'),
('NIF-03', 'Carlos', 'Ruiz', 1, 1, 2500.00, 42, 'carlos@test.com', 'M'),
('NIF-04', 'Maria', 'Lopez', 4, 3, 1800.00, 30, 'maria@test.com', 'F'),
('NIF-05', 'Jose', 'García', 2, 2, 1600.00, 26, 'jose@test.com', 'M'),
('NIF-06', 'Laura', 'Guzman', 5, 5, 400.00, 22, 'laura@test.com', 'F'),
('NIF-07', 'Pedro', 'Martinez', 3, 4, 1100.00, 38, 'pedro@test.com', 'M'),
('NIF-08', 'Sofia', 'Hernandez', 2, 2, 1550.00, 29, 'sofia@test.com', 'F'),
('NIF-09', 'Miguel', 'Torres', 4, 3, 1750.00, 40, 'miguel@test.com', 'M'),
('NIF-10', 'Eliminar', 'Usuario', 5, 5, 450.00, 25, 'eliminar@test.com', 'M');
GO

INSERT INTO TProyecto (cNombreProyecto, dFechaInicio, dFechaFinalizacion) VALUES
('Sistema Web', '2024-01-01', '2024-06-30'),
('Migracion Cloud', '2024-03-15', NULL),
('Campaña Publicitaria', '2024-05-01', '2024-12-31');
GO

INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES
(1, 1), (5, 1), (8, 1), (3, 2), (4, 2), (2, 3), (6, 3);
GO

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero) 
VALUES ('NIF-11', 'Elena', 'Rojas', 1, 5, 800.00, 31, 'F');
GO

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cEmail, cGenero) 
VALUES ('NIF-12', 'Raul', 'Vega', 2, 2, 1400.00, 27, 'raul.vega@test.com', 'M');
GO

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero, bActivo) 
VALUES ('NIF-13', 'Carmen', 'Luna', 3, 4, 1000.00, 33, 'F', NULL);
GO

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero) VALUES 
('NIF-14', 'Hugo', 'Silva', 4, 3, 1900.00, 45, 'M'),
('NIF-15', 'Diana', 'Mora', 5, 1, 2600.00, 39, 'F');
GO

BEGIN TRY
    INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario, nEdad) 
    VALUES ('ERR-01', 'Fallo', 'Test', 100.00, 25);
END TRY
BEGIN CATCH
    PRINT 'Error de validacion: El salario debe ser mayor a 300.';
END CATCH;
GO

UPDATE TEmpleado SET nSalario = nSalario * 1.10;
GO

UPDATE TEmpleado SET nSalario = nSalario * 1.20 WHERE nDepartamentoID = 3;
GO

UPDATE TEmpleado SET cEmail = 'nuevo.correo@test.com' WHERE nEmpleadoID = 1;
GO

UPDATE TEmpleado SET nCargoID = 1 WHERE nEmpleadoID = 2;
GO

UPDATE TEmpleado SET nDepartamentoID = 1 WHERE nEmpleadoID IN (4, 5);
GO

UPDATE TEmpleado SET bActivo = 0 WHERE nSalario < 500;
GO

UPDATE TProyecto SET dFechaFinalizacion = '2025-01-01' WHERE nProyectoID = 2;
GO

INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES (9, 3);
GO

DELETE FROM TEmpleadoProyecto WHERE nEmpleadoID = (SELECT nEmpleadoID FROM TEmpleado WHERE cNIF = 'NIF-10');
DELETE FROM TEmpleado WHERE cNIF = 'NIF-10';
GO

DELETE FROM TEmpleadoProyecto WHERE nEmpleadoID IN (SELECT nEmpleadoID FROM TEmpleado WHERE bActivo = 0);
DELETE FROM TEmpleado WHERE bActivo = 0;
GO

DELETE FROM TEmpleadoProyecto WHERE nProyectoID = 3;
DELETE FROM TProyecto WHERE nProyectoID = 3;
GO

DELETE FROM TEmpleadoProyecto WHERE nEmpleadoID = 1;
GO

INSERT INTO TDepartamento (cNombreDepartamento) VALUES ('Departamento Vacio');
DELETE FROM TDepartamento WHERE nDepartamentoID NOT IN (SELECT DISTINCT nDepartamentoID FROM TEmpleado WHERE nDepartamentoID IS NOT NULL);
GO

SELECT * FROM TEmpleado ORDER BY cApellido ASC;
GO

SELECT * FROM TEmpleado WHERE nSalario > 1000;
GO

SELECT * FROM TEmpleado WHERE bActivo = 1;
GO

SELECT * FROM TEmpleado WHERE YEAR(dFechaContratacion) = YEAR(GETDATE());
GO

SELECT e.cNombre, e.cApellido, d.cNombreDepartamento 
FROM TEmpleado e 
JOIN TDepartamento d ON e.nDepartamentoID = d.nDepartamentoID;
GO

SELECT e.cNombre, e.cApellido, c.cNombreCargo 
FROM TEmpleado e 
JOIN TCargo c ON e.nCargoID = c.nCargoID;
GO

SELECT e.cNombre, e.cApellido, p.cNombreProyecto 
FROM TEmpleado e 
JOIN TEmpleadoProyecto ep ON e.nEmpleadoID = ep.nEmpleadoID 
JOIN TProyecto p ON ep.nProyectoID = p.nProyectoID;
GO

SELECT d.cNombreDepartamento, COUNT(e.nEmpleadoID) AS CantidadEmpleados 
FROM TDepartamento d 
LEFT JOIN TEmpleado e ON d.nDepartamentoID = e.nDepartamentoID 
GROUP BY d.cNombreDepartamento;
GO

SELECT d.cNombreDepartamento, AVG(e.nSalario) AS SalarioPromedio 
FROM TDepartamento d 
JOIN TEmpleado e ON d.nDepartamentoID = e.nDepartamentoID 
GROUP BY d.cNombreDepartamento;
GO

SELECT d.cNombreDepartamento, MAX(e.nSalario) AS SalarioMaximo, MIN(e.nSalario) AS SalarioMinimo 
FROM TDepartamento d 
JOIN TEmpleado e ON d.nDepartamentoID = e.nDepartamentoID 
GROUP BY d.cNombreDepartamento;
GO

SELECT p.cNombreProyecto, COUNT(ep.nEmpleadoID) AS TotalAsignados 
FROM TProyecto p 
JOIN TEmpleadoProyecto ep ON p.nProyectoID = ep.nProyectoID 
GROUP BY p.cNombreProyecto 
HAVING COUNT(ep.nEmpleadoID) > 2;
GO

SELECT * FROM TEmpleado WHERE cApellido LIKE 'G%';
GO

SELECT * FROM TEmpleado ORDER BY nSalario DESC;
GO

SELECT TOP 3 * FROM TEmpleado ORDER BY nSalario DESC;
GO

SELECT * FROM TEmpleado WHERE nEdad BETWEEN 25 AND 40;
GO

SELECT COUNT(*) AS TotalEmpleadosActivos FROM TEmpleado WHERE bActivo = 1;
GO

SELECT COUNT(*) AS TotalProyectos FROM TProyecto;
GO

CREATE TABLE TCliente (
    nClienteID INT IDENTITY(1,1) PRIMARY KEY,
    cNIF VARCHAR(20) UNIQUE NOT NULL,
    cNombre VARCHAR(100) NOT NULL,
    cApellido VARCHAR(100) NOT NULL,
    cEmail VARCHAR(150) UNIQUE,
    cTelefono VARCHAR(20),
    cDireccion VARCHAR(255),
    bActivo BIT DEFAULT 1
);
GO

CREATE TABLE TProducto (
    nProductoID INT IDENTITY(1,1) PRIMARY KEY,
    cCodigo VARCHAR(50) NOT NULL UNIQUE,
    cNombre VARCHAR(150) NOT NULL,
    nPrecio DECIMAL(10,2) NOT NULL CHECK (nPrecio >= 0),
    nStock INT DEFAULT 0 CHECK (nStock >= 0),
    bActivo BIT DEFAULT 1
);
GO

CREATE TABLE TVenta (
    nVentaID INT IDENTITY(1,1) PRIMARY KEY,
    nClienteID INT NOT NULL,
    nEmpleadoID INT NOT NULL,
    nProductoID INT NOT NULL,
    dFechaVenta DATE DEFAULT GETDATE(),
    nMonto DECIMAL(10,2) CHECK (nMonto > 0),
    FOREIGN KEY (nClienteID) REFERENCES TCliente(nClienteID),
    FOREIGN KEY (nEmpleadoID) REFERENCES TEmpleado(nEmpleadoID),
    FOREIGN KEY (nProductoID) REFERENCES TProducto(nProductoID)
);
GO

INSERT INTO TCliente (cNIF, cNombre, cApellido, cEmail, cTelefono) VALUES
('CLI-01', 'Marcos', 'Díaz', 'marcos@test.com', '8888-0001'),
('CLI-02', 'Sandra', 'Reyes', 'sandra@test.com', '8888-0002'),
('CLI-03', 'Hugo', 'Flores', 'hugo@test.com', '8888-0003'),
('CLI-04', 'Luz', 'Blanco', 'luz@test.com', '8888-0004'),
('CLI-05', 'Pablo', 'Cruz', 'pablo@test.com', '8888-0005'),
('CLI-06', 'Rita', 'Mendez', 'rita@test.com', '8888-0006'),
('CLI-07', 'Diego', 'Vargas', 'diego@test.com', '8888-0007'),
('CLI-08', 'Rosa', 'Castro', 'rosa@test.com', '8888-0008'),
('CLI-09', 'Jorge', 'Ortiz', 'jorge@test.com', '8888-0009'),
('CLI-10', 'Sara', 'Nuñez', 'sara@test.com', '8888-0010'),
('CLI-11', 'Tito', 'Rojas', 'tito@test.com', '8888-0011'),
('CLI-12', 'Flor', 'Salas', 'flor@test.com', '8888-0012'),
('CLI-13', 'Aldo', 'Mora', 'aldo@test.com', '8888-0013'),
('CLI-14', 'Ines', 'Vega', 'ines@test.com', '8888-0014'),
('CLI-15', 'Omar', 'Soto', 'omar@test.com', '8888-0015'),
('CLI-16', 'Lia', 'Rios', 'lia@test.com', '8888-0016'),
('CLI-17', 'Ivan', 'Paz', 'ivan@test.com', '8888-0017'),
('CLI-18', 'Mia', 'Gil', 'mia@test.com', '8888-0018'),
('CLI-19', 'Leo', 'Lara', 'leo@test.com', '8888-0019'),
('CLI-20', 'Noa', 'Cano', 'noa@test.com', '8888-0020');
GO

INSERT INTO TProducto (cCodigo, cNombre, nPrecio, nStock) VALUES
('PROD-01', 'Laptop Dell Vostro', 850.00, 10),
('PROD-02', 'Monitor Samsung 24"', 150.00, 25),
('PROD-03', 'Teclado Mecánico', 45.00, 50),
('PROD-04', 'Mouse Inalámbrico', 25.00, 100),
('PROD-05', 'Disco Estado Sólido 1TB', 90.00, 30);
GO

DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO TVenta (nClienteID, nEmpleadoID, nProductoID, dFechaVenta, nMonto)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 18) + 1, 
        (SELECT TOP 1 nEmpleadoID FROM TEmpleado ORDER BY NEWID()), 
        (ABS(CHECKSUM(NEWID())) % 5) + 1,
        DATEADD(DAY, -(ABS(CHECKSUM(NEWID())) % 365), GETDATE()), 
        (ABS(CHECKSUM(NEWID())) % 2000) + 100 
    );
    SET @i = @i + 1;
END;
GO

UPDATE TVenta SET nMonto = nMonto * 0.90 WHERE nMonto > 1500;
GO

DELETE FROM TCliente WHERE nClienteID NOT IN (SELECT DISTINCT nClienteID FROM TVenta);
GO

SELECT TOP 5 c.cNombre, c.cApellido, SUM(v.nMonto) AS TotalCompras
FROM TCliente c
JOIN TVenta v ON c.nClienteID = v.nClienteID
GROUP BY c.nClienteID, c.cNombre, c.cApellido
ORDER BY TotalCompras DESC;
GO

SELECT MONTH(dFechaVenta) AS Mes, YEAR(dFechaVenta) AS Anio, SUM(nMonto) AS TotalVentasMes
FROM TVenta
GROUP BY YEAR(dFechaVenta), MONTH(dFechaVenta)
ORDER BY Anio DESC, Mes DESC;
GO

SELECT c.cNombre, c.cApellido, AVG(v.nMonto) AS PromedioCompras
FROM TCliente c
JOIN TVenta v ON c.nClienteID = v.nClienteID
GROUP BY c.nClienteID, c.cNombre, c.cApellido;
GO

SELECT 
    v.nVentaID, 
    v.dFechaVenta, 
    c.cNombre + ' ' + c.cApellido AS Cliente, 
    e.cNombre + ' ' + e.cApellido AS Empleado, 
    d.cNombreDepartamento AS DepartamentoVendedor,
    v.nMonto
FROM TVenta v
JOIN TCliente c ON v.nClienteID = c.nClienteID
JOIN TEmpleado e ON v.nEmpleadoID = e.nEmpleadoID
JOIN TDepartamento d ON e.nDepartamentoID = d.nDepartamentoID;
GO

ALTER TABLE TEmpleado DROP CONSTRAINT CK_Empleado_Edad;
GO

ALTER TABLE TEmpleado DROP CONSTRAINT UQ_Empleado_Email;
GO

ALTER TABLE TEmpleado ADD CONSTRAINT CK_Empleado_Edad CHECK (nEdad BETWEEN 18 AND 65);
GO

ALTER TABLE TEmpleado ADD CONSTRAINT UQ_Empleado_Email UNIQUE (cEmail);
GO

DROP TABLE TVenta;
GO

DROP TABLE TCliente;
GO

DROP TABLE TProducto;
GO

DROP TABLE TEmpleadoProyecto;
GO

DROP TABLE TProyecto;
GO

ALTER TABLE TEmpleado DROP CONSTRAINT FK_Empleado_Departamento;
GO

ALTER TABLE TEmpleado DROP CONSTRAINT FK_Empleado_Cargo;
GO

DROP TABLE TEmpleado;
GO

DROP TABLE TCargo;
GO

DROP TABLE TDepartamento;
GO

DROP TABLE TSucursal;
GO

USE master;
GO

DROP DATABASE EmpresaSQL;
GO