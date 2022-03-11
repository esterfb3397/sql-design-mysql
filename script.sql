/*-----------------------------------------------------------------------------------
Esther Fernández Barchín
Nombre de la base de datos: tiendaMovil
-----------------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------------
 Definición de la estructura de la base de datos
 -----------------------------------------------------------------------------------*/

-- Creación de la base de datos --

drop DATABASE IF EXISTS tiendaMovil;
CREATE database tiendaMovil;
use tiendaMovil;

-- Tablas de entidades

CREATE TABLE tienda(
   nombreTienda VARCHAR(40) PRIMARY KEY,
   gestion VARCHAR(40) NOT NULL,
   paginaWeb VARCHAR(40)
);
   
CREATE TABLE empresa(
	nombreEmpresa VARCHAR(40) PRIMARY KEY,
    paisImpuestos CHAR(40) NOT NULL,
    paginaWeb VARCHAR(50),
    fechaCreacion DATE NOT NULL,
    mail VARCHAR(40)
);

CREATE TABLE empleado(
	dni CHAR(9),
    nombre VARCHAR(40),
    primerApellido VARCHAR(40),
    mail VARCHAR(40),
    telefono CHAR(12),
    calle VARCHAR(20),
    numeroCalle NUMERIC(4),
    cp CHAR(5),
    PRIMARY KEY (dni)
);

CREATE TABLE usuario(
	numeroCuenta NUMERIC(8),
    nombreUsuario VARCHAR(40),
    movil CHAR(15) NOT NULL,
    calle VARCHAR(40),
    numeroCalle NUMERIC(4),
    cp CHAR(5),
    ciudad VARCHAR(20),
    pais VARCHAR(20) NOT NULL,
    PRIMARY KEY (numeroCuenta)
);
    
CREATE TABLE aplicacion(
    codigoAplicacion CHAR(10) PRIMARY KEY,
	nombreAplicacion VARCHAR(40) UNIQUE,
    fechaInicio DATE,
    fechaFinalizacion DATE,
    memoriaMB DECIMAL(4,2),
    categoria CHAR(20),
    precio DECIMAL(4,2),
    nombreEmpresa VARCHAR(40),
    dniLider CHAR(9),
	FOREIGN KEY (nombreEmpresa) REFERENCES empresa(nombreEmpresa)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY (dniLider) REFERENCES empleado(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Tablas de relaciones --

CREATE TABLE descarga(
	numeroCuenta NUMERIC(8),
    codigoAplicacion CHAR(10),
    movil CHAR(15) NOT NULL,
    fechaDescarga DATE,
    PRIMARY KEY (numeroCuenta,codigoAplicacion),
    FOREIGN KEY (numeroCuenta) REFERENCES usuario(numeroCuenta)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY (codigoAplicacion) REFERENCES aplicacion(codigoAplicacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE tiendaAplicacion(
	nombreTienda VARCHAR(40),
    codigoAplicacion CHAR(10),
    PRIMARY KEY (nombreTienda,codigoAplicacion),
    FOREIGN KEY (nombreTienda) REFERENCES tienda(nombreTienda)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (codigoAplicacion) REFERENCES aplicacion(codigoAplicacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE puntuacion(
	numeroCuenta NUMERIC(8),
	codigoAplicacion CHAR(10),
    puntuacion DECIMAL(4,2),
    fecha DATE,
    PRIMARY KEY(numeroCuenta,codigoAplicacion),
    FOREIGN KEY(numeroCuenta) REFERENCES usuario(numeroCuenta)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY(codigoAplicacion) REFERENCES aplicacion(codigoAplicacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
    
CREATE TABLE comentario(
    comentarioId int AUTO_INCREMENT PRIMARY KEY,
    numeroCuenta NUMERIC(8),
    codigoAplicacion CHAR(10),
    comentario TEXT,
    fecha DATE,
    FOREIGN KEY (numeroCuenta) REFERENCES usuario(numeroCuenta)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (codigoAplicacion) REFERENCES aplicacion(codigoAplicacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE creacionAplicacion(
	dni CHAR(9),
    codigoAplicacion CHAR(10),
    PRIMARY KEY (dni,codigoAplicacion),
    FOREIGN KEY (dni) REFERENCES empleado(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY(codigoAplicacion) REFERENCES aplicacion(codigoAplicacion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
    
CREATE TABLE trabajoEmpresa(
    trabajoEmpresaId int AUTO_INCREMENT PRIMARY KEY,
    dni CHAR(9),
	nombreEmpresa VARCHAR(40),
    fechaInicioTrabajo DATE,
    fechaFinTrabajo DATE,
    FOREIGN KEY (nombreEmpresa) REFERENCES empresa(nombreEmpresa)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (dni) REFERENCES empleado(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/* ---------------------------------------------------------------------------------------
Inserción de datos
-----------------------------------------------------------------------------------------*/
-- Cargar datos en worbench --
-- Hay tres formas de hacerlo, la primera es mediante LOAD DATA ON FILE pero ha estado dando 
-- varios errores por lo que hemos cargado la tabla a traves del Import Table Wizard
-- También se puede añadir datos a traves de INSERT INTO, que lo haremos más adelante

-- 
/*----------------------------------------------------------------------------------------
Consultas,modificaciones,borrados y vistas con enunciado
------------------------------------------------------------------------------------------*/

-- Consulta 1: Veces en la que se ha descargado cada aplicación y fecha --


SELECT codigoAplicacion, count(*) AS VecesDescargadas, fechaDescarga FROM descarga
GROUP BY codigoAplicacion
HAVING count(*) > 1;

-- Consulta 2: Fecha en la que se descarga mayor número de Aplicaciones --

SELECT fechaDescarga, count(*) AS NumeroDescargas FROM descarga
GROUP BY codigoAplicacion
HAVING count(*) > 1
LIMIT 1;

-- Consulta 3. Los países de los usuarios que más aplicaciones han descargado --

SELECT  u.pais, count(*) AS VecesDescargadas
FROM usuario AS u INNER JOIN descarga AS des ON u.numeroCuenta = des.numeroCuenta
GROUP BY pais
HAVING count(*) > 1
ORDER BY  VecesDescargadas DESC;


-- Consulta 4. La puntuación media de cada una de las aplicaciones --

-- Como no todas las apps están puntuadas vamos a hacer un INSERT INTO con nuevos datos
-- para las aplicaciones que estan sin puntuar

INSERT INTO puntuacion VALUES ('3577','102','4.0','2021-12-30');
INSERT INTO puntuacion VALUES ('1071','103','2.0','2021-12-30');
INSERT INTO puntuacion VALUES ('3601','104','4.1','2021-12-30');
INSERT INTO puntuacion VALUES ('3944','105','4.2','2021-12-30');
INSERT INTO puntuacion VALUES ('2792','106','5.0','2021-12-30');
INSERT INTO puntuacion VALUES ('2196','107','2.6','2021-12-30');
INSERT INTO puntuacion VALUES ('3613','108','4.7','2021-12-30');
INSERT INTO puntuacion VALUES ('3007','109','4.1','2021-12-30');
INSERT INTO puntuacion VALUES ('2137','110','4.2','2021-12-30');



SELECT  a.codigoAplicacion, a.nombreAplicacion, AVG(puntuacion)AS MediaPuntuadaPorAplicacion
FROM aplicacion AS a INNER JOIN puntuacion AS pu ON a.codigoAplicacion = pu.codigoAplicacion
GROUP BY nombreAplicacion
ORDER BY MediaPuntuadaPorAplicacion desc;

-- Vista 1 --
-- En esta vista queremos crear una nueva tabla para poder ver ver que empleados trabajan en cada empresa y la experiencia que tienen en cada una

CREATE VIEW trabajoresEmpresa (nombreEmpresa,idTrabajador, nombre, apellido,fechaInicioTrabajo,
fechaFinTrabajo) AS
SELECT  tra.nombreEmpresa,em.dni, em.nombre,em.primerApellido,tra.fechaInicioTrabajo,tra.fechaFinTrabajo
FROM empleado AS em INNER JOIN trabajoEmpresa AS tra ON em.dni = tra.dni;

-- Consulta 5. Ver cuantos empleados trabajan en cada empresa --

SELECT nombreEmpresa,count(*) as trabajadoresxEmpresa
FROM tiendaMovil.trabajoresEmpresa
GROUP BY nombreEmpresa;

-- Consulta 6. ¿Quién trabaja en CDC? ¿Cúal es su experiencia? --

SELECT nombreEmpresa,idTrabajador, nombre, apellido,TIMESTAMPDIFF(YEAR,fechaInicioTrabajo,fechaFinTrabajo) AS experiencia
FROM tiendaMovil.trabajoresEmpresa
WHERE nombreEmpresa = 'CDC'
ORDER BY experiencia DESC;

-- Consulta 7. ¿ Cuál es el nombre de quién dirige la creación de cada una de las aplicaciones? --

SELECT  nombreAplicacion,dniLider, nombre as nombreLider
FROM aplicacion AS a LEFT JOIN empleado AS e ON a.dniLider = e.dni;

-- Consulta 8. ¿ Cuál es la aplicación más cara? --

SELECT codigoAplicacion, nombreAplicacion,precio
FROM aplicacion
WHERE precio = (select max(precio) from aplicacion );

-- Consulta 9. ¿Cómo distribuyen las aplicaciones en categorias?--
SELECT categoria, count(*) as mismaCategoria
FROM aplicacion
GROUP BY categoria;

-- Consulta 10. ¿Cuáles son las empresas que crean menos aplicaciones?--
SELECT  nombreEmpresa, count(*) as creacionAplicaciones
FROM aplicacion
GROUP BY nombreEmpresa
HAVING creacionAplicaciones < 2;

-- Consulta 11. Nombre de las tiendas que suben las Aplicaciones --
SELECT ti.nombreTienda, a.nombreAplicacion
FROM tiendaAplicacion as ti RIGHT JOIN aplicacion as a
ON ti.codigoAplicacion = a.codigoAplicacion;

-- Consulta 12.Usuarios que NO han descargado una aplicación --

-- Para esta consulta tenemos que inventarnos un nuevo usuario pero que no va a estar
-- en la tabla descargas

INSERT INTO usuario VALUES('3894', 'efdezbarchin', '640 523 144', 'Calle Olimpia', '20', '28234', 'Madrid', 'España' );

SELECT u.numeroCuenta,u.nombreUsuario
FROM usuario as u LEFT JOIN descarga as des ON u.numeroCuenta = des.numeroCuenta
WHERE des.numeroCuenta IS NULL;

-- Consulta 13. De los que han creado Aplicaciones, ¿había alguno que dirige?

SELECT a.dniLider
FROM creacionAplicacion as cre LEFT JOIN aplicacion
ON cre.dni = a.dniLider ;

-- Consulta 14. Cuando los usuarios puntuan, ¿cuál es la puntuación más reciente a fecha de hoy?
-- (calculado en meses) --
-- hay una formula que no me ha salido en donde puedes comparar la fecha que está en base de datos
-- con now(), asi que como alternativa he escogido la forma fácil

SELECT numeroCuenta, puntuacion,fecha, TIMESTAMPDIFF(MONTH,fecha,CURDATE()) as meses
FROM puntuacion
HAVING meses < 7
ORDER BY fecha;

-- Consulta 15.Nombre de las empresas en las que trabajan  más de 3 empleados --


SELECT nombreEmpresa, count(*) as trabajanPorEmpresa
FROM trabajoEmpresa
GROUP BY nombreEmpresa
HAVING trabajanPorEmpresa > 3;

/*---------------------------------------------------------------------------------------------
Trigger 
----------------------------------------------------------------------------------------------
El trigger será de update, ya que dos usuarios han comentado las aplicaciones recientemente por lo
que necesitaremos actualizar la tabla llamada comentario */

delimiter //
DROP TRIGGER IF EXISTS nuevoComentario;
 CREATE TRIGGER  nuevoComentario BEFORE UPDATE ON comentario FOR EACH ROW
  BEGIN
    INSERT INTO  comentario VALUES (new.comentarioId,new.numeroCuenta,new.codigoAplicacion,new.comentario,now());
   
END //
INSERT INTO comentario(numeroCuenta,codigoAplicacion,comentario) VALUES ('3601', '101', 'Good');
INSERT INTO comentario(numeroCuenta,codigoAplicacion,comentario) VALUES ('1071', '101', 'Bad');

