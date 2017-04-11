Procedimientos Centros:

--lista de todos los centros
--busqueda de centro por id
--busqueda del centro por nombre
--busqueda de centros por provincia
--Buscar id de centro a partir de nombre teniendo en cuenta que no hay 
mas de un centro con el mismo nombre

Procedimientos trabajadores:

--lista trabajadores de un centro
--seleccionar un trabajador por dni
--seleccionar un trabajador por nombre +apellidos
--seleccionar un trabajador por ID
--Buscar el id de un trabajador por dni
--buscar id del trabajador a partir de nombre+apellidos
--busqueda de trabajadores de logistica
--busqueda de trabajadores por administrativo
--busqueda de trabajadores con parte abiertos
--busqueda trabajadores con partes cerrados
--busqueda de usuario de un trabajador//esta es de usuarios, no de trabajadores
--si es de logistica o administrativo a través de id trabajador

--CENTROS--

--lista de centros 
CREATE OR REPLACE PROCEDURE listaCentros (c OUT SYS_REFCURSOR)
IS 
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
open c for
SELECT *FROM centros;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos; 
WHEN OTHERS THEN RAISE otras;
END listaCentro;

--busqueda del centro por id
CREATE OR REPLACE PROCEDURE seleccionarCentroPorId (id_cen IN CENTROS.ID%TYPE, linea OUT centros%ROWTYPE)
IS 
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
SELECT * INTO linea FROM centros where ID = id_cen;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos; 
WHEN OTHERS THEN RAISE otras;
END seleccionarCentroPorId;

--busqueda por nombre de centro
CREATE OR REPLACE PROCEDURE seleccionarCentroPorNombre (nom IN CENTROS.Nombre%TYPE c OUT SYS_REFCURSOR)
IS BEGIN
sinDatos EXCEPTION;
otras EXCEPTION;
Open c for
SELECT  * FROM centros where Nombre = nom;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHRES THEN RAISE otras;
END seleccionarCentroPorNombre;

--busqueda de centros por provincia
CREATE OR REPLACE PROCEDURE seleccionarCentroPorProv (provin IN TRABAJADORES.Provincia%TYPE, c OUT SYS_REFCURSOR)
IS 
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
Open c for
SELECT * FROM centros where Provincia = provin;
EXCEPTION
WHEN NO_DATE_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END seleccionarCentroPorProv;

--Buscar id de centro a partir de nombre teniendo en cuenta que no hay 
mas de un centro con el mismo nombre
CREATE OR REPLACE PROCEDURE seleccionarIdCentroPorNombre (nom IN TRABAJADORES.Nombre%TYPE, id_cent OUT CENTROS.id%TYPE)
IS 
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
SELECT ID INTO id_cen FROM centros where nombre = nom;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sin Datos;
WHEN OTHERS THEN RAISE otras; 
END seleccionarIdCentroPorNombre;


PACKAGE




CREATE OR REPLACE PACKAGE CENTROS 
IS
	PROCEDURE seleccionarIdCentroPorNombre (nom IN TRABAJADORES.Nombre%TYPE, 	id_cent OUT CENTROS.id%TYPE);
	PROCEDURE seleccionarCentroPorProv (provin IN TRABAJADORES.Provincia%TYPE, 	c OUT SYS_REFCURSOR);
	CREATE OR REPLACE PROCEDURE seleccionarCentroPorNombre (nom IN 	CENTROS.Nombre%TYPE c OUT SYS_REFCURSOR);
	PROCEDURE seleccionarCentroPorId (id_cen IN CENTROS.ID%TYPE, linea OUT 	centros%ROWTYPE);
	PROCEDURE listaCentros (c OUT SYS_REFCURSOR);

END;

CREATE OR REPLACE PACKAGE BODY CENTROS
IS

	PROCEDURE seleccionarIdCentroPorNombre (nom IN TRABAJADORES.Nombre	%TYPE, id_cent OUT CENTROS.id%TYPE)
	IS 
	sinDatos EXCEPTION;
	otras EXCEPTION;
	BEGIN
	SELECT ID INTO id_cen FROM centros where nombre = nom;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN RAISE sin Datos;
	WHEN OTHERS THEN RAISE otras; 
	END seleccionarIdCentroPorNombre;

	PROCEDURE seleccionarCentroPorProv (provin IN TRABAJADORES.Provincia%TYPE, 	c OUT SYS_REFCURSOR)
	IS 
	sinDatos EXCEPTION;
	otras EXCEPTION;
	BEGIN
	Open c for
	SELECT * FROM centros where Provincia = provin;
	EXCEPTION
	WHEN NO_DATE_FOUND THEN RAISE sinDatos;
	WHEN OTHERS THEN RAISE otras;
	END seleccionarCentroPorProv;

	PROCEDURE seleccionarCentroPorNombre (nom IN CENTROS.Nombre%TYPE c OUT 	SYS_REFCURSOR)
	IS BEGIN
	sinDatos EXCEPTION;
	otras EXCEPTION;
	Open c for
	SELECT  * FROM centros where Nombre = nom;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN RAISE sinDatos;
	WHEN OTHRES THEN RAISE otras;
	END seleccionarCentroPorNombre;

	PROCEDURE seleccionarCentroPorId (id_cen IN CENTROS.ID%TYPE, linea OUT 	centros%ROWTYPE)
	IS 
	sinDatos EXCEPTION;
	otras EXCEPTION;
	BEGIN
	SELECT * INTO linea FROM centros where ID = id_cen;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN RAISE sinDatos; 
	WHEN OTHERS THEN RAISE otras;
	END seleccionarCentroPorId;

 	PROCEDURE listaCentros (c OUT SYS_REFCURSOR)
	IS 
	sinDatos EXCEPTION;
	otras EXCEPTION;
	BEGIN
	open c for
	SELECT *FROM centros;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN RAISE sinDatos; 
	WHEN OTHERS THEN RAISE otras;
	END listaCentro;

END;

--TRABAJADORES

--lista trabajadores de un centro
CREATE OR REPLACE PROCEDURE listaTrabajadoresPorCentro( id_centro 
IN NUMBER, c OUT SYSREFCURSOR)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
Open c for 
SELECT * FROM TRABAJADORES
WHERE CENTROS_ID = id_centro;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END listaTrabajadoresPorCentro;

--seleccionar un trabajador por dni
CREATE OR REPLACE PROCEDURE listaTrabajadoresPorDni( dni_trab IN 
TRABAJADORES.dni%TYPE, linea OUT  trabajadores%ROWTYPE)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
SELECT * INTO linea FROM TRABAJADORES
WHERE dni = dni_trab;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END listaTrabajadoresPorDni;

--seleccionar un trabajador por nombre +apellidos
CREATE OR REPLACE PROCEDURE 
listaTrabajadoresPorNomApe( nombre_trab IN TRABAJADORES.Nombre%TYPE,primerApellido_trab IN TRABAJADORES.primerApellido%TYPE,
 segundoApellido_trab IN TRABAJADORES.segundoApellido%TYPE,c OUT SYSREFCURSOR)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
Open c
SELECT * FROM TRABAJADORES
WHERE nombre = nombre_trab AND primerApellido = 
primerApellido_trab AND segundoApellido=segundoApellido_trab;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END listaTrabajadoresPorNomApe;


--seleccionar un trabajador por ID
CREATE OR REPLACE PROCEDURE seleccionarTrabajadorPorId (id_trab IN
OUT TRABAJADORES.ID%TYPE, linea OUT TRABAJADORES%ROWTYPE)
BEGIN
IS
sinDatos EXCEPTION;
otras EXCEPTION;
SELECT * INTO linea FROM TRABAJADORES;
WHERE ID = id_trab
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END seleccionarTrabajadorPorId;

--Buscar el id de un trabajador por dni
CREATE OR REPLACE PROCEDURE buscarIdTrabajadorPorDni( dni_trab IN TRABAJADORES.dni%TYPE, id_trab OUT TRABAJADORES.id%TYPE)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
SELECT ID INTO id_trab FROM TRABAJADORES
WHERE dni = dni_trab;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END buscarIdTrabajadorPorDni;

--buscar id del trabajador a partir de nombre+apellidos
CREATE OR REPLACE PROCEDURE 
buscarIdTrabajadorPorNomApe( nombre_trab IN TRABAJADORES.Nombre%TYPE ,primerApellido_trab IN TRABAJADORES.primerApellido%TYPE, segundoApellido_trab IN TRABAJADORES.segundoApellido%TYPE,
id_trab OUT TRABAJADORES.id%TYPE )
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
SELECT ID INTO id_trab FROM TRABAJADORES
WHERE nombre = nombre_trab AND primerApellido = 
primerApellido_trab AND segundoApellido=segundoApellido_trab;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END buscarIdTrabajadorPorNomApe;

--listra trabajadores de losgistica
CREATE OR REPLACE PROCEDURE listaLogistica(c OUT SYSREFCURSOR )
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
c open for
SELECT * c from Trabajadores where categoria is ‘Losgistica’;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END listaLogistica;

--lista trabajadores de administrativo

CREATE OR REPLACE PROCEDURE listaAdministracion (c OUT SYS_REFCURSOR)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
BEGIN
c open for
SELECT* c from Trabajadores WHERE categoria is ‘Administracion’;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos,
WHEN OTHERS THEN RAISE otras;
END listaAdmnistracion;

--busqueda de trabajadores con parte abiertos

CREATE OR REPLACE PROCEDURA listaTrabajadoresParteAbierto (c OUT SYS_REFCURSOR)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
SELECT ID, t.Nombre, t.primerApellido, t.segundoApellido, p.estado FROM TRABAJADORES t, PARTE p  WHERE  p.ESTADO=’Abierto’;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE sinDatos;
WHEN OTHERS THEN RAISE otras;
END listaTrabajadoresParteAbierto;

--busqueda de trabajadores con parte abiertos

CREATE OR REPLACE PROCEDURE listaTrabajadoresParteCerrado (c OUT SYS_REFCURSOR)
IS
sinDatos EXCEPTION;
otras EXCEPTION;
SELECT ID, t.Nombre, t.primerApellido, t.segundoApellido, p.estado FROM TRABAJADORES t, PARTE p  WHERE  p.ESTADO=’Cerrado’;
EXCEPTION
WHEN NO_DATA_FOUND RAISE sinDatos;
WHEN OTHERS THEN RAISEotras;
END listaTrabajadoresParteCerrado;

--si es de logistica o administrativo a través de id trabajador

CREATE OR REPLACE PROCEDURE categoriaDeUnTrabajador(id_trab IN TRABAJADORES.ID%TYPE, cat OUT TRABAJADORES.Categoria%TYPE)
IS
BEGIN
sinDatos EXCEPTION;
otros EXCEPTION;
SELECT Categoria FROM TRABAJADORES WHERE Categoria=cat;
EXCEPTION
WHEN NO_DATA_FOUND THEN sinDatos;
WHEN OTHERS THEN otros;
END categoriaDeUnTrabajador;

--USUARIOS--

--busqueda de usuario de un trabajador

CREATE OR REPLACE PROCEDURE userDeUnTrabajador ( id_trab IN TRABAJADOR.ID%TYPE, user_trab OUT USUARIOS.usuario%TYPE)
IS
BEGIN
sinDatos EXCEPTION;
otros EXCEPTION;
SELECT Usuario FROM USUARIOS WHERE TRABAJADORES_ID = id_trab;
EXCEPTION
WHEN NO_DATA_FOUND THEN sinDatos;
WHEN OTHERS THEN otros;
END userDeUnTrabajador;

