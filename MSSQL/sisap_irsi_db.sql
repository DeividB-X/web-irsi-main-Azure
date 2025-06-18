CREATE DATABASE sisap_irsi_db;

USE sisap_irsi_db;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(255) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(50) NOT NULL CHECK (role IN ('admin', 'director', 'consulta')),
    two_factor_code NVARCHAR(6),
    two_factor_expiry DATETIME
);

-- Tabla Estudiantes
CREATE TABLE Estudiantes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    apellidos NVARCHAR(255) NOT NULL,
    pais NVARCHAR(100) NOT NULL,
    ciudad NVARCHAR(100) NOT NULL,
    senas_direccion NVARCHAR(500),
    grado_academico NVARCHAR(100) NOT NULL,
    dni NVARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(20),
    anio_solicitud INT NOT NULL
);

-- Índices
CREATE INDEX idx_dni ON Estudiantes(dni);
CREATE INDEX idx_username ON Usuarios(username);

-- Insertar un usuario de prueba
INSERT INTO Usuarios (username, password_hash, role)
VALUES ('test@example.com', '$2b$12$hqmlMHETNGRGX3tqFaHrz.81nRIG2VqvXBwo6V6.3dfSJs2/7XVIK', 'admin');

DELETE FROM Usuarios;

-- Verificar el usuario
SELECT * FROM Usuarios WHERE username = 'test@example.com';

-- Insertar un Nuevo Usuario con Rol consulta:
INSERT INTO Usuarios (username, password_hash, role)
VALUES ('consulta_user@example.com', '$2b$12$wF9XKqbN7WG2QCrarYxPzOwufTNC1C092X/NZMChYOK3mtPK/K3Jm', 'consulta');

-- borrar un usuario
DELETE FROM Usuarios
WHERE username = 'consulta_user@example.com';

-- Insertar un Nuevo Usuario con Rol director:
INSERT INTO Usuarios (username, password_hash, role)
VALUES ('director_user@example.com', '$2b$12$WHLBk6WjOu83JYPWJkZymuXbLub71K8S6s0gdrSGLFbhWdbgaPquO', 'director');

-- ver tablas
SELECT * FROM Usuarios;
SELECT * FROM Estudiantes;

-- Copias de Seguridad de la Base de Datos
BACKUP DATABASE [sisap_irsi_db]
TO DISK = 'C:\backups\sisap_irsi_db.bak'
WITH FORMAT, MEDIANAME = 'SisapBackups', NAME = 'Full Backup';


INSERT INTO Usuarios (username, password_hash, role)
VALUES ('consultor@gmail.com', '$2b$12$YQ5Mq648tYdJpwmUQYXFFe8sztPQdxwNcsGLIRyHQ1uQ5WcFETHMG', 'consulta');
