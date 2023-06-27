USE clinica;

-- Creación de la tabla "User"
CREATE TABLE IF NOT EXISTS User (
    id int(20) NOT NULL AUTO_INCREMENT,
    username varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY username (username)
);


-- Creación de usuarios:

-- Se crean dos usuarios utilizando la sintaxis CREATE USER. 
-- Los nombres de los usuarios son usuario_lectura y usuario_lectura_escritura. 
-- Los usuarios se identifican mediante una contraseña que se especifica con la cláusula IDENTIFIED BY.
-- El primer usuario, usuario_lectura, se creó para tener permisos de solo lectura en todas las tablas de la base de datos. 
-- El segundo usuario, usuario_lectura_escritura, se creó para tener permisos de lectura, inserción y modificación de datos en todas las tablas de la base de datos.

CREATE USER usuario_lectura IDENTIFIED BY 'user_lectura'; -- Usuario de solo lectura
CREATE USER usuario_lectura_escritura IDENTIFIED BY 'user_lectura_escritura'; -- Usuario de lectura, inserción y modificación


-- Asignar permisos a los usuarios:

-- Se asignaron los permisos correspondientes a cada usuario utilizando la sintaxis GRANT. 
-- Para el usuario usuario_lectura, se le otorgó el permiso de SELECT (lectura) en todas las tablas de la base de datos. 
-- Para el usuario usuario_lectura_escritura, se le otorgaron los permisos de SELECT, INSERT y UPDATE (lectura, inserción y modificación) en todas las tablas de la base de datos.

-- Asignar permisos al usuario de solo lectura
GRANT SELECT ON clinica.* TO usuario_lectura; -- Permisos de solo lectura en todas las tablas de la base de datos

-- Asignar permisos al usuario de lectura, inserción y modificación
GRANT SELECT, INSERT, UPDATE ON clinica.* TO usuario_lectura_escritura; -- Permisos de lectura, inserción y modificación en todas las tablas de la base de datos


-- Revocar permisos de eliminación a ambos usuarios (ninguno podrá eliminar registros):

-- Se revocaron los permisos de eliminación (DELETE) para ambos usuarios utilizando la sintaxis REVOKE. 
-- Esto asegura que ninguno de los usuarios pueda eliminar registros de ninguna tabla en la base de datos.

REVOKE DELETE ON clinica.* FROM usuario_lectura;
REVOKE DELETE ON clinica.* FROM usuario_lectura_escritura;

-- Con esta revocación, los usuarios solo pueden realizar operaciones de lectura, inserción y modificación, pero no tienen permisos para eliminar registros.