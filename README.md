<h1 align="center">SQL</h1>

<p align="center"> 
    <img src="https://jobs.coderhouse.com/assets/logos_coderhouse.png" alt="CoderHouse"  height="100"/>
</p>

---

<br>

<p align="center"> 
<img src="https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/SQL_2019_Webpage_illustration_RE4r3wO:VP1-539x400?resMode=sharp2&op_usm=1.5,0.65,15,0&qlt=100&fit=constrain" alt="SQL" />

<br>

---

### Descripcion de la Base de Datos

<br>

```sh
La base de datos "clinica" es un esquema que almacena información relacionada con una clínica médica. A continuación, se describe cada una de las tablas que conforman esta base de datos:

Tabla "especialidadmedica":

Clave primaria: id (identificador único de la especialidad).
No tiene claves foráneas.
La clave primaria "id" se seleccionó como identificador único para cada especialidad médica, ya que garantiza la unicidad de cada registro.


Tabla "localidad":

Clave primaria: id (identificador único de la localidad).
No tiene claves foráneas.
La clave primaria "id" se seleccionó como identificador único para cada localidad, asegurando la unicidad de cada registro.


Tabla "medico":

Clave primaria: id (identificador único del médico).
Claves foráneas: especialidad_id, localidad_id (relacionadas con las tablas "especialidadmedica" y "localidad" respectivamente).
La clave primaria "id" se eligió como identificador único para cada médico.
Las claves foráneas "especialidad_id" y "localidad_id" se utilizan para establecer la relación entre el médico y su especialidad médica y localidad respectivamente.


Tabla "consultorios":

Clave primaria: id (identificador único del consultorio).
Clave foránea: medico_id (relacionada con la tabla "medico").
La clave primaria "id" se seleccionó como identificador único para cada consultorio.
La clave foránea "medico_id" se utiliza para establecer la relación entre el consultorio y el médico asignado a ese consultorio.


Tabla "obrasocial":

Clave primaria: id (identificador único de la obra social).
No tiene claves foráneas.
La clave primaria "id" se seleccionó como identificador único para cada obra social.


Tabla "persona":

Clave primaria: id (identificador único de la persona).
Claves foráneas: localidad_id, medico_cabecera_id, obra_social_id (relacionadas con las tablas "localidad", "medico" y "obrasocial" respectivamente).
La clave primaria "id" se eligió como identificador único para cada persona (paciente).
Las claves foráneas "localidad_id", "medico_cabecera_id" y "obra_social_id" se utilizan para establecer las relaciones entre la persona y su localidad, médico de cabecera y obra social respectivamente.


Tabla "turno":

Clave primaria: id (identificador único del turno).
Claves foráneas: doctor_id, paciente_id (relacionadas con las tablas "medico" y "persona" respectivamente).
La clave primaria "id" se seleccionó como identificador único para cada turno.
Las claves foráneas "doctor_id" y "paciente_id" se utilizan para establecer las relaciones entre el turno, el médico que atenderá el turno y la persona que tiene el turno asignado.


Tabla "empleado":

Clave primaria: id (identificador único del empleado).
Claves foráneas: localidad_id, obra_social_id (relacionadas con las tablas "localidad" y "obrasocial" respectivamente).
La clave primaria "id" se eligió como identificador único para cada empleado.
Las claves foráneas "localidad_id" y "obra_social_id" se utilizan para establecer las relaciones entre el empleado y su localidad y obra social respectivamente.


Tabla "vacaciones":

Clave primaria: id (identificador único de las vacaciones).
Clave foránea: empleado_id (relacionada con la tabla "empleado").
La clave primaria "id" se seleccionó como identificador único para cada registro de vacaciones.
La clave foránea "empleado_id" se utiliza para establecer la relación entre las vacaciones y el empleado que tomó esas vacaciones.


Tabla "vacaciones_medico":

Clave primaria: id (identificador único de las vacaciones del médico).
Clave foránea: medico_id (relacionada con la tabla "medico").
La clave primaria "id" se seleccionó como identificador único para cada registro de vacaciones médicas.
La clave foránea "medico_id" se utiliza para establecer la relación entre las vacaciones médicas y el médico que tomó esas vacaciones.


tabla "tratamiento":

Clave primaria: id (identificador único del tratamiento).
Clave foránea: paciente_id (relacionada con la tabla "persona").
La clave primaria "id" se seleccionó como identificador único para cada tratamiento.
La clave foránea "paciente_id" se utiliza para establecer la relación entre el tratamiento y el paciente que recibió el tratamiento.


tabla "diagnotico": 

Clave primaria: id (identificador único del diagnóstico).
Clave foránea: paciente_id (relacionada con la tabla "persona").
La clave primaria "id" se seleccionó como identificador único para cada diagnóstico.
La clave foránea "paciente_id" se utiliza para establecer la relación entre el diagnóstico y el paciente que recibió el diagnóstico.


tabla "tratamiento_medico":

Clave primaria: id (identificador único del tratamiento médico).
Claves foráneas: medico_id, tratamiento_id (relacionadas con las tablas "medico" y "tratamiento" respectivamente).
La clave primaria "id" se seleccionó como identificador único para cada tratamiento médico.
Las claves foráneas "medico_id" y "tratamiento_id" se utilizan para establecer las relaciones entre el tratamiento médico, el médico que realizó el tratamiento y el tratamiento realizado.


tabla "factura":

Clave primaria: id (identificador único de la factura).
Clave foránea: paciente_id (relacionada con la tabla "persona").
La clave primaria "id" se seleccionó como identificador único para cada factura.
La clave foránea "paciente_id" se utiliza para establecer la relación entre la factura y el paciente que recibió la factura.



Las tablas se relacionan mediante el uso de claves primarias y claves foráneas. Por ejemplo:

La tabla "medico" tiene claves foráneas "especialidad_id" y "localidad_id" que se relacionan con las tablas "especialidadmedica" y "localidad" respectivamente, para indicar la especialidad y la localidad del médico.
La tabla "consultorios" tiene una clave foránea "medico_id" que se relaciona con la tabla "medico" para indicar el médico asignado a ese consultorio.
La tabla "persona" tiene claves foráneas "localidad_id", "medico_cabecera_id" y "obra_social_id" que se relacionan con las tablas "localidad", "medico" y "obrasocial" respectivamente, para indicar la localidad, el médico de cabecera y la obra social de la persona (paciente).
La tabla "turno" tiene claves foráneas "doctor_id" y "paciente_id" que se relacionan con las tablas "medico" y "persona" respectivamente, para indicar el médico que atenderá el turno y la persona que tiene el turno asignado.
Estas relaciones permiten establecer vínculos entre los registros de las diferentes tablas y facilitan el acceso y la manipulación de los datos en la base de datos "clinica".



```

### Listado de Vistas:

```sh
Vista "vista_pacientes":

"Descripción": Esta vista muestra información de los pacientes que no tienen asignado un médico cabecera. Incluye el ID del paciente, nombre, apellido, edad y denominación de la obra social a la que pertenece.
"Objetivo": El objetivo de esta vista es identificar a los pacientes que no tienen asignado un médico cabecera para poder tomar medidas o asignarles uno en caso necesario.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "persona": Contiene información general de las personas, incluyendo pacientes. Se utiliza para obtener el ID, nombre, apellido y obra social del paciente.
Tabla "obrasocial": Contiene información sobre las obras sociales a las que pueden pertenecer los pacientes. Se utiliza para obtener la denominación de la obra social del paciente.


Vista "vista_empleados":

"Descripción": Esta vista muestra información de los empleados de la clínica, incluyendo su ID, nombre, apellido, puesto y nombre de la localidad en la que trabajan.
"Objetivo": El objetivo de esta vista es proporcionar una lista de los empleados de la clínica junto con información relevante, como su puesto y la localidad en la que se encuentran, lo cual puede ser útil para la gestión y organización interna de la clínica.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "empleado": Contiene información específica de los empleados de la clínica, como su ID, nombre, apellido y puesto.
Tabla "localidad": Contiene información de las localidades, incluyendo el nombre de cada una. Se utiliza para obtener el nombre de la localidad en la que trabaja cada empleado.


Vista "vista_turnos":

"Descripción": Esta vista muestra información de los turnos de la clínica, incluyendo el ID del turno, fecha, hora, indicador de si el turno ha sido atendido, nombre del paciente y nombre del médico asociado al turno.
"Objetivo": El objetivo de esta vista es brindar una visión general de los turnos programados en la clínica, incluyendo la información relevante de cada turno, como la fecha, hora, estado de atención y los nombres del paciente y médico asociados.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "turno": Contiene información específica de los turnos, como su ID, fecha, hora y estado de atención.
Tabla "persona": Utilizada para obtener el nombre del paciente asociado al turno.
Tabla "medico": Utilizada para obtener el nombre del médico asociado al turno.


Vista "vista_consultorios_disponibles":

"Descripción": Esta vista muestra información de los consultorios disponibles en la clínica, incluyendo su ID, nombre, indicador de ocupación y nombre del médico asociado en caso de estar ocupado.
"Objetivo": El objetivo de esta vista es identificar los consultorios que se encuentran disponibles en la clínica, es decir, aquellos que no están ocupados en un determinado momento. También muestra el médico asociado a cada consultorio en caso de estar ocupado, lo cual puede ser útil para gestionar la asignación de consultorios y su ocupación.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "consultorios": Contiene información de los consultorios de la clínica, incluyendo su ID, nombre y estado de ocupación.
Tabla "medico": Utilizada para obtener el nombre del médico asociado a cada consultorio ocupado.


Vista "vista_especialidades_medicas":

"Descripción": Esta vista muestra información de las especialidades médicas y subespecialidades, junto con la cantidad de médicos asociados a cada una.
"Objetivo": El objetivo de esta vista es brindar un resumen de las especialidades médicas y subespecialidades presentes en la clínica, así como la cantidad de médicos que se especializan en cada una. Esto puede ser útil para analizar la distribución de especialidades en la clínica y la disponibilidad de médicos en cada área.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "especialidadmedica": Contiene información de las especialidades médicas y subespecialidades, incluyendo su ID, nombre y subespecialidad.
Tabla "medico": Utilizada para contar la cantidad de médicos asociados a cada especialidad.


Vista "vista_pacientes_obrasociales":

"Descripción": Esta vista muestra información de los pacientes junto con la obra social a la que pertenecen, y la cantidad de pacientes asociados a cada obra social.
"Objetivo": El objetivo de esta vista es proporcionar una lista de los pacientes de la clínica junto con su obra social correspondiente, y además mostrar la cantidad de pacientes que pertenecen a cada obra social. Esta información puede ser útil para el análisis y seguimiento de la atención médica según la obra social de los pacientes.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "persona": Contiene información general de las personas, incluyendo pacientes. Se utiliza para obtener el ID, nombre y apellido del paciente.
Tabla "obrasocial": Contiene información sobre las obras sociales a las que pueden pertenecer los pacientes. Se utiliza para obtener la denominación de la obra social del paciente.


Vista "vista_tratamientos_paciente":

"Descripción": Esta vista muestra información de los tratamientos realizados a cada paciente, incluyendo el ID del tratamiento, nombre y apellido del paciente, nombre del médico que realizó el tratamiento y nombre del tratamiento realizado.
"Objetivo": El objetivo de esta vista es proporcionar una lista de los tratamientos realizados a cada paciente, incluyendo el nombre del paciente, el médico que realizó el tratamiento y el nombre del tratamiento realizado. Esto puede ser útil para el seguimiento de los tratamientos realizados a cada paciente.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "tratamiento": Contiene información de los tratamientos realizados a los pacientes, incluyendo su ID y nombre.
Tabla "persona": Utilizada para obtener el nombre y apellido del paciente asociado al tratamiento.
Tabla "medico": Utilizada para obtener el nombre del médico que realizó el tratamiento.


Vista "vista_diagnosticos_paciente":

"Descripción": Esta vista muestra información de los diagnósticos realizados a cada paciente, incluyendo el ID del diagnóstico, nombre y apellido del paciente, nombre del médico que realizó el diagnóstico y nombre del diagnóstico realizado.
"Objetivo": El objetivo de esta vista es proporcionar una lista de los diagnósticos realizados a cada paciente, incluyendo el nombre del paciente, el médico que realizó el diagnóstico y el nombre del diagnóstico realizado. Esto puede ser útil para el seguimiento de los diagnósticos realizados a cada paciente.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "diagnostico": Contiene información de los diagnósticos realizados a los pacientes, incluyendo su ID y nombre.
Tabla "persona": Utilizada para obtener el nombre y apellido del paciente asociado al diagnóstico.
Tabla "medico": Utilizada para obtener el nombre del médico que realizó el diagnóstico.


Vista "vista_consultas_medico":

"Descripción": Esta vista muestra información de las consultas realizadas por cada médico, incluyendo el ID de la consulta, nombre y apellido del paciente, nombre del médico que realizó la consulta y fecha de la consulta.
"Objetivo": El objetivo de esta vista es proporcionar una lista de las consultas realizadas por cada médico, incluyendo el nombre del paciente, la fecha de la consulta y el nombre del médico que realizó la consulta. Esto puede ser útil para el seguimiento de las consultas realizadas por cada médico.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "turno": Contiene información de las consultas realizadas por los médicos, incluyendo su ID y fecha.
Tabla "persona": Utilizada para obtener el nombre y apellido del paciente asociado a la consulta.
Tabla "medico": Utilizada para obtener el nombre del médico que realizó la consulta.


Vista "vista_empleados_con_vacaciones":

"Descripción": Esta vista muestra información de los empleados que tomaron vacaciones, incluyendo el ID del empleado, nombre y apellido, puesto y nombre de la localidad en la que trabaja.
"Objetivo": El objetivo de esta vista es proporcionar una lista de los empleados que tomaron vacaciones, incluyendo información relevante como su puesto y la localidad en la que se encuentran, lo cual puede ser útil para la gestión y organización interna de la clínica.
"Tablas que la componen": Esta vista está compuesta por las siguientes tablas:
Tabla "empleado": Contiene información específica de los empleados de la clínica, como su ID, nombre, apellido y puesto.
Tabla "localidad": Contiene información de las localidades, incluyendo el nombre de cada una. Se utiliza para obtener el nombre de la localidad en la que trabaja cada empleado.
Tabla "vacaciones": Contiene información de las vacaciones tomadas por los empleados, incluyendo su ID y fecha de inicio y fin.
Tabla "vacaciones_medico": Contiene información de las vacaciones tomadas por los médicos, incluyendo su ID y fecha de inicio y fin.



```

### Listado de Funciones:

```sh


Función "calcular_edad":

"Descripción": Esta función calcula la edad en años a partir de la fecha de nacimiento proporcionada como parámetro.
"Objetivo": El objetivo de esta función es facilitar el cálculo de la edad de una persona en años a partir de su fecha de nacimiento. Puede ser utilizada en consultas o procedimientos que requieran el cálculo de la edad de los pacientes.
"Tablas o datos que manipula": Esta función no manipula tablas ni datos directamente. Toma como parámetro la fecha de nacimiento de una persona y realiza el cálculo de la edad en base a la fecha actual.


Función "calcular_promedio_edad":

"Descripción": Esta función calcula el promedio de edad en años a partir de la fecha de nacimiento de todos los pacientes registrados en la tabla "persona".
"Objetivo": El objetivo de esta función es obtener el promedio de edad de todos los pacientes de la clínica, lo cual puede ser útil para realizar análisis estadísticos o monitorear la distribución de edades en la población atendida por la clínica.
"Tablas o datos que manipula": Esta función accede a la tabla "persona" para obtener la fecha de nacimiento de los pacientes y realizar el cálculo del promedio de edad.


Función "contar_medicos_subespecialidad":

"Descripción": Esta función cuenta la cantidad de médicos que tienen una subespecialidad específica.
"Objetivo": El objetivo de esta función es obtener el número de médicos que se especializan en una determinada subespecialidad médica. Esto puede ser útil para conocer la disponibilidad de médicos en una subespecialidad en particular o para realizar análisis estadísticos sobre la distribución de especialidades en el personal médico.
"Tablas o datos que manipula": Esta función accede a las tablas "medico" y "especialidadmedica" para realizar la consulta y obtener la cantidad de médicos que tienen una subespecialidad específica. Se realiza una unión (JOIN) entre estas dos tablas utilizando el ID de la especialidad en la tabla "medico" y el ID de la especialidad en la tabla "especialidadmedica".


Función "calcular_costo_total_tratamientos_paciente":

"Descripción": Esta función calcula el costo total de los tratamientos realizados a un paciente específico.
"Objetivo": El objetivo de esta función es obtener el costo total de los tratamientos realizados a un paciente específico. Esto puede ser útil para realizar análisis estadísticos sobre los costos de los tratamientos realizados a los pacientes.
"Tablas o datos que manipula": Esta función accede a las tablas "tratamiento" y "tratamiento_medico" para realizar la consulta y obtener el costo total de los tratamientos realizados a un paciente específico. Se realiza una unión (JOIN) entre estas dos tablas utilizando el ID del tratamiento en la tabla "tratamiento" y el ID del tratamiento en la tabla "tratamiento_medico".


Función buscar_pacientes_por_medico:

"Descripción": Esta función busca pacientes en función de su médico de cabecera. Toma como parámetro el ID del médico de cabecera y devuelve los nombres y apellidos de los pacientes que tienen ese médico de cabecera.
"Objetivo": El objetivo de esta función es facilitar la búsqueda de pacientes según su médico de cabecera. Esto puede ser útil para identificar rápidamente a los pacientes que están bajo el cuidado de un médico específico.
"Tablas o datos que manipula": Esta función accede a las tablas "persona" y "medico" para realizar la consulta. Se realiza una unión (JOIN) entre estas dos tablas utilizando el ID del médico de cabecera en la tabla "persona" y el ID del médico en la tabla "medico".




```

### Listado de Stored Procedures:

```sh


Stored Procedure "sp_OrdenarTabla":

"Descripción": Este stored procedure permite indicar el campo de ordenamiento de una tabla y el tipo de ordenamiento (ascendente o descendente) para ordenar los registros de la tabla especificada.
"Objetivo o beneficio": El objetivo de este stored procedure es facilitar la ordenación de los registros de una tabla de forma dinámica, permitiendo al usuario especificar el campo de ordenamiento y el tipo de ordenamiento deseado. Esto brinda flexibilidad y eficiencia al ordenar grandes conjuntos de datos en una tabla.
"Tablas o datos que manipulan": Este stored procedure no manipula directamente tablas ni datos. Toma como parámetros el nombre de la tabla, el campo de ordenamiento y el tipo de ordenamiento. Luego ejecuta una consulta dinámica para ordenar los registros de la tabla según los criterios especificados.


Stored Procedure "sp_InsertarEliminarRegistro":

"Descripción": Este stored procedure permite insertar registros en una tabla especificada y eliminar un registro específico de la misma tabla, según la operación y condiciones proporcionadas.
"Objetivo o beneficio": El objetivo de este stored procedure es proporcionar una funcionalidad conveniente para insertar nuevos registros y eliminar registros existentes de una tabla en el proyecto de la clínica. Esto simplifica las tareas comunes de inserción y eliminación de datos y ayuda a mantener la integridad y consistencia de los datos en la base de datos.
"Tablas o datos que manipulan": Este stored procedure manipula una tabla específica que se especifica como parámetro (p_tabla). Para la operación de inserción, se utiliza el valor de los parámetros p_valores para insertar los nuevos registros. Para la operación de eliminación, se utiliza el valor del parámetro p_condicion para identificar el registro que se debe eliminar.


Stored Procedure "sp_BuscarPacientesPorEspecialidad":

"Descripción": Este stored procedure busca pacientes en función de su especialidad médica. Toma como parámetro una especialidad médica y devuelve los nombres y apellidos de los pacientes que tienen un médico de cabecera con esa especialidad.
"Objetivo o beneficio": El objetivo de este stored procedure es facilitar la búsqueda de pacientes según una especialidad médica específica. Esto puede ser útil para identificar rápidamente a los pacientes que están bajo el cuidado de médicos especializados en una determinada área médica.
"Tablas o datos que manipulan": Este stored procedure accede a las tablas "persona", "medico" y "especialidadmedica" para realizar la consulta. Realiza un JOIN entre estas tablas para obtener los nombres y apellidos de los pacientes cuyo médico de cabecera tenga la especialidad médica especificada como parámetro.


Stored Procedure "sp_ActualizarRegistro":

"Descripción": Este stored procedure permite actualizar un registro específico de una tabla especificada, según los valores proporcionados.
"Objetivo o beneficio": El objetivo de este stored procedure es proporcionar una funcionalidad conveniente para actualizar registros existentes de una tabla en el proyecto de la clínica. Esto simplifica las tareas comunes de actualización de datos y ayuda a mantener la integridad y consistencia de los datos en la base de datos.
"Tablas o datos que manipulan": Este stored procedure manipula una tabla específica que se especifica como parámetro (p_tabla). Utiliza el valor del parámetro p_condicion para identificar el registro que se debe actualizar. Utiliza el valor del parámetro p_valores para actualizar los valores de los campos especificados en el registro identificado por p_condicion.


Stored Procedure "sp_TotalPacientesPorEspecialidad":

"Descripción": Este stored procedure calcula el total de pacientes que tienen un médico de cabecera con una especialidad médica específica.
"Objetivo o beneficio": El objetivo de este stored procedure es obtener el total de pacientes que tienen un médico de cabecera con una especialidad médica específica. Esto puede ser útil para realizar análisis estadísticos sobre la distribución de especialidades en la población atendida por la clínica.
"Tablas o datos que manipulan": Este stored procedure accede a las tablas "persona", "medico" y "especialidadmedica" para realizar la consulta. Realiza un JOIN entre estas tablas para obtener el total de pacientes cuyo médico de cabecera tenga la especialidad médica especificada como parámetro.


Stored Procedure "sp_CalcularCostoTratamientosPorPaciente":

"Descripción": Este stored procedure calcula el costo total de los tratamientos realizados a un paciente específico.
"Objetivo o beneficio": El objetivo de este stored procedure es obtener el costo total de los tratamientos realizados a un paciente específico. Esto puede ser útil para realizar análisis estadísticos sobre los costos de los tratamientos realizados a los pacientes.
"Tablas o datos que manipulan": Este stored procedure accede a las tablas "tratamiento" y "tratamiento_medico" para realizar la consulta y obtener el costo total de los tratamientos realizados a un paciente específico. Se realiza una unión (JOIN) entre estas dos tablas utilizando el ID del tratamiento en la tabla "tratamiento" y el ID del tratamiento en la tabla "tratamiento_medico".


Stored Procedure "sp_ConsultoriosOcupadosPorMedico":

"Descripción": Este stored procedure busca los consultorios ocupados por un médico específico. Toma como parámetro el ID del médico y devuelve los nombres y apellidos de los pacientes que tienen un turno asignado con ese médico.
"Objetivo o beneficio": El objetivo de este stored procedure es facilitar la búsqueda de consultorios ocupados por un médico específico. Esto puede ser útil para identificar rápidamente los consultorios ocupados por un médico en particular.
"Tablas o datos que manipulan": Este stored procedure accede a las tablas "turno", "persona" y "medico" para realizar la consulta. Realiza un JOIN entre estas tablas para obtener los nombres y apellidos de los pacientes que tienen un turno asignado con el médico especificado como parámetro.


```

### Detalles de la importación de datos

```sh



La importación de datos en el script se realiza utilizando la sentencia SQL LOAD DATA INFILE.
A continuación, se proporciona un detalle de cómo se realizan las importaciones en este script:

Importación de datos en la tabla "medico":
La sentencia LOAD DATA INFILE se utiliza para cargar datos desde un archivo CSV en la tabla "medico".
Se especifica la ruta del archivo CSV en la cláusula INFILE. En este caso, se utiliza "./medicos.csv". Nos Aseguramos de que la ruta del archivo sea correcta y accesible desde el servidor de la base de datos.
Se utiliza la cláusula FIELDS TERMINATED BY ',' para indicar que los campos en el archivo CSV están separados por comas.
Se utiliza la cláusula ENCLOSED BY '"' para indicar que los valores de los campos están encerrados entre comillas dobles.
La cláusula LINES TERMINATED BY '\n' se utiliza para indicar que cada registro en el archivo CSV está separado por una nueva línea.
La cláusula IGNORE 1 LINES se utiliza para ignorar la primera línea del archivo CSV, que generalmente contiene encabezados de columna.
Los datos del archivo CSV se asignan a las columnas correspondientes de la tabla "medico" según el orden en el archivo CSV.
Los nombres de las columnas en la tabla "medico" deben coincidir con los nombres de las columnas en el archivo CSV.
Antes de la importación, se desactiva temporalmente la restricción de clave foránea utilizando la sentencia SET FOREIGN_KEY_CHECKS = 0 para permitir la inserción de registros sin verificar las claves foráneas.
Después de la importación, se reactiva la restricción de clave foránea utilizando la sentencia SET FOREIGN_KEY_CHECKS = 1 para volver a habilitar la verificación de claves foráneas.


Es importante tener en cuenta lo siguiente:

Nos Aseguramos de que el archivo CSV contenga los datos en el formato correcto y coincida con la estructura de la tabla de destino.
Verificar que los nombres de las columnas en la tabla de destino coincidan con los nombres de las columnas en el archivo CSV.
Nos Aseguramos de que la ruta del archivo CSV sea correcta y accesible desde el servidor de la base de datos.
Si el archivo CSV utiliza un separador diferente de comas o un carácter de encerrado diferente de comillas dobles, debemos ajustar las cláusulas FIELDS TERMINATED BY y ENCLOSED BY en consecuencia.
Después de la importación, se puede realizar una consulta (SELECT) para visualizar los datos importados en la tabla "medico".

```

### Creacion de los Usuarios y Asignación de Permisos - Sublenguaje DCL:

```sh

El sublenguaje DCL (Data Control Language) se utiliza para controlar el acceso a los datos almacenados en la base de datos.

En este script, se utilizan las siguientes sentencias DCL:

CREATE USER: Se utiliza para crear un nuevo usuario de la base de datos.
GRANT: Se utiliza para otorgar privilegios a los usuarios de la base de datos.
REVOKE: Se utiliza para revocar privilegios a los usuarios de la base de datos.

```

### Modificaciones controladas mediante transacciones - Sublenguaje TCL:

```sh

El sublenguaje TCL (Transaction Control Language) se utiliza para controlar las transacciones en la base de datos.

En este script, se utilizan las siguientes sentencias TCL:

COMMIT: Se utiliza para confirmar los cambios realizados en la base de datos.
ROLLBACK: Se utiliza para deshacer los cambios realizados en la base de datos.
SAVEPOINT: Se utiliza para establecer un punto de guardado dentro de una transacción.

START TRANSACTION: Se utiliza para iniciar una transacción.
ROLLBACK TRANSACTION: Se utiliza para deshacer los cambios realizados en una transacción.
COMMIT TRANSACTION: Se utiliza para confirmar los cambios realizados en una transacción.

ROLLBACK TO SAVEPOINT: Se utiliza para deshacer los cambios realizados en una transacción hasta un punto de guardado específico.
REALEASE SAVEPOINT: Se utiliza para eliminar un punto de guardado de una transacción.


```

### Backup y Restore de la Base de Datos:

```sh
-- Para generar el backup de la base de datos clinica, usar el siguiente comando:

    mysqldump -u root -p [clinica] --no-create-info clinica > backup.sql

-- Base de datos: clinica
-- Archivo: backup.sql


-- Para restaurar la base de datos clinica, usar el siguiente comando:

    mysqldump -u root -p  [clinica] < backup.sql

```

### Workshop DCL y TCL

```sh
- Se crearon 3 usuarios:

Usuario1: Con permisos de lectura sobre determinadas tablas.
Usuario2: Con permisos de lectura y escritura sobre todas las tablas.
Usuario3: Con permisos de lectura y eliminación sobre todas las tablas.

- Se asignaron los permisos correspondientes a cada usuario sobre las tablas:

Usuario1 recibió permisos de lectura sobre las tablas "obrasocial" y "consultorios".
Usuario2 recibió permisos de lectura, inserción y actualización sobre todas las tablas del esquema "clinica".
Usuario3 recibió permisos de lectura y eliminación sobre todas las tablas del esquema "clinica".

- Se realizaron pruebas de los permisos otorgados mediante operaciones DML:

Usuario1 ejecutó una consulta SELECT sobre la tabla "obrasocial".
Usuario2 realizó operaciones de inserción, actualización y eliminación en las tablas "obrasocial" y "consultorios".
Usuario3 ejecutó una consulta SELECT sobre la tabla "consultorios" y eliminó registros de la tabla "consultorios".

- Se eliminó el Usuario3 y se transfirieron sus permisos al Usuario2:

Se revocaron todos los privilegios del Usuario3 sobre el esquema "clinica".
Se eliminó el Usuario3.
Se otorgaron permisos de lectura, inserción, actualización y eliminación al Usuario2 sobre todas las tablas del esquema "clinica".


```

<br>

### Scripts de la Base de Datos (Click en los siguientes enlaces):

<br>

- <a href="./tablas_create.sql"> Creacion de la Base de Datos </a><br>
- <a href="./insertar_datos.sql">Script de Inserción de Datos</a><br>
- <a href="./insert_external_data.sql">Script de Inserción de Datos Externos por Archivo</a><br>
- <a href="./vistas.sql">Creacion de las Vistas</a><br>
- <a href="./funciones.sql">Creacion de las Funciones</a><br>
- <a href="./stored_procedures.sql">Creacion de los Stored Procedures</a><br>
- <a href="./triggers.sql">Creacion de los Triggers</a><br>
- <a href="./consultas.sql">Consultas</a><br>
- <a href="./sentencias.sql">Creacion de los Usuarios y Asignación de Permisos</a><br>
- <a href="./tcl.sql">Modificaciones controladas mediante transacciones</a>
- <a href="./backup.sql">Visualizar el Backup de la Base de Datos</a>
- <a href="./workshop_tres.sql">Workshop DCL y TCL (Con creación de Usuarios y Asignación de Permisos)</a>
- <a href="./ER_diagram.pdf">Diagrama Entidad-Relación</a>
- <a href="./clinica.pdf">Script para Importar la Base de Datos</a>
  <br>

---

<br>

## Autor: Alejandro Daniel Di Stefano

### Comisión #43410 - CoderHouse

---
