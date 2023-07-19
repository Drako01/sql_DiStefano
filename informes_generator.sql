USE clinica;

-- Implementación de consultas SQL para generación de informes:

-- Consulta: Obtener el promedio de edad de los pacientes:
SELECT calcular_promedio_edad() AS promedio_edad;

-- Consulta: Contar la cantidad de médicos que tienen una subespecialidad determinada:
SELECT contar_medicos_subespecialidad('Cardiología') AS cantidad_medicos;

-- Consulta: Calcular el costo total de los tratamientos realizados a un paciente:
SELECT calcular_costo_total_tratamientos_paciente(1) AS costo_total_tratamientos;

-- Consulta: Buscar la lista de pacientes asociados a un médico:
SELECT buscar_pacientes_por_medico(1) AS lista_pacientes;

-- Consulta: Obtener el total de pacientes por especialidad médica:
CALL sp_TotalPacientesPorEspecialidad();

-- Consulta: Obtener los consultorios ocupados por un médico:
CALL sp_ConsultoriosOcupadosPorMedico(1);

